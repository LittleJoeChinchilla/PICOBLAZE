/* Copyright 2020 Jakub Wiczynski
 * MSc thesis - Implementation of DSP co-processor in Xilinx Zynq Soc - Politechnika Gdanska
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

`timescale 1ns/1ps

import risc_instruction_decode_pkg::*;
import risc_alu_pkg::*;

module risc_instruction_decode #(
	parameter WIDTH				  = 8,
	parameter RESET_VECTOR		  = 32'h0,
	parameter EXCEPTION_VECTOR	  = 32'd100,
	parameter INTERRUPT_VECTOR    = 32'd200,
	parameter C_RISC_IF			  = "SIMPLE",
	parameter C_RISC_SIMPLE_O_REG = 10,
	parameter C_RISC_NATIVE_O_REG = 10,
	parameter C_RISC_NATIVE_T_REG = 10,
	parameter MEM_WIDTH0_SELECTOR = "MEMORY", // "MEMORY" / "SHARED" / "DSP" / "SLAVE0" - "SLAVE6"
	parameter MEM_WIDTH1_SELECTOR = "MEMORY", // "MEMORY" / "SHARED" / "DSP" / "SLAVE0" - "SLAVE6"
	parameter MEM_WIDTH2_SELECTOR = "MEMORY", // "MEMORY" / "SHARED" / "DSP" / "SLAVE0" - "SLAVE6"
	parameter MEM_WIDTH3_SELECTOR = "MEMORY", // "MEMORY" / "SHARED" / "DSP" / "SLAVE0" - "SLAVE6"
	parameter MEM_WIDTH4_SELECTOR = "MEMORY", // "MEMORY" / "SHARED" / "DSP" / "SLAVE0" - "SLAVE6"
	parameter MEM_WIDTH5_SELECTOR = "MEMORY", // "MEMORY" / "SHARED" / "DSP" / "SLAVE0" - "SLAVE6"
	parameter MEM_WIDTH6_SELECTOR = "MEMORY", // "MEMORY" / "SHARED" / "DSP" / "SLAVE0" - "SLAVE6"
	parameter MEM_WIDTH7_SELECTOR = "MEMORY"  // "MEMORY" / "SHARED" / "DSP" / "SLAVE0" - "SLAVE6"
)(
    input               aclk,
    input               arstn,
    /* Instruction memory */
    output logic [12:0] instruction_address,
    input        [31:0] instruction_data,

    /* Data memory */
    output logic        memory_wr_en,
    output logic [12:0] memory_wr_address,
    output logic [ 7:0] memory_wr_data,
    output logic [12:0] memory_rd_address,
    input logic  [ 7:0] memory_rd_data,

    /* Registers */
    output logic [ 4:0] reg_in1_sel,
    input        [ 7:0] reg_in1,
    output logic [ 4:0] reg_in2_sel,
    input        [ 7:0] reg_in2,
    output logic [ 4:0] reg_out_sel,
    output logic [ 7:0] reg_out,

    /* ALU */
    output logic [ 7:0] alu_op_A,
    output logic [ 7:0] alu_op_B,
    input        [ 7:0] alu_op_S,
    output logic [ 5:0] alu_op_code,
    
    /* Interrupt */
    input				interrupt_pending,
    output logic		interrupt_acknowledge,
    output logic 		interrupt_enable,
    
    /* AXI */
    output logic [ 2:0] axi_slave_select,
    output logic [15:0] axi_offset,
    output logic		axi_rw,				// read = 1, write = 0
    output logic		axi_req,
    input				axi_ack,
    output logic [ 7:0] axi_data_in,
    input [ 7:0] 		axi_data_out,
    input				axi_error,
    
    /* SHARED MEM */
    output logic [15:0] shared_memory_address,
    output logic		shared_memory_wr_en,
    output logic [ 7:0] shared_memory_wr_data,
    input		 [ 7:0] shared_memory_rd_data,
    
    /* Simple IF */
    output logic		led,
    
    /* Native IF */
    output logic [ 7:0]	native_o,
    output logic [ 7:0] native_t
);
	
	logic [15:0] shared_wr_address;
	logic [15:0] shared_rd_address;
	
	assign shared_memory_address = shared_memory_wr_en ? shared_wr_address : shared_rd_address;
	
	logic exception_locked_access;
	
	logic break_pipe;
	logic axi_pipe;
	
	logic axi_pipe_ff[11:0];
	always_ff @ (posedge aclk or negedge arstn) begin
		if (!arstn) begin
			for (int i = 0; i <= 11; i++) axi_pipe_ff[i] <= 0;
		end
		else begin
			if (axi_pipe) begin
				axi_pipe_ff[0] <= 1;
				for (int i = 1; i <= 11; i++) axi_pipe_ff[i] <= axi_pipe_ff[i-1];
			end
			else begin
				for (int i = 0; i <= 11; i++) axi_pipe_ff[i] <= 0;
			end
		end
	end
	
	logic [15:0] pc_counter_arg_add;
	logic [15:0] pc_counter_arg_sub_1;
	logic [15:0] pc_counter_arg_sub_2;
	logic [15:0] pc_counter_arg_out;
	
	always_ff @ (posedge aclk or negedge arstn) begin
		if (!arstn) begin
			pc_counter_arg_out <= 0;
		end
		else begin
			pc_counter_arg_out <= pc_counter_arg_add - pc_counter_arg_sub_1 - pc_counter_arg_sub_2;
		end
	end	

	logic [15:0] pc_counter_out;
	logic [15:0] pc_counter_arg;
	logic pc_counter_en;
	
	always_ff @ (posedge aclk or negedge arstn) begin
		if (!arstn) begin
			pc_counter_out <= RESET_VECTOR;
		end
		else begin
			if (pc_counter_en) begin
				pc_counter_out <= pc_counter_out + 1 + pc_counter_arg;
			end
			else begin
				pc_counter_out <= pc_counter_out + pc_counter_arg;
			end
		end
	end
	
	logic srst;
	always_ff @ (posedge aclk or negedge arstn) begin
		if (!arstn) srst <= 1;
		else 		srst <= 0;
	end
	assign pc_counter_en = (break_pipe == 1 || axi_pipe == 1 || srst == 1) ? 1'b0 : 1'b1;
	
	logic 		 call_stack_pop_en;
	logic [12:0] call_stack_pop_data;
	logic 		 call_stack_push_en;
	logic [12:0] call_stack_push_data;
	
	logic [12:0] link_data;
	
	risc_stack #(
		.RISC_STACK_WIDTH 	(13),
		.RISC_STACK_DEPTH	(16)
	) risc_call_stack_inst (
		.clk		(aclk),
		.reset_n	(arstn),
		.pop_en		(call_stack_pop_en),
		.pop_data	(call_stack_pop_data),
		.pop_empty	(),
		.push_en	(call_stack_push_en),
		.push_data	(call_stack_push_data),
		.push_full	()
	);
    
    logic [12:0] instruction_address_ff [12:0];
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		for (int i = 0; i <= 12; i++) instruction_address_ff[i] <= RESET_VECTOR;
    	end
    	else begin
    		instruction_address_ff[0] <= instruction_address;
    		for (int i = 1; i <= 12; i++) instruction_address_ff[i] <= instruction_address_ff[i-1]; 
    	end
    end
    
    logic [7:0] alu_op_S_ff[1:0];
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		for (int i = 0; i <= 1; i++) alu_op_S_ff[i] <= '0;
    	end
    	else begin
    		alu_op_S_ff[0] <= alu_op_S;
    		for (int i = 1; i <= 1; i++) alu_op_S_ff[i] <= alu_op_S_ff[i-1];     		
    	end
    end    
    
    logic pending_irq;
    logic ack_irq;
    
    logic ack_irq_ff [12:0];
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		for (int i = 0; i <= 12; i++) ack_irq_ff[i] <= '0;
    	end
    	else begin
    		ack_irq_ff[0] <= ack_irq;
    		for (int i = 1; i <= 12; i++) ack_irq_ff[i] <= ack_irq_ff[i-1];     		
    	end
    end        
    
    risc_instruction_t			decoded_instr;
	risc_instruction_t 			instr;
	risc_instruction_t 			instr_ff;
	risc_instruction_t 			instr_ff2;
	risc_instruction_t 			instr_ff3;
	risc_instruction_t 			instr_ff4;
	risc_instruction_t 			instr_ff5;
	risc_instruction_t 			instr_ff6;
	risc_instruction_t 			instr_ff7;
	risc_instruction_t 			instr_ff8;
	
	// Atomic operation implementation
	
	logic [6:0] r_status [31:0];
	logic r_locked [31:0];
	genvar idx;
	generate
		for (idx = 0; idx < 32; idx++) begin
			assign r_locked[idx] = |r_status[idx];
			always_ff @ (posedge aclk or negedge arstn) begin
				if (!arstn) begin
					r_status[idx] <= '0;	
				end
				else begin
					for (int i = 1; i <= 6; i++) r_status[idx][i] <= r_status[idx][i-1];
				end
			end
		end
	endgenerate	
	
	
	// AXI / IRQ process
	
	logic 		 axi_wr_req;
	logic 		 axi_wr_ack;
	logic [ 2:0] axi_wr_slave_select;
	logic [15:0] axi_wr_offset;
	logic [ 7:0] axi_wr_data;
	logic		 axi_wr_error;
	logic 		 axi_rd_req;
	logic 		 axi_rd_ack;
	logic [ 2:0] axi_rd_slave_select;
	logic [15:0] axi_rd_offset;
	logic [ 7:0] axi_rd_data;
	logic		 axi_rd_error;	  
	
	always_ff @ (posedge aclk or negedge arstn) begin
		if (!arstn) begin
			break_pipe 			 	<= 0;
			interrupt_acknowledge	<= 0;
			pending_irq 			<= 0;			
			axi_req			 <= 0;
			axi_rw			 <= 0;
			axi_slave_select <= '0;
			axi_offset		 <= '0;
			axi_data_in		 <= '0;	
			axi_wr_ack 		 <= 0;
			axi_wr_error	 <= '0;	
			axi_rd_ack		 <= 0;
			axi_rd_data		 <= '0;
			axi_rd_error	 <= '0;		
		end
		else begin
			//---- IRQ ----//
			if (interrupt_pending && !interrupt_acknowledge) begin
				interrupt_acknowledge <= 1;
			end
			else if (!interrupt_pending && interrupt_acknowledge) begin
				interrupt_acknowledge <= 0;
			end
			//-------------//
			if (pending_irq) begin
				if (ack_irq) begin
					pending_irq <= 0;
				end
			end
			else begin
				if (interrupt_pending && interrupt_acknowledge) begin
					pending_irq <= 1;
				end				
			end
			//-------------//
			
			//---- AXI ----//
			if (!axi_req && !axi_ack && axi_wr_req) begin
				axi_req			 <= 1;
				axi_rw			 <= 0;
				axi_slave_select <= axi_wr_slave_select;
				axi_offset		 <= axi_wr_offset;
				axi_data_in		 <= axi_wr_data;			
				axi_wr_ack 		 <= 0;
				axi_wr_error	 <= '0;	
				axi_rd_ack		 <= 0;
				axi_rd_data		 <= '0;
				axi_rd_error	 <= 0;				
			end
			else if (!axi_req && !axi_ack && axi_rd_req) begin
				axi_req			 <= 1;	
				axi_rw			 <= 1;
				axi_slave_select <= axi_rd_slave_select;
				axi_offset		 <= axi_rd_offset;
				axi_data_in		 <= '0;
				axi_wr_ack 		 <= 0;
				axi_wr_error	 <= '0;	
				axi_rd_ack		 <= 0;
				axi_rd_data		 <= '0;
				axi_rd_error	 <= 0;						
			end
			else if (axi_req && axi_ack && !axi_rw) begin
				axi_req			 <= 0;
				axi_rw			 <= 0;
				axi_slave_select <= '0;
				axi_offset		 <= '0;
				axi_data_in		 <= '0;			
				axi_wr_ack 		 <= 1;
				axi_wr_error	 <= axi_error;
				axi_rd_ack		 <= 0;
				axi_rd_data		 <= '0;
				axi_rd_error	 <= 0;						
			end
			else if (axi_req && axi_ack && axi_rw) begin
				axi_req			 <= 0;
				axi_rw			 <= 0;
				axi_slave_select <= '0;
				axi_offset		 <= '0;
				axi_data_in		 <= '0;	
				axi_wr_ack 		 <= 0;
				axi_wr_error	 <= '0;					
				axi_rd_ack		 <= 1;
				axi_rd_data		 <= axi_data_out;
				axi_rd_error	 <= axi_error;
			end
			else if (axi_wr_ack) begin
				axi_req			 <= 0;
				axi_rw			 <= 0;
				axi_slave_select <= '0;
				axi_offset		 <= '0;
				axi_data_in		 <= '0;	
				axi_wr_ack 		 <= 0;
				axi_wr_error	 <= '0;							
			end
			else if (axi_rd_ack) begin
				axi_req			 <= 0;
				axi_rw			 <= 0;
				axi_slave_select <= '0;
				axi_offset		 <= '0;
				axi_data_in		 <= '0;					
				axi_rd_ack		 <= 0;
				axi_rd_data		 <= '0;
				axi_rd_error	 <= '0;				
			end

			//-------------//
			if (!break_pipe) begin
				if (interrupt_pending && interrupt_acknowledge) break_pipe <= 1;
			end
			else begin
				if (ack_irq_ff[5]) break_pipe <= 0;
			end
			//-------------//
		end
	end

    /* PIPELINE: FETCH INSTRUCTION->DECODE INSTRUCTION->GET REGISTERS->DO OPERATION (ALU,MEM R/W)->SET REGISTERS*/
    logic [11:0] pipe_valid;    
    always_ff @ (posedge aclk or negedge arstn) begin
        if (!arstn) begin
	        for (int i = 0; i < 12; i++) pipe_valid[i] <= 1'b0;
        end
        else begin
        	if (break_pipe) begin
        		pipe_valid[0] <= 0;
        		for (int i = 0; i < 11; i++) pipe_valid[i+1] <= pipe_valid[i];
        	end
        	else if (axi_pipe) begin
        		pipe_valid[0] <= 0;
        		pipe_valid[1] <= 0;
        		for (int i = 1; i < 11; i++) pipe_valid[i+1] <= pipe_valid[i];        		
        	end
        	else begin
        		pipe_valid[0] <= 1'b1;
        		for (int i = 0; i < 11; i++) pipe_valid[i+1] <= pipe_valid[i];
        	end
        end
    end
  
    // Set PC increment value (next instruction or jump) ... pipe_valid = 0
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		pc_counter_arg <= 0;
    	end
    	else begin
    		if (pipe_valid[11] && pc_counter_en) begin
    			if (instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_B) begin
    				if (alu_op_S_ff[1]) begin
    					pc_counter_arg <= pc_counter_arg_out;   	
    				end
    				else pc_counter_arg <= 0;
    			end
    			else if (instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_J || instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_RAS) begin
    				pc_counter_arg <= pc_counter_arg_out;  				
    			end
    			else pc_counter_arg <= 0;    			
    		end
    		else begin
    			if (ack_irq_ff[5]) begin
    				pc_counter_arg <= pc_counter_arg_out; 
    			end
    			else begin
    				pc_counter_arg <= 0;
    			end    			
    		end
    	end
    end
    
    // Set instruction address = PC ... pipe_valid[0] = 1
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    	 	instruction_address <= RESET_VECTOR;
    	end
    	else begin
    		if (pipe_valid[0]) begin
    			instruction_address <= pc_counter_out[12:0];
    		end
    	end
    end
    
    // Wait for instruction memory latch address ... pipe_valid[1] = 1
    
    // Receive instruction data and decode ... pipe_valid[2] = 1
    logic [7:0] reg_in1_ff[5:0];
    logic [7:0] reg_in2_ff[5:0];   
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		for (int i = 0; i <= 5; i++) begin
    			reg_in1_ff[i] <= '0;
    			reg_in2_ff[i] <= '0;    			
    		end
    	end	
    	else begin
    		reg_in1_ff[0] <= reg_in1;
    		reg_in2_ff[0] <= reg_in2;    		
    		for (int i = 1; i <= 5; i++) begin
    			reg_in1_ff[i] <= reg_in1_ff[i-1];
    			reg_in2_ff[i] <= reg_in2_ff[i-1];   			
    		end
    	end
    end	
    
    logic [7:0] axi_reg_out;
    
    always_ff @ (posedge aclk or negedge arstn) begin
		if (!arstn) begin
			axi_reg_out <= 0;
			axi_pipe <= 0;
			get_risc_instruction('0, instr);
			get_risc_instruction('0, instr_ff);
			get_risc_instruction('0, instr_ff2);
			get_risc_instruction('0, instr_ff3);
			get_risc_instruction('0, instr_ff4);
			get_risc_instruction('0, instr_ff5);
			get_risc_instruction('0, instr_ff6);
			get_risc_instruction('0, instr_ff7);
			get_risc_instruction('0, instr_ff8);
			exception_locked_access <= 1'b0;
		end
		else begin
			if (pipe_valid[2]) begin					
				// RS1 or RS2 locked
				if ( (get_risc_instruction_rs1(instruction_data) && r_locked[get_risc_instruction_rs1(instruction_data)]) ||
					 (get_risc_instruction_rs2(instruction_data) && r_locked[get_risc_instruction_rs2(instruction_data)]) ) begin		
				 	get_risc_instruction('0, decoded_instr);
				 	exception_locked_access <= 1'b1;
				 	for (int i = 0; i < 32; i++) r_status[i][0] <= 1'b0;
					// synthesis translate_off
				 	if ((get_risc_instruction_rs1(instruction_data) && r_locked[get_risc_instruction_rs1(instruction_data)]) &&
				 		(get_risc_instruction_rs2(instruction_data) && r_locked[get_risc_instruction_rs2(instruction_data)]) ) begin
				 		$display("* RISC INSTRUCTION DECODE : Warning! RS1 : R%0d and RS2 : R%0d LOCKED! Instruction forced to NOP", 	
				 		get_risc_instruction_rs1(instruction_data), get_risc_instruction_rs2(instruction_data));
				 	end
				 	else if (get_risc_instruction_rs1(instruction_data) && r_locked[get_risc_instruction_rs1(instruction_data)]) begin
				 		$display("* RISC INSTRUCTION DECODE : Warning! RS1 : R%0d LOCKED! Instruction forced to NOP", 	
				 				get_risc_instruction_rs1(instruction_data));				 	
				 	end
				 	else if (get_risc_instruction_rs2(instruction_data) && r_locked[get_risc_instruction_rs2(instruction_data)]) begin
				 		$display("* RISC INSTRUCTION DECODE : Warning! RS2 : R%0d LOCKED! Instruction forced to NOP", 	
				 				get_risc_instruction_rs2(instruction_data));				 		
				 	end
				 	// synthesis translate_on
				end
				// synthesis translate_off
				else if( axi_pipe && instruction_data != 32'h0) begin
					$display("* RISC INSTRUCTION DECODE : Warning! Pending AXI instruction! 3 instructions after AXI request must be NOP!");
				end
				// synthesis translate_on
				else begin
					get_risc_instruction(instruction_data, decoded_instr);
					exception_locked_access <= 1'b0;
					for (int i = 0; i < 32; i++) begin
						if (get_risc_instruction_rd(instruction_data) && i == get_risc_instruction_rd(instruction_data)) 	r_status[i][0] <= 1'b1;
						else			   																					r_status[i][0] <= 1'b0;
					end
				end
				instr		<= decoded_instr;
			end
			
			instr_ff 	<= instr;
			instr_ff2 	<= instr_ff;
			instr_ff3 	<= instr_ff2;
			instr_ff4 	<= instr_ff3;
			instr_ff5 	<= instr_ff4;
			instr_ff6 	<= instr_ff5;
			instr_ff7 	<= instr_ff6;
			instr_ff8 	<= instr_ff7;
				
			if (!axi_pipe && pipe_valid[3]) begin
				if (instr.opcode == RISC_INSTRUCTION_OPCODE_L || instr.opcode  == RISC_INSTRUCTION_OPCODE_S) begin
					case (instr.func3)
						RISC_INSTRUCTION_FUNC3_0: begin
							if (MEM_WIDTH0_SELECTOR == "SLAVE0" ||
								MEM_WIDTH0_SELECTOR == "SLAVE1" ||
								MEM_WIDTH0_SELECTOR == "SLAVE2" ||
								MEM_WIDTH0_SELECTOR == "SLAVE3" ||
								MEM_WIDTH0_SELECTOR == "SLAVE4" ||
								MEM_WIDTH0_SELECTOR == "SLAVE5") begin
								axi_pipe <= 1;
								axi_reg_out <= instr.rd;								
							end
						end
						RISC_INSTRUCTION_FUNC3_1: begin
							if (MEM_WIDTH1_SELECTOR == "SLAVE0" ||
								MEM_WIDTH1_SELECTOR == "SLAVE1" ||
								MEM_WIDTH1_SELECTOR == "SLAVE2" ||
								MEM_WIDTH1_SELECTOR == "SLAVE3" ||
								MEM_WIDTH1_SELECTOR == "SLAVE4" ||
								MEM_WIDTH1_SELECTOR == "SLAVE5") begin
								axi_pipe <= 1;
								axi_reg_out <= instr.rd;								
							end
						end
						RISC_INSTRUCTION_FUNC3_2: begin
							if (MEM_WIDTH2_SELECTOR == "SLAVE0" ||
								MEM_WIDTH2_SELECTOR == "SLAVE1" ||
								MEM_WIDTH2_SELECTOR == "SLAVE2" ||
								MEM_WIDTH2_SELECTOR == "SLAVE3" ||
								MEM_WIDTH2_SELECTOR == "SLAVE4" ||
								MEM_WIDTH2_SELECTOR == "SLAVE5") begin
								axi_pipe <= 1;
								axi_reg_out <= instr.rd;								
							end
						end
						RISC_INSTRUCTION_FUNC3_3: begin
							if (MEM_WIDTH3_SELECTOR == "SLAVE0" ||
								MEM_WIDTH3_SELECTOR == "SLAVE1" ||
								MEM_WIDTH3_SELECTOR == "SLAVE2" ||
								MEM_WIDTH3_SELECTOR == "SLAVE3" ||
								MEM_WIDTH3_SELECTOR == "SLAVE4" ||
								MEM_WIDTH3_SELECTOR == "SLAVE5") begin
								axi_pipe <= 1;
								axi_reg_out <= instr.rd;								
							end
						end	
						RISC_INSTRUCTION_FUNC3_4: begin
							if (MEM_WIDTH4_SELECTOR == "SLAVE0" ||
								MEM_WIDTH4_SELECTOR == "SLAVE1" ||
								MEM_WIDTH4_SELECTOR == "SLAVE2" ||
								MEM_WIDTH4_SELECTOR == "SLAVE3" ||
								MEM_WIDTH4_SELECTOR == "SLAVE4" ||
								MEM_WIDTH4_SELECTOR == "SLAVE5") begin
								axi_pipe <= 1;
								axi_reg_out <= instr.rd;								
							end
						end
						RISC_INSTRUCTION_FUNC3_5: begin
							if (MEM_WIDTH5_SELECTOR == "SLAVE0" ||
								MEM_WIDTH5_SELECTOR == "SLAVE1" ||
								MEM_WIDTH5_SELECTOR == "SLAVE2" ||
								MEM_WIDTH5_SELECTOR == "SLAVE3" ||
								MEM_WIDTH5_SELECTOR == "SLAVE4" ||
								MEM_WIDTH5_SELECTOR == "SLAVE5") begin
								axi_pipe <= 1;
								axi_reg_out <= instr.rd;								
							end
						end
						RISC_INSTRUCTION_FUNC3_6: begin
							if (MEM_WIDTH6_SELECTOR == "SLAVE0" ||
								MEM_WIDTH6_SELECTOR == "SLAVE1" ||
								MEM_WIDTH6_SELECTOR == "SLAVE2" ||
								MEM_WIDTH6_SELECTOR == "SLAVE3" ||
								MEM_WIDTH6_SELECTOR == "SLAVE4" ||
								MEM_WIDTH6_SELECTOR == "SLAVE5") begin
								axi_pipe <= 1;
								axi_reg_out <= instr.rd;								
							end
						end
						RISC_INSTRUCTION_FUNC3_7: begin
							if (MEM_WIDTH7_SELECTOR == "SLAVE0" ||
								MEM_WIDTH7_SELECTOR == "SLAVE1" ||
								MEM_WIDTH7_SELECTOR == "SLAVE2" ||
								MEM_WIDTH7_SELECTOR == "SLAVE3" ||
								MEM_WIDTH7_SELECTOR == "SLAVE4" ||
								MEM_WIDTH7_SELECTOR == "SLAVE5") begin
								axi_pipe <= 1;
								axi_reg_out <= instr.rd;								
							end
						end						
					endcase
				end
			end
			else begin
				if (axi_wr_ack || axi_rd_ack) begin
					axi_pipe <= 0;
				end
			end
		end
	end
	
    always_ff @ (posedge aclk or negedge arstn) begin
        if (!arstn) begin
            reg_in1_sel <= '0;
            reg_in2_sel <= '0;
        end
        else begin
        	if (pipe_valid[3]) begin
            	if ( (instr.opcode == RISC_INSTRUCTION_OPCODE_R) || (instr.opcode == RISC_INSTRUCTION_OPCODE_S) || (instr.opcode == RISC_INSTRUCTION_OPCODE_B)) begin       // OPCODE : R, S
                    reg_in1_sel <= instr.rs1;
                    reg_in2_sel <= instr.rs2;
                end
                else if (instr.opcode == RISC_INSTRUCTION_OPCODE_I || instr.opcode == RISC_INSTRUCTION_OPCODE_L) begin  // OPCODE : I, L
                    reg_in1_sel <= instr.rs1;
                    reg_in2_sel <= '0;
                end
                else begin
                    reg_in1_sel <= '0;
                    reg_in2_sel <= '0;
                end
            end
            else begin
            	reg_in1_sel <= '0;
            	reg_in2_sel <= '0;            		
            end
        end
    end
    
    // Get RAS data - fetch - pipe_valid[3] = 1, instr valid
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		call_stack_pop_en <= 0;
    	end
    	else begin
    		if (pipe_valid[3]) begin
    			if (instr.opcode == RISC_INSTRUCTION_OPCODE_RAS && instr.rs1 == 1) begin
    				call_stack_pop_en <= 1;
    			end
    			else begin
    				call_stack_pop_en <= 0;
    			end
    		end
    	end
    end
    
    // Wait for Rs1, Rs2, RAS address latch - pipe_valid[4] = 1, instr_ff valid
    
    // Set ALU operands - pipe_valid[5] = 1, instr_ff2 valid
    
    always_ff @ (posedge aclk or negedge arstn) begin
        if (!arstn) begin
            alu_op_A    		<= '0;
            alu_op_B    		<= '0;
            alu_op_code 		<= '0;
        end
        else begin
            if (pipe_valid[5]) begin
                if (instr_ff2.opcode == RISC_INSTRUCTION_OPCODE_R) begin // OPCODE : R
                    alu_op_A    <= reg_in1;
                    alu_op_B    <= reg_in2;
	                case (instr_ff2.func7)
						RISC_INSTRUCTION_FUNC7_ARITHMETIC: begin
							case (instr_ff2.func3)
								RISC_INSTRUCTION_FUNC3_0:	alu_op_code <= (OP_ADD);
								RISC_INSTRUCTION_FUNC3_1:	alu_op_code <= (OP_SUB);
								RISC_INSTRUCTION_FUNC3_2:	alu_op_code <= (OP_MUL);
								RISC_INSTRUCTION_FUNC3_3:	alu_op_code <= (OP_DIV);
								default:					alu_op_code <= '0;
							endcase
						end
						RISC_INSTRUCTION_FUNC7_LOGIC: begin
							case (instr_ff2.func3)
								RISC_INSTRUCTION_FUNC3_0:	alu_op_code <= (OP_AND);
								RISC_INSTRUCTION_FUNC3_1:	alu_op_code <= (OP_OR);
								RISC_INSTRUCTION_FUNC3_2:	alu_op_code <= (OP_XOR);
								default:					alu_op_code <= '0;
							endcase
						end			
						RISC_INSTRUCTION_FUNC7_SHIFT_ARITHMETIC: begin
							case (instr_ff2.func3)
								RISC_INSTRUCTION_FUNC3_0:	alu_op_code <= (OP_SLA);
								RISC_INSTRUCTION_FUNC3_1:	alu_op_code <= (OP_SRA);
								default:					alu_op_code <= '0;
							endcase
						end	
						RISC_INSTRUCTION_FUNC7_SHIFT_LOGIC: begin
							case (instr_ff2.func3)
								RISC_INSTRUCTION_FUNC3_0:	alu_op_code <= (OP_SLL);
								RISC_INSTRUCTION_FUNC3_1:	alu_op_code <= (OP_SRL);
								default:					alu_op_code <= '0;
							endcase
						end 		
						RISC_INSTRUCTION_FUNC7_COMPARE: begin
							case (instr_ff2.func3)
								RISC_INSTRUCTION_FUNC3_0:	alu_op_code <= (OP_SLT);
								RISC_INSTRUCTION_FUNC3_1:	alu_op_code <= (OP_SLTU);
								RISC_INSTRUCTION_FUNC3_2:	alu_op_code <= (OP_SGT);
								RISC_INSTRUCTION_FUNC3_3:	alu_op_code <= (OP_SGTU);
								RISC_INSTRUCTION_FUNC3_4:	alu_op_code <= (OP_SEQ);
								RISC_INSTRUCTION_FUNC3_5:	alu_op_code <= (OP_SNE);
								default:					alu_op_code <= '0;
							endcase
						end			
						RISC_INSTRUCTION_FUNC7_UNDEFINED: begin
							
						end
	                endcase
                end
                else if (instr_ff2.opcode == RISC_INSTRUCTION_OPCODE_I) begin // OPCODE : I
	                alu_op_A <= reg_in1;
	                alu_op_B <= instr_ff2.func3 == RISC_INSTRUCTION_FUNC3_3 ? { { (3){instr_ff2.arg[4]} }, instr_ff2.arg[4:0]} : instr_ff2.arg[7:0];
					case (instr_ff2.func3)
						RISC_INSTRUCTION_FUNC3_0:	alu_op_code <= (OP_ADD);
						RISC_INSTRUCTION_FUNC3_1:	alu_op_code <= (OP_SLA);
						RISC_INSTRUCTION_FUNC3_2:	alu_op_code <= (OP_SLL);
						RISC_INSTRUCTION_FUNC3_3: begin
							case (instr_ff2.arg[11:5])
								7'd0:		alu_op_code <= (OP_SLL);
								7'd1:		alu_op_code <= (OP_SRL);
								7'd2:		alu_op_code <= (OP_SLA);
								7'd3:		alu_op_code <= (OP_SRA);
								default:	alu_op_code <= '0;
							endcase
						end
						RISC_INSTRUCTION_FUNC3_4:	alu_op_code <= (OP_AND);
						RISC_INSTRUCTION_FUNC3_5:	alu_op_code <= (OP_OR);
						RISC_INSTRUCTION_FUNC3_6:	alu_op_code <= (OP_XOR);
						default:					alu_op_code <= '0;
					endcase	   
                end
                else if (instr_ff2.opcode == RISC_INSTRUCTION_OPCODE_S || instr_ff2.opcode == RISC_INSTRUCTION_OPCODE_L) begin
                    alu_op_A    		<= reg_in1;
                    alu_op_B    		<= { 1'b0, instr_ff2.arg[6:0] };
                    alu_op_code 		<= OP_ADD;
                end
                else if (instr_ff2.opcode == RISC_INSTRUCTION_OPCODE_B) begin
					alu_op_A    		<= reg_in1;
                    alu_op_B    		<= reg_in2;
	                case (instr_ff2.func3)
		                RISC_INSTRUCTION_FUNC3_0:	alu_op_code <= OP_SEQ;	//BEQ
		                RISC_INSTRUCTION_FUNC3_1:	alu_op_code <= OP_SNE;	//BNE
		                RISC_INSTRUCTION_FUNC3_2:	alu_op_code <= OP_SLT;	//BLT
		                RISC_INSTRUCTION_FUNC3_3:	alu_op_code <= OP_SLTU;	//BLTU
		                RISC_INSTRUCTION_FUNC3_4:	alu_op_code <= OP_SGT;	//BGE
		                RISC_INSTRUCTION_FUNC3_5:	alu_op_code <= OP_SGTU;	//BGEU
		                default:					alu_op_code <= '0;
	                endcase
                end
                else begin
                    alu_op_A    		<= '0;
                    alu_op_B    		<= '0;
                    alu_op_code 		<= '0;
                end
            end
        end
    end
    	
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		pc_counter_arg_add 	 <= '0;
    		pc_counter_arg_sub_1 <= '0;
    		pc_counter_arg_sub_2 <= '0;
    		ack_irq 			 <= 0;
    	end
    	else begin
    		if (pipe_valid[5]) begin
    			ack_irq <= 0;
	    		if (instr_ff2.opcode == RISC_INSTRUCTION_OPCODE_B) begin
	    			pc_counter_arg_add   <= instr_ff2.arg;
	    			pc_counter_arg_sub_1 <= 0;
	    			pc_counter_arg_sub_2 <= 12;                       			
	    		end
		    	else if (instr_ff2.opcode == RISC_INSTRUCTION_OPCODE_J) begin
		    		pc_counter_arg_add	 <= instr_ff2.arg;
	    			pc_counter_arg_sub_1 <= 0;
	    			pc_counter_arg_sub_2 <= 12;                         		
		    	end                
		    	else if (instr_ff2.opcode == RISC_INSTRUCTION_OPCODE_RAS) begin
		    		if (instr_ff2.rs1 == 1) begin
		    			pc_counter_arg_add	 <= call_stack_pop_data;
		    			pc_counter_arg_sub_1 <= instruction_address_ff[3];
		    			pc_counter_arg_sub_2 <= 13;   	    		                        		
		    		end
		    		else if (instr_ff2.rs1 == 5) begin
		    			pc_counter_arg_add	 <= link_data;
		    			pc_counter_arg_sub_1 <= instruction_address_ff[3];
		    			pc_counter_arg_sub_2 <= 13;                   		
		    		end
		    		else begin
		    			pc_counter_arg_add	 <= instr_ff2.arg;
		    			pc_counter_arg_sub_1 <= 0;
		    			pc_counter_arg_sub_2 <= 12;                       		
		    		end	
		  		end
	  		end
	  		else begin
	  			if (pending_irq && !ack_irq) begin
	  				pc_counter_arg_add	 <= INTERRUPT_VECTOR; // INTERRUPT VECTOR
	  				pc_counter_arg_sub_1 <= instruction_address_ff[3];
	  				pc_counter_arg_sub_2 <= 1;   	 
	  				ack_irq 		     <= 1;
	  			end
	  			else begin
	  				ack_irq 			 <= 0;
	  			end
	  		end
    	end
    end
    
    // Wait for alu operands latch -  pipe_valid[6] = 1, instr_ff3 valid
    
    // Wait for alu output pipeline - pipe_valid[7] = 1, instr_ff4 valid
    
    // Wait for alu output set - pipe_valid[8] = 1, instr_ff5 valid
    
    // Set Read Data Memory address - pipe_valid[9] = 1, instr_ff6 valid

    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		memory_rd_address 	<= '0;    
    		shared_rd_address	<= 0;
    	end
    	else begin
    		if (pipe_valid[9]) begin
    			if (instr_ff6.opcode == RISC_INSTRUCTION_OPCODE_L) begin
    				case (instr_ff6.func3)
    					RISC_INSTRUCTION_FUNC3_0: begin
	    					if (MEM_WIDTH0_SELECTOR == "MEMORY") begin
	    						memory_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
    							shared_rd_address	<= 0;
	    					end
	    					else if (MEM_WIDTH0_SELECTOR == "SHARED") begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
	    					end
	    					else begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= 0;
	    					end
    					end
    					RISC_INSTRUCTION_FUNC3_1: begin
	    					if (MEM_WIDTH1_SELECTOR == "MEMORY") begin
		    					memory_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
		    					shared_rd_address	<= 0;
	    					end
	    					else if (MEM_WIDTH1_SELECTOR == "SHARED") begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
	    					end
	    					else begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= 0;
	    					end
    					end
    					RISC_INSTRUCTION_FUNC3_2: begin
	    					if (MEM_WIDTH2_SELECTOR == "MEMORY") begin
	    						memory_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
	    						shared_rd_address	<= 0;
	    					end
	    					else if (MEM_WIDTH2_SELECTOR == "SHARED") begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
	    					end
	    					else begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= 0;
	    					end    						
    					end
    					RISC_INSTRUCTION_FUNC3_3: begin
	    					if (MEM_WIDTH3_SELECTOR == "MEMORY") begin
	    						memory_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
	    						shared_rd_address	<= 0;
	    					end
	    					else if (MEM_WIDTH3_SELECTOR == "SHARED") begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
	    					end
	    					else begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= 0;
	    					end     						
    					end
    					RISC_INSTRUCTION_FUNC3_4: begin
	    					if (MEM_WIDTH4_SELECTOR == "MEMORY") begin
	    						memory_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
	    						shared_rd_address	<= 0;
	    					end
	    					else if (MEM_WIDTH4_SELECTOR == "SHARED") begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
	    					end
	    					else begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= 0;
	    					end      						
    					end
    					RISC_INSTRUCTION_FUNC3_5: begin
	    					if (MEM_WIDTH5_SELECTOR == "MEMORY") begin
	    						memory_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
	    						shared_rd_address	<= 0;
	    					end
	    					else if (MEM_WIDTH5_SELECTOR == "SHARED") begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
	    					end
	    					else begin
	    						memory_rd_address	<= 0;
	    						shared_rd_address	<= 0;
	    					end      						
    					end
    					RISC_INSTRUCTION_FUNC3_6: begin
    						if (MEM_WIDTH6_SELECTOR == "MEMORY") begin
    							memory_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
    							shared_rd_address	<= 0;
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SHARED") begin
    							memory_rd_address	<= 0;
    							shared_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
    						end
    						else begin
    							memory_rd_address	<= 0;
    							shared_rd_address	<= 0;
    						end      						
    					end
    					RISC_INSTRUCTION_FUNC3_7: begin
    						if (MEM_WIDTH7_SELECTOR == "MEMORY") begin
    							memory_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
    							shared_rd_address	<= 0;
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SHARED") begin
    							memory_rd_address	<= 0;
    							shared_rd_address	<= reg_in1_ff[3] + instr_ff6.arg;	
    						end
    						else begin
    							memory_rd_address	<= 0;
    							shared_rd_address	<= 0;
    						end      						
    					end
    				endcase  				
    			end
    			else begin
    				memory_rd_address 	<= '0;	     	
    				shared_rd_address	<= '0;
    			end
    		end
    		else begin
    			memory_rd_address 	<= '0;	     	
    			shared_rd_address	<= '0;
    		end    		
    	end
    end
    
    // Wait for Read Data Memory data - pipe_valid[10] = 1, instr_ff7 valid

    // Set registers - pipe_valid[11] = 1, instr_ff8 valid

    // AXI
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		axi_rd_req			<= 0;
    		axi_rd_slave_select <= '0;
    		axi_rd_offset		<= '0;	
    		axi_wr_req			<= 0;
    		axi_wr_slave_select <= '0;
    		axi_wr_offset		<= '0;	
    		axi_wr_data			<= '0;	  
    	end
    	else begin
    		if (axi_pipe_ff[4] && !axi_pipe_ff[5]) begin    			
    			if (instr_ff6.opcode == RISC_INSTRUCTION_OPCODE_L) begin
    				case (instr_ff6.func3)
    					RISC_INSTRUCTION_FUNC3_0: begin
    						if 		(MEM_WIDTH0_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 0;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	
    						end
    						else if (MEM_WIDTH0_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 1;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH0_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 2;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH0_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 3;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH0_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 4;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH0_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 5;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end
    					end
    					RISC_INSTRUCTION_FUNC3_1: begin
    						if 		(MEM_WIDTH1_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 0;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	
    						end
    						else if (MEM_WIDTH1_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 1;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH1_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 2;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH1_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 3;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH1_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 4;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH1_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 5;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end
    					end
    					RISC_INSTRUCTION_FUNC3_2: begin
    						if 		(MEM_WIDTH2_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 0;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	
    						end
    						else if (MEM_WIDTH2_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 1;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH2_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 2;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH2_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 3;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH2_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 4;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH2_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 5;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end 						
    					end
    					RISC_INSTRUCTION_FUNC3_3: begin
    						if 		(MEM_WIDTH3_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 0;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	
    						end
    						else if (MEM_WIDTH3_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 1;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH3_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 2;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH3_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 3;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH3_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 4;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH3_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 5;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end    						
    					end
    					RISC_INSTRUCTION_FUNC3_4: begin
    						if 		(MEM_WIDTH4_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 0;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	
    						end
    						else if (MEM_WIDTH4_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 1;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH4_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 2;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH4_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 3;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH4_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 4;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH4_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 5;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end      						
    					end
    					RISC_INSTRUCTION_FUNC3_5: begin
    						if 		(MEM_WIDTH5_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 0;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	
    						end
    						else if (MEM_WIDTH5_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 1;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH5_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 2;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH5_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 3;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH5_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 4;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH5_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 5;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end      						
    					end
    					RISC_INSTRUCTION_FUNC3_6: begin
    						if 		(MEM_WIDTH6_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 0;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 1;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 2;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 3;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 4;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 5;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end      						
    					end
    					RISC_INSTRUCTION_FUNC3_7: begin
    						if 		(MEM_WIDTH7_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 0;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 1;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 2;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 3;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 4;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 1;
    							axi_rd_slave_select <= 5;
    							axi_rd_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	    							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end     						
    					end
    				endcase    				      				
    			end
    			else if (instr_ff6.opcode == RISC_INSTRUCTION_OPCODE_S) begin
    				case (instr_ff6.func3)
    					RISC_INSTRUCTION_FUNC3_0: begin
    						if 		(MEM_WIDTH0_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 0;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  
    						end
    						else if (MEM_WIDTH0_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 1;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH0_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 2;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  	    							
    						end
    						else if (MEM_WIDTH0_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 3;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];     							
    						end
    						else if (MEM_WIDTH0_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 4;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH0_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 5;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end
    					end
    					RISC_INSTRUCTION_FUNC3_1: begin
    						if 		(MEM_WIDTH1_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 0;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  
    						end
    						else if (MEM_WIDTH1_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 1;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH1_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 2;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  	    							
    						end
    						else if (MEM_WIDTH1_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 3;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];     							
    						end
    						else if (MEM_WIDTH1_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 4;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH1_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 5;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end
    					end
    					RISC_INSTRUCTION_FUNC3_2: begin
    						if 		(MEM_WIDTH2_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 0;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  
    						end
    						else if (MEM_WIDTH2_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 1;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH2_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 2;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  	    							
    						end
    						else if (MEM_WIDTH2_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 3;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];     							
    						end
    						else if (MEM_WIDTH2_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 4;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH2_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 5;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end
    					end
    					RISC_INSTRUCTION_FUNC3_3: begin
    						if 		(MEM_WIDTH3_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 0;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  
    						end
    						else if (MEM_WIDTH3_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 1;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH3_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 2;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  	    							
    						end
    						else if (MEM_WIDTH3_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 3;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];     							
    						end
    						else if (MEM_WIDTH3_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 4;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH3_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 5;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end    						
    					end
    					RISC_INSTRUCTION_FUNC3_4: begin
    						if 		(MEM_WIDTH4_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 0;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  
    						end
    						else if (MEM_WIDTH4_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 1;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH4_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 2;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  	    							
    						end
    						else if (MEM_WIDTH4_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 3;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];     							
    						end
    						else if (MEM_WIDTH4_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 4;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH4_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 5;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end		
    					end
    					RISC_INSTRUCTION_FUNC3_5: begin
    						if 		(MEM_WIDTH0_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 0;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  
    						end
    						else if (MEM_WIDTH5_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 1;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH5_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 2;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  	    							
    						end
    						else if (MEM_WIDTH5_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 3;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];     							
    						end
    						else if (MEM_WIDTH5_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 4;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH5_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 5;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end      						
    					end
    					RISC_INSTRUCTION_FUNC3_6: begin
    						if 		(MEM_WIDTH6_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 0;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 1;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 2;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  	    							
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 3;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];     							
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 4;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH6_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 5;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end      						
    					end
    					RISC_INSTRUCTION_FUNC3_7: begin
    						if 		(MEM_WIDTH7_SELECTOR == "SLAVE0") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 0;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SLAVE1") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 1;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SLAVE2") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 2;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];  	    							
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SLAVE3") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 3;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];     							
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SLAVE4") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 4;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else if (MEM_WIDTH7_SELECTOR == "SLAVE5") begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	    					
    							axi_wr_req			<= 1;
    							axi_wr_slave_select <= 5;
    							axi_wr_offset		<= instr_ff6.arg + reg_in1_ff[3];
    							axi_wr_data			<= reg_in2_ff[3];      							
    						end
    						else begin
    							axi_rd_req			<= 0;
    							axi_rd_slave_select <= '0;
    							axi_rd_offset		<= '0;	  			
    							axi_wr_req			<= 0;
    							axi_wr_slave_select <= '0;
    							axi_wr_offset		<= '0;	
    							axi_wr_data			<= '0;	     							
    						end		
    					end
    				endcase    								
    			end
    			else begin
    				axi_rd_req			<= 0;
    				axi_rd_slave_select <= '0;
    				axi_rd_offset		<= '0;	  			
    				axi_wr_req			<= 0;
    				axi_wr_slave_select <= '0;
    				axi_wr_offset		<= '0;	
    				axi_wr_data			<= '0;	    				
    			end
    		end
    		else begin
    			axi_rd_req			<= 0;
    			axi_rd_slave_select <= '0;
    			axi_rd_offset		<= '0;	  			
    			axi_wr_req			<= 0;
    			axi_wr_slave_select <= '0;
    			axi_wr_offset		<= '0;	
    			axi_wr_data			<= '0;	  	    			
    		end
    	end
    end    
    
    generate
    	if (C_RISC_IF == "SIMPLE") begin
    		always_ff @ (posedge aclk or negedge arstn) begin
    			if (!arstn) begin
    				reg_out_sel 		<= '0;
    				reg_out     		<= '0;
    				memory_wr_en		<= '0;
    				memory_wr_address 	<= '0;
    				memory_wr_data 		<= '0; 
    				led					<= 0;
    				shared_wr_address	<= 0;
    				shared_memory_wr_en <= 0;
    				shared_memory_wr_data <= 0;
    			end
    			else begin
    				if (pipe_valid[11])  begin
    					if (instr_ff8.rd && ((instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_R) || (instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_I))) begin
    						if (instr_ff8.rd == C_RISC_SIMPLE_O_REG) begin
    							reg_out_sel			<= '0;
    							reg_out				<= '0;    			   
    							led					<= alu_op_S_ff[1][0];
    						end
    						else begin
    							reg_out_sel			<= instr_ff8.rd;
    							reg_out				<= alu_op_S_ff[1];    							
    						end
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;      	                     
    					end              
    					else if (instr_ff8.rd && instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_L) begin
    						reg_out_sel			<= instr_ff8.rd;
    						reg_out				<= memory_rd_data;
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;	 	 	                
    					end
    					else if (instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_S) begin
    						reg_out_sel 		<= '0;
    						reg_out				<= '0;
    						if (instr_ff8.func3) begin
    							memory_wr_en		<= 0;
    							memory_wr_address	<= '0;
    							memory_wr_data		<= '0;	            		
    						end
    						else begin
    							memory_wr_en		<= 1;
    							memory_wr_address	<= reg_in1_ff[5] + instr_ff8.arg; //{ (6) { alu_op_S_ff[1][7] } }, alu_op_S_ff[1][6:0] };
    							memory_wr_data		<= reg_in2_ff[5];          		
    						end
    					end
    					else if (instr_ff8.rd && instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_J) begin
    						reg_out_sel			<= instr_ff8.rd;
    						reg_out				<= { 1'b0, instruction_address_ff[8][6:0] };
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;    	            	
    					end
    					else if (instr_ff8.rd && instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_RAS) begin
    						reg_out_sel			<= instr_ff8.rd;
    						reg_out				<= { 1'b0, instruction_address_ff[8][6:0] };
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;   	 	            	
    					end	            
    					else begin
    						reg_out_sel 		<= '0;
    						reg_out     		<= '0;
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;                        
    					end
    				end
    				else begin
    					reg_out_sel 		<= '0;
    					reg_out     		<= '0;
    					memory_wr_en		<= '0;
    					memory_wr_address 	<= '0;
    					memory_wr_data 		<= '0;              	
    				end
    			end
    		end    		
    	end
    	else if (C_RISC_IF == "NATIVE") begin
    		always_ff @ (posedge aclk or negedge arstn) begin
    			if (!arstn) begin
    				reg_out_sel 		<= '0;
    				reg_out     		<= '0;
    				memory_wr_en		<= '0;
    				memory_wr_address 	<= '0;
    				memory_wr_data 		<= '0; 
    				native_o			<= '0;
    				native_t			<= '0;
    				shared_wr_address	<= 0;
    				shared_memory_wr_en <= 0;
    				shared_memory_wr_data <= 0;
    			end
    			else begin
    				if (pipe_valid[11])  begin
    					if (instr_ff8.rd && ((instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_R) || (instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_I))) begin
    						if (instr_ff8.rd == C_RISC_NATIVE_O_REG) begin
    							reg_out_sel			<= '0;
    							reg_out				<= '0;    			   
    							native_o			<= alu_op_S_ff[1];
    						end
    						else if (instr_ff8.rd == C_RISC_NATIVE_T_REG) begin
    							reg_out_sel			<= '0;
    							reg_out				<= '0;    			   
    							native_t			<= alu_op_S_ff[1];
    						end
    						else begin
    							reg_out_sel			<= instr_ff8.rd;
    							reg_out				<= alu_op_S_ff[1];    							
    						end
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;      	                     
    					end              
    					else if (instr_ff8.rd && instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_L) begin
    						reg_out_sel			<= instr_ff8.rd;
    						reg_out				<= memory_rd_data;
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;	 	 	                
    					end
    					else if (instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_S) begin
    						reg_out_sel 		<= '0;
    						reg_out				<= '0;
    						if (instr_ff8.func3) begin
    							memory_wr_en		<= 0;
    							memory_wr_address	<= '0;
    							memory_wr_data		<= '0;	            		
    						end
    						else begin
    							memory_wr_en		<= 1;
    							memory_wr_address	<= reg_in1_ff[5] + instr_ff8.arg; //{ (6) { alu_op_S_ff[1][7] } }, alu_op_S_ff[1][6:0] };
    							memory_wr_data		<= reg_in2_ff[5];          		
    						end
    					end
    					else if (instr_ff8.rd && instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_J) begin
    						reg_out_sel			<= instr_ff8.rd;
    						reg_out				<= { 1'b0, instruction_address_ff[8][6:0] };
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;    	            	
    					end
    					else if (instr_ff8.rd && instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_RAS) begin
    						reg_out_sel			<= instr_ff8.rd;
    						reg_out				<= { 1'b0, instruction_address_ff[8][6:0] };
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;   	 	            	
    					end	            
    					else begin
    						reg_out_sel 		<= '0;
    						reg_out     		<= '0;
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;                        
    					end
    				end
    				else begin
    					reg_out_sel 		<= '0;
    					reg_out     		<= '0;
    					memory_wr_en		<= '0;
    					memory_wr_address 	<= '0;
    					memory_wr_data 		<= '0;              	
    				end
    			end
    		end 	
    	end
    	else if (C_RISC_IF == "AXI4") begin
    		always_ff @ (posedge aclk or negedge arstn) begin
    			if (!arstn) begin
    				reg_out_sel 		<= '0;
    				reg_out     		<= '0;
    				memory_wr_en		<= '0;
    				memory_wr_address 	<= '0;
    				memory_wr_data 		<= '0; 
    				shared_wr_address	<= 0;
    				shared_memory_wr_en <= 0;
    				shared_memory_wr_data <= 0;
    			end
    			else begin
    				if (axi_pipe_ff[6]) begin
    					if (axi_rd_ack) begin
    						reg_out_sel			<= axi_reg_out;
    						reg_out				<= axi_rd_data;
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;  
    						shared_memory_wr_en	 	<= 0;
    						shared_wr_address 		<= 0;
    						shared_memory_wr_data 	<= 0;
    					end
    					else begin
    						reg_out_sel			<= '0;
    						reg_out				<= '0;
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;   	
    						shared_memory_wr_en	 	<= 0;
    						shared_wr_address 		<= 0;
    						shared_memory_wr_data 	<= 0;
    					end
    				end
    				else if (pipe_valid[11])  begin
    					if (instr_ff8.rd && ((instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_R) || (instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_I))) begin
    						reg_out_sel			<= instr_ff8.rd;
    						reg_out				<= alu_op_S_ff[1];
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;      
    						shared_memory_wr_en	 	<= 0;
    						shared_wr_address 		<= 0;
    						shared_memory_wr_data 	<= 0;
    					end              
    					else if (instr_ff8.rd && instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_L) begin
    						case (instr_ff8.func3)
    							RISC_INSTRUCTION_FUNC3_0: begin
    								if (MEM_WIDTH0_SELECTOR == "MEMORY") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= memory_rd_data;
    								end
    								else if (MEM_WIDTH0_SELECTOR == "SHARED") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= shared_memory_rd_data;	
    								end
    								else begin
    									reg_out_sel			<= 0;
    									reg_out				<= 0;
    								end
    							end
    							RISC_INSTRUCTION_FUNC3_1: begin
    								if (MEM_WIDTH1_SELECTOR == "MEMORY") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= memory_rd_data;
    								end
    								else if (MEM_WIDTH1_SELECTOR == "SHARED") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= shared_memory_rd_data;	
    								end
    								else begin
    									reg_out_sel			<= 0;
    									reg_out				<= 0;
    								end
    							end
    							RISC_INSTRUCTION_FUNC3_2: begin
    								if (MEM_WIDTH2_SELECTOR == "MEMORY") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= memory_rd_data;
    								end
    								else if (MEM_WIDTH2_SELECTOR == "SHARED") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= shared_memory_rd_data;	
    								end
    								else begin
    									reg_out_sel			<= 0;
    									reg_out				<= 0;
    								end   						
    							end
    							RISC_INSTRUCTION_FUNC3_3: begin
    								if (MEM_WIDTH3_SELECTOR == "MEMORY") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= memory_rd_data;
    								end
    								else if (MEM_WIDTH3_SELECTOR == "SHARED") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= shared_memory_rd_data;	
    								end
    								else begin
    									reg_out_sel			<= 0;
    									reg_out				<= 0;
    								end     						
    							end
    							RISC_INSTRUCTION_FUNC3_4: begin
    								if (MEM_WIDTH4_SELECTOR == "MEMORY") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= memory_rd_data;
    								end
    								else if (MEM_WIDTH4_SELECTOR == "SHARED") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= shared_memory_rd_data;	
    								end
    								else begin
    									reg_out_sel			<= 0;
    									reg_out				<= 0;
    								end      						
    							end
    							RISC_INSTRUCTION_FUNC3_5: begin
    								if (MEM_WIDTH5_SELECTOR == "MEMORY") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= memory_rd_data;
    								end
    								else if (MEM_WIDTH5_SELECTOR == "SHARED") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= shared_memory_rd_data;	
    								end
    								else begin
    									reg_out_sel			<= 0;
    									reg_out				<= 0;
    								end      						
    							end
    							RISC_INSTRUCTION_FUNC3_6: begin
    								if (MEM_WIDTH6_SELECTOR == "MEMORY") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= memory_rd_data;
    								end
    								else if (MEM_WIDTH6_SELECTOR == "SHARED") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= shared_memory_rd_data;	
    								end
    								else begin
    									reg_out_sel			<= 0;
    									reg_out				<= 0;
    								end      						
    							end
    							RISC_INSTRUCTION_FUNC3_7: begin
    								if (MEM_WIDTH7_SELECTOR == "MEMORY") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= memory_rd_data;
    								end
    								else if (MEM_WIDTH7_SELECTOR == "SHARED") begin
    									reg_out_sel			<= instr_ff8.rd;
    									reg_out				<= shared_memory_rd_data;	
    								end
    								else begin
    									reg_out_sel			<= 0;
    									reg_out				<= 0;
    								end      						
    							end
    						endcase  				    						
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;	 	
    						shared_memory_wr_en <= 0;
    						shared_wr_address 	<= 0;
    						shared_memory_wr_data <= 0;
    					end
    					else if (instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_S) begin
    						reg_out_sel 		<= '0;
    						reg_out				<= '0;
    						case (instr_ff8.func3)
    							RISC_INSTRUCTION_FUNC3_0: begin
    								if (MEM_WIDTH0_SELECTOR == "MEMORY") begin
    									memory_wr_en			<= 1;
    									memory_wr_address		<= reg_in1_ff[5] + instr_ff8.arg;
    									memory_wr_data			<= reg_in2_ff[5]; 
    									shared_memory_wr_en 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end
    								else if (MEM_WIDTH0_SELECTOR == "SHARED") begin 
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	 
    									shared_memory_wr_en 	<= 1;
    									shared_wr_address 		<= reg_in1_ff[5] + instr_ff8.arg;
    									shared_memory_wr_data 	<= reg_in2_ff[5];
    								end
    								else begin
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	
    									shared_memory_wr_en	 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end
    							end
    							RISC_INSTRUCTION_FUNC3_1: begin
    								if (MEM_WIDTH1_SELECTOR == "MEMORY") begin
    									memory_wr_en			<= 1;
    									memory_wr_address		<= reg_in1_ff[5] + instr_ff8.arg;
    									memory_wr_data			<= reg_in2_ff[5]; 
    									shared_memory_wr_en 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end
    								else if (MEM_WIDTH1_SELECTOR == "SHARED") begin 
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	 
    									shared_memory_wr_en 	<= 1;
    									shared_wr_address 		<= reg_in1_ff[5] + instr_ff8.arg;
    									shared_memory_wr_data 	<= reg_in2_ff[5];
    								end
    								else begin
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	
    									shared_memory_wr_en	 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end
    							end
    							RISC_INSTRUCTION_FUNC3_2: begin
    								if (MEM_WIDTH2_SELECTOR == "MEMORY") begin
    									memory_wr_en			<= 1;
    									memory_wr_address		<= reg_in1_ff[5] + instr_ff8.arg;
    									memory_wr_data			<= reg_in2_ff[5]; 
    									shared_memory_wr_en 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end
    								else if (MEM_WIDTH2_SELECTOR == "SHARED") begin 
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	 
    									shared_memory_wr_en 	<= 1;
    									shared_wr_address 		<= reg_in1_ff[5] + instr_ff8.arg;
    									shared_memory_wr_data 	<= reg_in2_ff[5];
    								end
    								else begin
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	
    									shared_memory_wr_en	 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end   						
    							end
    							RISC_INSTRUCTION_FUNC3_3: begin
    								if (MEM_WIDTH3_SELECTOR == "MEMORY") begin
    									memory_wr_en			<= 1;
    									memory_wr_address		<= reg_in1_ff[5] + instr_ff8.arg;
    									memory_wr_data			<= reg_in2_ff[5]; 
    									shared_memory_wr_en 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end
    								else if (MEM_WIDTH3_SELECTOR == "SHARED") begin 
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	 
    									shared_memory_wr_en 	<= 1;
    									shared_wr_address 		<= reg_in1_ff[5] + instr_ff8.arg;
    									shared_memory_wr_data 	<= reg_in2_ff[5];
    								end
    								else begin
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	
    									shared_memory_wr_en	 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end     						
    							end
    							RISC_INSTRUCTION_FUNC3_4: begin
    								if (MEM_WIDTH4_SELECTOR == "MEMORY") begin
    									memory_wr_en			<= 1;
    									memory_wr_address		<= reg_in1_ff[5] + instr_ff8.arg;
    									memory_wr_data			<= reg_in2_ff[5]; 
    									shared_memory_wr_en 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end
    								else if (MEM_WIDTH4_SELECTOR == "SHARED") begin 
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	 
    									shared_memory_wr_en 	<= 1;
    									shared_wr_address 		<= reg_in1_ff[5] + instr_ff8.arg;
    									shared_memory_wr_data 	<= reg_in2_ff[5];
    								end
    								else begin
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	
    									shared_memory_wr_en	 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end      						
    							end
    							RISC_INSTRUCTION_FUNC3_5: begin
    								if (MEM_WIDTH5_SELECTOR == "MEMORY") begin
    									memory_wr_en			<= 1;
    									memory_wr_address		<= reg_in1_ff[5] + instr_ff8.arg;
    									memory_wr_data			<= reg_in2_ff[5]; 
    									shared_memory_wr_en 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end
    								else if (MEM_WIDTH5_SELECTOR == "SHARED") begin 
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	 
    									shared_memory_wr_en 	<= 1;
    									shared_wr_address 		<= reg_in1_ff[5] + instr_ff8.arg;
    									shared_memory_wr_data 	<= reg_in2_ff[5];
    								end
    								else begin
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	
    									shared_memory_wr_en	 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end      						
    							end
    							RISC_INSTRUCTION_FUNC3_6: begin
    								if (MEM_WIDTH6_SELECTOR == "MEMORY") begin
    									memory_wr_en			<= 1;
    									memory_wr_address		<= reg_in1_ff[5] + instr_ff8.arg;
    									memory_wr_data			<= reg_in2_ff[5]; 
    									shared_memory_wr_en 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end
    								else if (MEM_WIDTH6_SELECTOR == "SHARED") begin 
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	 
    									shared_memory_wr_en 	<= 1;
    									shared_wr_address 		<= reg_in1_ff[5] + instr_ff8.arg;
    									shared_memory_wr_data 	<= reg_in2_ff[5];
    								end
    								else begin
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	
    									shared_memory_wr_en	 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end      						
    							end
    							RISC_INSTRUCTION_FUNC3_7: begin
    								if (MEM_WIDTH7_SELECTOR == "MEMORY") begin
    									memory_wr_en			<= 1;
    									memory_wr_address		<= reg_in1_ff[5] + instr_ff8.arg;
    									memory_wr_data			<= reg_in2_ff[5]; 
    									shared_memory_wr_en 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end
    								else if (MEM_WIDTH7_SELECTOR == "SHARED") begin 
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	 
    									shared_memory_wr_en 	<= 1;
    									shared_wr_address 		<= reg_in1_ff[5] + instr_ff8.arg;
    									shared_memory_wr_data 	<= reg_in2_ff[5];
    								end
    								else begin
    									memory_wr_en			<= 0;
    									memory_wr_address		<= '0;
    									memory_wr_data			<= '0;	
    									shared_memory_wr_en	 	<= 0;
    									shared_wr_address 		<= 0;
    									shared_memory_wr_data 	<= 0;
    								end      						
    							end
    						endcase    						
    					end
    					else if (instr_ff8.rd && instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_J) begin
    						reg_out_sel			<= instr_ff8.rd;
    						reg_out				<= { 1'b0, instruction_address_ff[8][6:0] };
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;
    						shared_memory_wr_en	 	<= 0;
    						shared_wr_address 		<= 0;
    						shared_memory_wr_data 	<= 0;
    					end
    					else if (instr_ff8.rd && instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_RAS) begin
    						reg_out_sel			<= instr_ff8.rd;
    						reg_out				<= { 1'b0, instruction_address_ff[8][6:0] };
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0; 
    						shared_memory_wr_en	 	<= 0;
    						shared_wr_address 		<= 0;
    						shared_memory_wr_data 	<= 0;
    					end	            
    					else begin
    						reg_out_sel 		<= '0;
    						reg_out     		<= '0;
    						memory_wr_en		<= '0;
    						memory_wr_address 	<= '0;
    						memory_wr_data 		<= '0;                        
    						shared_memory_wr_en	 	<= 0;
    						shared_wr_address 		<= 0;
    						shared_memory_wr_data 	<= 0;
    					end
    				end
    				else begin
    					reg_out_sel 		<= '0;
    					reg_out     		<= '0;
    					memory_wr_en		<= '0;
    					memory_wr_address 	<= '0;
    					memory_wr_data 		<= '0;           
    					shared_memory_wr_en	 	<= 0;
    					shared_wr_address 		<= 0;
    					shared_memory_wr_data 	<= 0;
    				end
    			end
    		end    	
    	end
    endgenerate
    
    // Set RAS
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		call_stack_push_en 	 <= 0;
    		call_stack_push_data <= '0;
    		link_data			 <= '0;
    	end
    	else begin
    		if (pipe_valid[11]) begin
    			if ((instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_RAS || instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_J) && instr_ff8.rd == 1) begin
    			 	call_stack_push_en 	 <= 1;
    			 	call_stack_push_data <= instruction_address_ff[8];
    			end
    			else if ((instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_RAS || instr_ff8.opcode == RISC_INSTRUCTION_OPCODE_J) && instr_ff8.rd == 5) begin
    				link_data			 <= instruction_address_ff[8];
    				call_stack_push_en 	 <= 0;
    				call_stack_push_data <= '0;     				
    			end
    			else begin
    				call_stack_push_en 	 <= 0;
    				call_stack_push_data <= '0;    			
    			end
    		end
    		else begin
    			if (ack_irq_ff[4]) begin
    				call_stack_push_en		<= 1;
    				call_stack_push_data	<= instruction_address_ff[10] + 1;
    			end
    			else begin
    				call_stack_push_en 	 <= 0;
    				call_stack_push_data <= '0;
    			end
    		end
    	end
    end
    
    // Release locked reg - pipe_valid[11] = 1, instr_ff8 valid
    
    
    // Int enable fsm
    typedef enum logic [2:0] {
    	FSM_INT_EN_IDLE 	  = 3'b000,
    	FSM_INT_EN_JUMP 	  = 3'b001,
    	FSM_INT_EN_IRQ		  = 3'b010,
    	FSM_INT_EN_RETURN 	  = 3'b011,
    	FSM_INT_EN_AXI_WR_REQ = 3'b100,
    	FSM_INT_EN_AXI_WR_ACK = 3'b101,
    	FSM_INT_EN_AXI_RD_REQ = 3'b110,
    	FSM_INT_EN_AXI_RD_ACK = 3'b111
    } int_en_fsm_t;
    
    int_en_fsm_t int_en_fsm;
    logic [12:0] int_en_ret_address;
    
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		int_en_fsm 			<= FSM_INT_EN_IDLE;
    		int_en_ret_address 	<= '0;
    		interrupt_enable 	<= 0;
    	end
    	else begin
    		case (int_en_fsm)
    			FSM_INT_EN_IDLE: begin
    				if (interrupt_acknowledge) begin
    					interrupt_enable <= 0;
    					int_en_fsm 		 <= FSM_INT_EN_JUMP;
    				end
    				else if (axi_wr_req) begin
    					interrupt_enable <= 0;
    					int_en_fsm 		 <= FSM_INT_EN_AXI_WR_REQ;   					
    				end
    				else if (axi_rd_req) begin
    					interrupt_enable <= 0;
    					int_en_fsm 		 <= FSM_INT_EN_AXI_RD_REQ;    					
    				end
    				else begin
    					interrupt_enable <= 1;
    				end
    			end
    			FSM_INT_EN_JUMP: begin
    				if (ack_irq_ff[5] && call_stack_push_en) begin
    					int_en_ret_address <= call_stack_push_data;
    					int_en_fsm		   <= FSM_INT_EN_IRQ;
    				end
    			end
    			FSM_INT_EN_IRQ: begin
    				if (instruction_address == 100) begin
    					int_en_fsm 		   <= FSM_INT_EN_RETURN;
    				end
    			end
    			FSM_INT_EN_RETURN: begin
    				if (instruction_address == int_en_ret_address) begin
    					int_en_ret_address 	<= '0;
    					int_en_fsm			<= FSM_INT_EN_IDLE;
    					interrupt_enable	<= 1;
    				end
    			end    			
    			FSM_INT_EN_AXI_WR_REQ: begin
    				if (axi_wr_ack) begin
    					int_en_fsm <= FSM_INT_EN_AXI_WR_ACK;
    				end
    			end
    			FSM_INT_EN_AXI_WR_ACK: begin
    				if (!axi_wr_ack) begin
    					int_en_fsm 		 <= FSM_INT_EN_IDLE;
    					interrupt_enable <= 1;
    				end
    			end
    			FSM_INT_EN_AXI_RD_REQ: begin
    				if (axi_rd_ack) begin
    					int_en_fsm <= FSM_INT_EN_AXI_RD_ACK;
    				end
    			end    			
    			FSM_INT_EN_AXI_RD_ACK: begin
    				if (!axi_rd_ack && !axi_pipe && pipe_valid == '1) begin
    					int_en_fsm 		 <= FSM_INT_EN_IDLE;
    					interrupt_enable <= 1;
    				end
    			end    			
    		endcase
    	end
    end
    
// synthesis translate_off    
    logic [12:0] monitor_instruction_address;
    logic [12:0] monitor_instruction_address_pipe_1_sync;
    logic [12:0] monitor_instruction_address_pipe_2_sync;
    assign monitor_instruction_address = instruction_address;
    always_ff @ (posedge aclk) begin
    	monitor_instruction_address_pipe_1_sync <= monitor_instruction_address;
    	monitor_instruction_address_pipe_2_sync <= monitor_instruction_address_pipe_1_sync;
    end
// synthesis translate_on
endmodule
