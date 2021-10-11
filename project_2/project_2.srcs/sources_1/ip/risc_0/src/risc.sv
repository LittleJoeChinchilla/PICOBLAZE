/* Copyright 2020 Gniewko Kuraczyk
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
`include "logic.svh"
import risc_instruction_decode_pkg::*;
module risc #(
	//------- ARCHITECTURE GENERICS -------------------//
	parameter C_RISC_DATA_WIDTH             = 8,
	parameter C_RISC_INTERRUPT_EN           = "false",
	parameter C_RISC_JTAG_EN                = "true",
	parameter C_RISC_VALIDATION_EN          = "true",
	parameter C_RISC_ZYNQ_EN                = "false",
	parameter C_RISC_OUTPUT_CLKRST_EN       = "false",
	parameter C_RISC_RESET_VECTOR		    = 32'd0,
	parameter C_RISC_EXCEPTION_VECTOR	    = 32'd100,
	parameter C_RISC_INTERRUPT_VECTOR	    = 32'd200,
	//------- MEMORY GENERICS -------------------------//
	parameter C_RISC_PROGRAM_MEMORY_SIZE    = "8K",
	parameter C_RISC_DATA_MEMORY_SIZE       = "8K",
	//------- INTERFACE GENERICS ----------------------//	   
	parameter C_RISC_IF                     = "SIMPLE",
	parameter C_RISC_SIMPLE_I_REG           = 10,
	parameter C_RISC_SIMPLE_O_REG           = 10,
	parameter C_RISC_NATIVE_I_REG           = 10,
	parameter C_RISC_NATIVE_O_REG           = 10,
	parameter C_RISC_NATIVE_T_REG           = 10,
	parameter C_M_AXI_LITE_ADDR_WIDTH       = 32,
	parameter C_M_AXI_LITE_DATA_WIDTH       = 32,
	parameter C_RISC_AXI4_SLAVE0_EN         = "false",
	parameter C_RISC_AXI4_SLAVE0_BASE       = 32'h0,
	parameter C_RISC_AXI4_SLAVE0_SIZE       = "1K",
	parameter C_RISC_AXI4_SLAVE1_EN         = "false",
	parameter C_RISC_AXI4_SLAVE1_BASE       = 32'h0,
	parameter C_RISC_AXI4_SLAVE1_SIZE       = "1K",
	parameter C_RISC_AXI4_SLAVE2_EN         = "false",
	parameter C_RISC_AXI4_SLAVE2_BASE       = 32'h0,
	parameter C_RISC_AXI4_SLAVE2_SIZE       = "1K",
	parameter C_RISC_AXI4_SLAVE3_EN         = "false",
	parameter C_RISC_AXI4_SLAVE3_BASE       = 32'h0,
	parameter C_RISC_AXI4_SLAVE3_SIZE       = "1K",    
	parameter C_RISC_AXI4_SLAVE4_EN         = "false",
	parameter C_RISC_AXI4_SLAVE4_BASE       = 32'h0,
	parameter C_RISC_AXI4_SLAVE4_SIZE       = "1K",      
	parameter C_RISC_AXI4_SLAVE5_EN         = "false",
	parameter C_RISC_AXI4_SLAVE5_BASE       = 32'h0,
	parameter C_RISC_AXI4_SLAVE5_SIZE       = "1K",
	parameter C_RISC_AXI4_MASTER_EN         = "false",
	parameter C_RISC_AXI4_MASTER_BASE	    = 32'h0,
	parameter C_RISC_AXI4_MASTER_SIZE	    = "1K",
	parameter C_RISC_MEM_WIDTH0_SELECTOR	= "MEMORY",
    parameter C_RISC_MEM_WIDTH1_SELECTOR 	= "MEMORY",
    parameter C_RISC_MEM_WIDTH2_SELECTOR    = "MEMORY",
    parameter C_RISC_MEM_WIDTH3_SELECTOR    = "MEMORY",
	parameter C_RISC_MEM_WIDTH4_SELECTOR    = "MEMORY",
	parameter C_RISC_MEM_WIDTH5_SELECTOR    = "MEMORY",
	parameter C_RISC_MEM_WIDTH6_SELECTOR    = "MEMORY",
	parameter C_RISC_MEM_WIDTH7_SELECTOR    = "MEMORY",
	//------- DSP GENERICS ----------------------------//
	parameter SIMULATION				    = "false"
)(
	//------ Internal CLK ---------//
	input              zynq_pl_clk,
	input              zynq_pl_resetn,
	//------ External CLK ---------//
	input              sys_clk,
	input              sys_reset,
	//------ IRQ ------------------//
	input              irq,
	//------ SIMPLE IF ------------//
	input              sw,
	output             led,
	//------ NATIVE IF ------------//
	input  [7:0]       native_i,
	output [7:0]       native_o,
	output [7:0]       native_t,
	//------ AXI4 IF --------------//
	`LOGIC_MODPORT(logic_axi4_lite_if, master) m_axi,
	`LOGIC_MODPORT(logic_axi4_lite_if, slave)  s_axi,
	//------ Output clk & rst -----//
	output          risc_clk,
	output          risc_resetn,
	output          validation_reset
);
	
	/* Validation VIO */
	generate
		if (C_RISC_VALIDATION_EN == "true") begin
			logic [0:0] vio_reset_out;
			assign validation_reset = vio_reset_out;
			risc_vio validation_stimulus_inst (
				.clk		(risc_clk),		// input wire clk
				.probe_out0	(vio_reset_out)	// output wire [0 : 0] probe_out0
			);
		end
		else begin
			assign validation_reset = 0;
		end
	endgenerate
	
	/* JTAG */	
	logic	 	 halt;
	logic 		 jtag_reset;
	logic 		 locked;
	logic [12:0] wr_instruction_address;
	logic [31:0] wr_instruction_data;
	logic		 wr_instruction_en;
	generate
		if (C_RISC_JTAG_EN == "true" && SIMULATION == "false") begin : JTAG_GEN_ENABLED
			risc_jtag risc_jtag_inst (
				.clk				(risc_clk),
				.rst				(sys_reset),
				.locked				(locked),
				.jtag_reset			(jtag_reset),
				.halt				(halt),
				.instruction_address(wr_instruction_address),
				.instruction_data	(wr_instruction_data),
				.instruction_wr_en 	(wr_instruction_en)
			);				
		end : JTAG_GEN_ENABLED
		else begin : JTAG_GEN_DISABLED
			if (SIMULATION == "false") begin : SIMULATION_DISABLED
				assign wr_instruction_address = '0;
				assign wr_instruction_data	  = '0;
				assign wr_instruction_en	  = 0;
				assign halt					  = 0;
				assign jtag_reset		  	  = 0;
			end : SIMULATION_DISABLED
			else begin : SIMULATION_ENABLED
				// synthesis translate_off
				initial begin
					wr_instruction_address = '0;
					wr_instruction_data    = '0;
					wr_instruction_en	   = 0;
					halt				   = 0;
					jtag_reset			   = 0;
				end
				typedef logic [31:0] instruction_data_t[];
				task programming (input instruction_data_t data);
					@ (posedge risc_clk);
					jtag_reset <= 1;
					repeat (10) @ (posedge risc_clk);
					for (int i = 0 ; i < data.size; i++) begin
						wr_instruction_en 		<= 1;
						wr_instruction_address 	<= $unsigned(i);
						wr_instruction_data		<= data[i];
						@ (posedge risc_clk);
					end
					if (data.size < 8192) begin
						for (int i = data.size; i < 8192; i++) begin
							wr_instruction_en 		<= 1;
							wr_instruction_address 	<= $unsigned(i);
							wr_instruction_data 	<= 0;
							@ (posedge risc_clk);
						end
					end
					wr_instruction_en 		<= 0;
					wr_instruction_address 	<= 0;
					wr_instruction_data 	<= 0;
					@ (posedge risc_clk);
					jtag_reset <= 0;
					repeat (10) @ (posedge risc_clk);
				endtask
				// synthesis translate_on
			end : SIMULATION_ENABLED
		end : JTAG_GEN_DISABLED
	endgenerate
	
	/* Interrupt controller */
	logic irq_en;
	logic irq_pen;
	logic irq_ack; 
	generate
		if (C_RISC_INTERRUPT_EN == "true") begin
			risc_interrupt_controller risc_interrupt_controller_inst (
				.aclk           (risc_clk),
				.arstn          (risc_resetn),
				.irq            (irq),
				.irq_enable     (irq_en),
				.irq_pending    (irq_pen),
				.irq_acknowledge(irq_ack)
			);  			
		end
		else begin
			assign irq_pending = 0;
		end
	endgenerate
    
	/* AXI MASTER driver */
	logic [ 2:0] axi_slave_select;
	logic [15:0] axi_offset;
	logic 		 axi_rw;
	logic 		 axi_req;
	logic 		 axi_ack;
	logic [ 7:0] axi_data_in;
	logic [ 7:0] axi_data_out;
	logic 		 axi_error;
	logic [3:0]  axi_fsm;
	logic [9:0] axi_timeout;
    generate
    	if (C_RISC_IF == "AXI4" && (C_RISC_AXI4_SLAVE0_EN == "true" ||
					    			C_RISC_AXI4_SLAVE1_EN == "true" ||
					    			C_RISC_AXI4_SLAVE2_EN == "true" ||
					    			C_RISC_AXI4_SLAVE3_EN == "true" ||
					    			C_RISC_AXI4_SLAVE4_EN == "true" ||
					    			C_RISC_AXI4_SLAVE5_EN == "true")) begin
					    			
			localparam AXI_SLAVE_0_ENABLE = (C_RISC_AXI4_SLAVE0_EN   == "true") ?     1 : 0;
			localparam AXI_SLAVE_1_ENABLE = (C_RISC_AXI4_SLAVE1_EN   == "true") ?     1 : 0;
			localparam AXI_SLAVE_2_ENABLE = (C_RISC_AXI4_SLAVE2_EN   == "true") ?     1 : 0;
			localparam AXI_SLAVE_3_ENABLE = (C_RISC_AXI4_SLAVE3_EN   == "true") ?     1 : 0;
			localparam AXI_SLAVE_4_ENABLE = (C_RISC_AXI4_SLAVE4_EN   == "true") ?     1 : 0;
			localparam AXI_SLAVE_5_ENABLE = (C_RISC_AXI4_SLAVE5_EN   == "true") ?     1 : 0;
					    			
			localparam AXI_SLAVE_0_SIZE   = (C_RISC_AXI4_SLAVE0_SIZE ==   "1K") ?  1024 :	
										  	(C_RISC_AXI4_SLAVE0_SIZE ==   "2K") ?  2048 :	
										  	(C_RISC_AXI4_SLAVE0_SIZE ==   "4K") ?  4096 :	
										  	(C_RISC_AXI4_SLAVE0_SIZE ==   "8K") ?  8192 :	
										  	(C_RISC_AXI4_SLAVE0_SIZE ==  "16K") ? 16384 :	
										  	(C_RISC_AXI4_SLAVE0_SIZE ==  "32K") ? 32768 :	
										  	(C_RISC_AXI4_SLAVE0_SIZE ==  "64K") ? 65536 : 1;
			
			localparam AXI_SLAVE_1_SIZE   = (C_RISC_AXI4_SLAVE1_SIZE ==   "1K") ?  1024 :	
										  	(C_RISC_AXI4_SLAVE1_SIZE ==   "2K") ?  2048 :	
										  	(C_RISC_AXI4_SLAVE1_SIZE ==   "4K") ?  4096 :	
										  	(C_RISC_AXI4_SLAVE1_SIZE ==   "8K") ?  8192 :	
										  	(C_RISC_AXI4_SLAVE1_SIZE ==  "16K") ? 16384 :	
									      	(C_RISC_AXI4_SLAVE1_SIZE ==  "32K") ? 32768 :	
										  	(C_RISC_AXI4_SLAVE1_SIZE ==  "64K") ? 65536 : 1;

			localparam AXI_SLAVE_2_SIZE   = (C_RISC_AXI4_SLAVE2_SIZE ==   "1K") ?  1024 :	
										  	(C_RISC_AXI4_SLAVE2_SIZE ==   "2K") ?  2048 :	
										  	(C_RISC_AXI4_SLAVE2_SIZE ==   "4K") ?  4096 :	
										  	(C_RISC_AXI4_SLAVE2_SIZE ==   "8K") ?  8192 :	
										  	(C_RISC_AXI4_SLAVE2_SIZE ==  "16K") ? 16384 :	
										  	(C_RISC_AXI4_SLAVE2_SIZE ==  "32K") ? 32768 :	
										  	(C_RISC_AXI4_SLAVE2_SIZE ==  "64K") ? 65536 : 1;		
			
			localparam AXI_SLAVE_3_SIZE   = (C_RISC_AXI4_SLAVE3_SIZE ==   "1K") ?  1024 :	
										  	(C_RISC_AXI4_SLAVE3_SIZE ==   "2K") ?  2048 :	
										  	(C_RISC_AXI4_SLAVE3_SIZE ==   "4K") ?  4096 :	
										  	(C_RISC_AXI4_SLAVE3_SIZE ==   "8K") ?  8192 :	
										  	(C_RISC_AXI4_SLAVE3_SIZE ==  "16K") ? 16384 :	
										  	(C_RISC_AXI4_SLAVE3_SIZE ==  "32K") ? 32768 :	
										  	(C_RISC_AXI4_SLAVE3_SIZE ==  "64K") ? 65536 : 1;
			
			localparam AXI_SLAVE_4_SIZE   = (C_RISC_AXI4_SLAVE4_SIZE ==   "1K") ?  1024 :	
										  	(C_RISC_AXI4_SLAVE4_SIZE ==   "2K") ?  2048 :	
										  	(C_RISC_AXI4_SLAVE4_SIZE ==   "4K") ?  4096 :	
										  	(C_RISC_AXI4_SLAVE4_SIZE ==   "8K") ?  8192 :	
										  	(C_RISC_AXI4_SLAVE4_SIZE ==  "16K") ? 16384 :	
										  	(C_RISC_AXI4_SLAVE4_SIZE ==  "32K") ? 32768 :	
										  	(C_RISC_AXI4_SLAVE4_SIZE ==  "64K") ? 65536 : 1;
			
			localparam AXI_SLAVE_5_SIZE   = (C_RISC_AXI4_SLAVE5_SIZE ==   "1K") ?  1024 :	
										  	(C_RISC_AXI4_SLAVE5_SIZE ==   "2K") ?  2048 :	
										  	(C_RISC_AXI4_SLAVE5_SIZE ==   "4K") ?  4096 :	
										  	(C_RISC_AXI4_SLAVE5_SIZE ==   "8K") ?  8192 :	
										  	(C_RISC_AXI4_SLAVE5_SIZE ==  "16K") ? 16384 :	
										  	(C_RISC_AXI4_SLAVE5_SIZE ==  "32K") ? 32768 :	
										  	(C_RISC_AXI4_SLAVE5_SIZE ==  "64K") ? 65536 : 1;
			
    		risc_axi_master_driver #(
    		    .TIMEOUT                    (16'd1000),
    			.AXI_SLAVE_0_ENABLE         (AXI_SLAVE_0_ENABLE),
   				.AXI_SLAVE_0_BASEADDRESS    (C_RISC_AXI4_SLAVE0_BASE),
    			.AXI_SLAVE_0_SIZE           (AXI_SLAVE_0_SIZE),
    			.AXI_SLAVE_1_ENABLE         (AXI_SLAVE_1_ENABLE),
    			.AXI_SLAVE_1_BASEADDRESS    (C_RISC_AXI4_SLAVE1_BASE),
    			.AXI_SLAVE_1_SIZE           (AXI_SLAVE_1_SIZE),    
    			.AXI_SLAVE_2_ENABLE         (AXI_SLAVE_2_ENABLE),
    			.AXI_SLAVE_2_BASEADDRESS    (C_RISC_AXI4_SLAVE2_BASE),
    			.AXI_SLAVE_2_SIZE           (AXI_SLAVE_2_SIZE),
    			.AXI_SLAVE_3_ENABLE         (AXI_SLAVE_3_ENABLE),
    			.AXI_SLAVE_3_BASEADDRESS    (C_RISC_AXI4_SLAVE3_BASE),
    			.AXI_SLAVE_3_SIZE           (AXI_SLAVE_3_SIZE),
    			.AXI_SLAVE_4_ENABLE         (AXI_SLAVE_4_ENABLE),
    			.AXI_SLAVE_4_BASEADDRESS    (C_RISC_AXI4_SLAVE4_BASE),
    			.AXI_SLAVE_4_SIZE           (AXI_SLAVE_4_SIZE),
    			.AXI_SLAVE_5_ENABLE         (AXI_SLAVE_5_ENABLE),
    			.AXI_SLAVE_5_BASEADDRESS    (C_RISC_AXI4_SLAVE5_BASE),
    			.AXI_SLAVE_5_SIZE           (AXI_SLAVE_5_SIZE),    
    			.AXI_SLAVE_6_ENABLE         (0),
    			.AXI_SLAVE_6_BASEADDRESS    (32'h0),
    			.AXI_SLAVE_6_SIZE           (1)     			
    		) risc_axi_master_driver_inst (
    			.clk                        (risc_clk),
    			.rstn                       (risc_resetn),
    			.m_axi                      (m_axi),
    			.slave_select               (axi_slave_select),
    			.offset                     (axi_offset),
    			.rw                         (axi_rw),                // read = 1, write = 0
    			.req                        (axi_req),
    			.ack                        (axi_ack),
    			.data_in                    (axi_data_in),
    			.data_out                   (axi_data_out),
    			.error                      (axi_error),
    			.probe_timeout                    (axi_timeout),
    			.probe_fsm                        (axi_fsm)
    		);    							    			
    	end
    	else begin
    		always_comb begin
    			axi_data_out 	= '0;
    			axi_error 		= 0;
    			axi_ack 		= 0;
    			m_axi.awaddr 	= '0;
    			m_axi.awvalid 	= 0;
    			m_axi.wdata		= '0;
    			m_axi.wstrb		= '0;
    			m_axi.wvalid	= 0;
    			m_axi.bready	= 0;
    			m_axi.araddr	= '0;
    			m_axi.arvalid 	= 0;
    			m_axi.rready	= 0;
    		end
    	end
    endgenerate

    /* AXI SLAVE DRIVER */
    logic [15:0] shared_address;
    logic        shared_wen;
    logic [ 7:0] shared_din;
    logic [ 7:0] shared_dout;
    generate
        if (C_RISC_IF == "AXI4" && C_RISC_AXI4_MASTER_EN == "true") begin
            localparam size =   (C_RISC_AXI4_MASTER_SIZE ==  "1K") ?  1024 :
                                (C_RISC_AXI4_MASTER_SIZE ==  "2K") ?  2048 :
                                (C_RISC_AXI4_MASTER_SIZE ==  "4K") ?  4096 :
                                (C_RISC_AXI4_MASTER_SIZE ==  "8K") ?  8192 :
                                (C_RISC_AXI4_MASTER_SIZE == "16K") ? 16384 :
                                (C_RISC_AXI4_MASTER_SIZE == "32K") ? 32768 :
                                (C_RISC_AXI4_MASTER_SIZE == "64K") ? 65536 : 0;
            risc_axi_slave_driver #(
                .WIDTH      (C_RISC_DATA_WIDTH),
                .TIMEOUT    (1000),
                .BASEADDRESS(C_RISC_AXI4_MASTER_BASE),
                .SIZE       (size)
            ) risc_axi_slave_driver_inst (
                .clk        (risc_clk),
                .rstn       (risc_resetn),
                .s_axi      (s_axi),
                .address    (shared_address),
                .wr_en      (shared_wen),
                .wr_data    (shared_din),
                .rd_data    (shared_dout)
            );
        end
        else begin
            assign shared_dout = '0;
        end
    endgenerate    
    
	/* Clock & reset */
	logic aux_reset;
	assign aux_reset = jtag_reset || validation_reset;
	risc_clocking #(
		.ZYNQ_PRESENT		(C_RISC_ZYNQ_EN)
	) risc_clocking_inst (
	    .zynq_pl_clk        (zynq_pl_clk),
        .zynq_pl_resetn     (zynq_pl_resetn),
		.sys_clk			(sys_clk),
		.sys_reset			(sys_reset),
		.aux_reset 			(aux_reset),
		.risc_clk			(risc_clk),
		.risc_resetn		(risc_resetn),
		.locked				(locked)
	);

    /* Registers */
	logic [4:0] reg_in1_sel;
	logic [7:0] reg_in1;
	logic [4:0] reg_in2_sel;
	logic [7:0] reg_in2;
 	logic		reg_out_en;
 	logic [4:0] reg_out_sel;
 	logic [7:0] reg_out;	
	assign reg_out_en = reg_out_sel == '0 ? 0 : 1;
 	risc_registers registers_inst (
		.clk		(risc_clk),
		.shadow_en	(1'b0),
		.src_1_sel	(reg_in1_sel),
		.src_2_sel	(reg_in2_sel),
		.dest_sel	(reg_out_sel),
		.dest_en	(reg_out_en),
		.src_1		(reg_in1),
		.src_2		(reg_in2),
		.dest		(reg_out)
	);

    /* PROGRAM MEMORY */
 	logic [31:0] instruction_data;
  	logic [12:0] instruction_address;
    risc_program_memory program_memory_inst (
        .clka   (risc_clk),
        .wea	(wr_instruction_en),
        .addra 	(wr_instruction_address),
        .dina	(wr_instruction_data),
        .clkb	(risc_clk),
        .addrb  (instruction_address),
        .doutb  (instruction_data)
    );

    /* DATA MEMORY */
 	logic [ 7:0] memory_wr_data;
	logic        memory_wr_en;
	logic [12:0] memory_wr_address;
  	logic [ 7:0] memory_rd_data;    
 	logic [12:0] memory_rd_address;
    risc_data_memory data_memory_inst (
        .clka   (risc_clk),
        .wea    (memory_wr_en),
        .addra  (memory_wr_address),
        .dina   (memory_wr_data),
        .clkb   (risc_clk),
        .addrb  (memory_rd_address),
        .doutb  (memory_rd_data)
    );

    /* ALU */
    logic [7:0] alu_op_A;
    logic [7:0] alu_op_B;
    logic [7:0] alu_op_S;
    logic [5:0] alu_op_code;
    risc_alu risc_alu_inst (
        .aclk   	(risc_clk),
        .arstn  	(risc_resetn),
	    .opcode 	(alu_op_code),
        .op_a   	(alu_op_A),
        .op_b   	(alu_op_B),
        .result 	(alu_op_S)
    );
    
    logic [7:0] reg_in1_mux;
    logic [7:0] reg_in2_mux;
    logic [4:0] reg_in1_sel_ff;
    logic [4:0] reg_in2_sel_ff;
    always_ff @ (posedge risc_clk or negedge risc_resetn) begin
    	if (!risc_resetn) begin
    		reg_in1_sel_ff <= '0;
    		reg_in2_sel_ff <= '0;
    	end
    	else begin
    		reg_in1_sel_ff <= reg_in1_sel;
    		reg_in2_sel_ff <= reg_in2_sel;
    	end
    end
    
    generate
    	if (C_RISC_IF == "SIMPLE") begin
    		always_comb begin
    			if (reg_in1_sel_ff == C_RISC_SIMPLE_I_REG) begin
    				reg_in1_mux = (sw) ? 8'h1 : 8'h0;
    			end
    			else begin
    				reg_in1_mux = reg_in1;
    			end
    			if (reg_in2_sel_ff == C_RISC_SIMPLE_I_REG) begin
    				reg_in2_mux = (sw) ? 8'h1 : 8'h0;
    			end
    			else begin
    				reg_in2_mux = reg_in2;
    			end
    		end
    	end
    	else if (C_RISC_IF == "NATIVE") begin
    		always_comb begin
    			if (reg_in1_sel_ff == C_RISC_NATIVE_I_REG) begin
    				reg_in1_mux = native_i;
    			end
    			else begin
    				reg_in1_mux = reg_in1;
    			end
    			if (reg_in2_sel_ff == C_RISC_NATIVE_I_REG) begin
    				reg_in2_mux = native_i;
    			end
    			else begin
    				reg_in2_mux = reg_in2;
    			end
    		end
    	end
    	else if (C_RISC_IF == "AXI4") begin
    		assign reg_in1_mux = reg_in1;
    		assign reg_in2_mux = reg_in2;
    	end
    endgenerate

    /* INSTRUCTION DECODE */
    risc_instruction_decode #(
   		.WIDTH				  	(C_RISC_DATA_WIDTH),
        .RESET_VECTOR           (C_RISC_RESET_VECTOR),
        .EXCEPTION_VECTOR       (C_RISC_EXCEPTION_VECTOR),
        .INTERRUPT_VECTOR       (C_RISC_INTERRUPT_VECTOR),
        .C_RISC_IF              (C_RISC_IF),
        .C_RISC_SIMPLE_O_REG    (C_RISC_SIMPLE_O_REG),
        .C_RISC_NATIVE_O_REG    (C_RISC_NATIVE_O_REG),
        .C_RISC_NATIVE_T_REG    (C_RISC_NATIVE_T_REG),
        .MEM_WIDTH0_SELECTOR    (C_RISC_MEM_WIDTH0_SELECTOR),
        .MEM_WIDTH1_SELECTOR    (C_RISC_MEM_WIDTH1_SELECTOR),
        .MEM_WIDTH2_SELECTOR    (C_RISC_MEM_WIDTH2_SELECTOR),
        .MEM_WIDTH3_SELECTOR    (C_RISC_MEM_WIDTH3_SELECTOR),
        .MEM_WIDTH4_SELECTOR    (C_RISC_MEM_WIDTH4_SELECTOR),
        .MEM_WIDTH5_SELECTOR    (C_RISC_MEM_WIDTH5_SELECTOR),
        .MEM_WIDTH6_SELECTOR    (C_RISC_MEM_WIDTH6_SELECTOR),
        .MEM_WIDTH7_SELECTOR    (C_RISC_MEM_WIDTH7_SELECTOR)
    ) risc_instruction_decode_inst (
        .aclk                   (risc_clk),
        .arstn                  (risc_resetn),
        .instruction_address    (instruction_address),
        .instruction_data       (instruction_data),
        .memory_wr_en           (memory_wr_en),
        .memory_wr_address      (memory_wr_address),
        .memory_wr_data         (memory_wr_data),
        .memory_rd_address      (memory_rd_address),
        .memory_rd_data         (memory_rd_data),
        .reg_in1_sel            (reg_in1_sel),
        .reg_in1                (reg_in1_mux),
        .reg_in2_sel            (reg_in2_sel),
        .reg_in2                (reg_in2_mux),
        .reg_out_sel            (reg_out_sel),
        .reg_out                (reg_out),
        .alu_op_A               (alu_op_A),
        .alu_op_B               (alu_op_B),
        .alu_op_S               (alu_op_S),
        .alu_op_code            (alu_op_code),
        .interrupt_pending		(irq_pen),
        .interrupt_acknowledge	(irq_ack),
        .interrupt_enable		(irq_en),
        .axi_slave_select		(axi_slave_select),
        .axi_offset				(axi_offset),
        .axi_rw					(axi_rw),
        .axi_req				(axi_req),
        .axi_ack				(axi_ack),
        .axi_data_in			(axi_data_in),
        .axi_data_out			(axi_data_out),
        .axi_error 				(axi_error),
        .shared_memory_address	(shared_address),
        .shared_memory_wr_en    (shared_wen),
        .shared_memory_wr_data  (shared_din),
        .shared_memory_rd_data  (shared_dout),        
        .led					(led),
        .native_o				(native_o),
        .native_t				(native_t)
    );
    
    /* Validation ILA */
    generate
    	if (C_RISC_VALIDATION_EN == "true") begin
    	   logic [ 0:0] ila_resetn;
    	   logic [ 0:0] ila_irq;
    	   logic [ 0:0] ila_sw;
    	   logic [ 0:0] ila_led;
    	   logic [ 7:0] ila_native_i;
    	   logic [ 7:0] ila_native_o;
    	   logic [ 7:0] ila_native_t;
    	   logic [ 0:0] ila_irq_en;
    	   logic [ 0:0] ila_irq_pen;
    	   logic [ 0:0] ila_irq_ack;
    	   logic [ 4:0] ila_reg_in1_sel;
    	   logic [ 7:0] ila_reg_in1_mux;
    	   logic [ 4:0] ila_reg_in2_sel;
    	   logic [ 7:0] ila_reg_in2_mux;
    	   logic [ 4:0] ila_reg_out_sel;
    	   logic [ 7:0] ila_reg_out;
    	   logic [12:0] ila_instruction_address;
    	   logic [20:0] ila_instruction_data_arg;
    	   logic [ 4:0] ila_instruction_data_rd;
    	   logic [ 4:0] ila_instruction_data_rs1;
    	   logic [ 4:0] ila_instruction_data_rs2;
    	   risc_instruction_func7_t  ila_instruction_data_func7;
    	   risc_instruction_func3_t  ila_instruction_data_func3;
    	   risc_instruction_opcode_t ila_instruction_data_opcode;
    	   logic [ 0:0] ila_memory_wr_en;
    	   logic [12:0] ila_memory_wr_address;
    	   logic [ 7:0] ila_memory_wr_data;
    	   logic [12:0] ila_memory_rd_address;
    	   logic [ 7:0] ila_memory_rd_data;
    	   logic [ 7:0] ila_alu_op_A;
    	   logic [ 7:0] ila_alu_op_B;
    	   logic [ 7:0] ila_alu_op_S;
    	   logic [ 5:0] ila_alu_op_code;
    	   
    	   logic [ 2:0] ila_axi_slave_select;
           logic [15:0] ila_axi_offset;
           logic        ila_axi_rw;
           logic        ila_axi_req;
           logic        ila_axi_ack;
           logic [ 7:0] ila_axi_data_in;
           logic [ 7:0] ila_axi_data_out;
           logic        ila_axi_error;
           logic [ 9:0] ila_axi_timeout;
           logic [ 3:0] ila_axi_fsm;
    	   
    	   always_ff @ (posedge risc_clk) begin
                ila_resetn              <= risc_resetn;
                ila_irq                 <= irq;
                ila_sw                  <= sw;
                ila_led                 <= led;
                ila_native_i            <= native_i;
                ila_native_o            <= native_o;
                ila_native_t            <= native_t;
                ila_irq_en              <= irq_en;
                ila_irq_pen             <= irq_pen;
                ila_irq_ack             <= irq_ack;
                ila_reg_in1_sel         <= reg_in1_sel;
                ila_reg_in1_mux         <= reg_in1_mux;
                ila_reg_in2_sel         <= reg_in2_sel;
                ila_reg_in2_mux         <= reg_in2_mux;
                ila_reg_out_sel         <= reg_out_sel;
                ila_reg_out             <= reg_out;
                ila_instruction_address <= instruction_address; 
                // Instruction data map ------------------------
		        case (instruction_data[6:0])
                    RISC_INSTRUCTION_OPCODE_R: begin
                        ila_instruction_data_opcode <= RISC_INSTRUCTION_OPCODE_R;
                        ila_instruction_data_func7  <= (risc_instruction_func7_t)'(instruction_data[31:25]);
                        ila_instruction_data_func3  <= (risc_instruction_func3_t)'(instruction_data[14:12]);
                        ila_instruction_data_rd     <= instruction_data[11: 7];
                        ila_instruction_data_rs1    <= instruction_data[19:15];
                        ila_instruction_data_rs2    <= instruction_data[24:20];
                        ila_instruction_data_arg    <= '0;
                    end
                    RISC_INSTRUCTION_OPCODE_I: begin
                        ila_instruction_data_opcode <= RISC_INSTRUCTION_OPCODE_I;
                        ila_instruction_data_func7  <= RISC_INSTRUCTION_FUNC7_UNDEFINED;
                        ila_instruction_data_func3  <= (risc_instruction_func3_t)'(instruction_data[14:12]);
                        ila_instruction_data_rd     <= instruction_data[11: 7];
                        ila_instruction_data_rs1    <= instruction_data[19:15];
                        ila_instruction_data_rs2    <= '0;
                        ila_instruction_data_arg    <= { { (9) { instruction_data[31] } }, instruction_data[31:20]};
                    end
                    RISC_INSTRUCTION_OPCODE_S: begin
                        ila_instruction_data_opcode <= RISC_INSTRUCTION_OPCODE_S;
                        ila_instruction_data_func7  <= RISC_INSTRUCTION_FUNC7_UNDEFINED;
                        ila_instruction_data_func3  <= (risc_instruction_func3_t)'(instruction_data[14:12]);
                        ila_instruction_data_rd     <= '0;
                        ila_instruction_data_rs1    <= instruction_data[19:15];
                        ila_instruction_data_rs2    <= instruction_data[24:20];
                        ila_instruction_data_arg    <= { { (9) { instruction_data[31] } }, instruction_data[31:25], instruction_data[11:7]};
                    end
                    RISC_INSTRUCTION_OPCODE_L: begin
                        ila_instruction_data_opcode <= RISC_INSTRUCTION_OPCODE_L;
                        ila_instruction_data_func7  <= RISC_INSTRUCTION_FUNC7_UNDEFINED;
                        ila_instruction_data_func3  <= (risc_instruction_func3_t)'(instruction_data[14:12]);
                        ila_instruction_data_rd     <= instruction_data[11: 7];
                        ila_instruction_data_rs1    <= instruction_data[19:15];
                        ila_instruction_data_rs2    <= '0;
                        ila_instruction_data_arg    <= { { (9) { instruction_data[31] } }, instruction_data[31:20]};
                    end
                    RISC_INSTRUCTION_OPCODE_B: begin
                        ila_instruction_data_opcode <= RISC_INSTRUCTION_OPCODE_B;
                        ila_instruction_data_func7  <= RISC_INSTRUCTION_FUNC7_UNDEFINED;
                        ila_instruction_data_func3  <= (risc_instruction_func3_t)'(instruction_data[14:12]);
                        ila_instruction_data_rd     <= '0;
                        ila_instruction_data_rs1    <= instruction_data[19:15];
                        ila_instruction_data_rs2    <= instruction_data[24:20];
                        ila_instruction_data_arg    <= { { (9) { instruction_data[31] } }, instruction_data[7], instruction_data[30:25], instruction_data[11:8], 1'b0};
                    end
                    RISC_INSTRUCTION_OPCODE_J: begin
                        ila_instruction_data_opcode <= RISC_INSTRUCTION_OPCODE_J;
                        ila_instruction_data_func7  <= RISC_INSTRUCTION_FUNC7_UNDEFINED;
                        ila_instruction_data_func3  <= RISC_INSTRUCTION_FUNC3_0;
                        ila_instruction_data_rd     <= instruction_data[11 :7];
                        ila_instruction_data_rs1    <= '0;
                        ila_instruction_data_rs2    <= '0;
                        ila_instruction_data_arg    <= {instruction_data[31], instruction_data[19:12], instruction_data[20], instruction_data[30:21], 1'b0};
                    end
                    RISC_INSTRUCTION_OPCODE_RAS: begin
                        ila_instruction_data_opcode <= RISC_INSTRUCTION_OPCODE_RAS;
                        ila_instruction_data_func7  <= RISC_INSTRUCTION_FUNC7_UNDEFINED;
                        ila_instruction_data_func3  <= RISC_INSTRUCTION_FUNC3_0;
                        ila_instruction_data_rd     <= instruction_data[11: 7];
                        ila_instruction_data_rs1    <= instruction_data[19:15];
                        ila_instruction_data_rs2    <= '0;
                        ila_instruction_data_arg    <= instruction_data[31:20];        
                    end
                    default: begin
                        ila_instruction_data_opcode <= RISC_INSTRUCTION_OPCODE_UNDEFINED;
                        ila_instruction_data_func7  <= RISC_INSTRUCTION_FUNC7_UNDEFINED;
                        ila_instruction_data_func3  <= RISC_INSTRUCTION_FUNC3_0;
                        ila_instruction_data_rd     <= '0;
                        ila_instruction_data_rs1    <= '0;
                        ila_instruction_data_rs2    <= '0;
                        ila_instruction_data_arg    <= '0;
                    end
                endcase
                //----------------------------------------------
                ila_memory_wr_en        <= memory_wr_en;
                ila_memory_wr_address   <= memory_wr_address;
                ila_memory_wr_data      <= memory_wr_data;
                ila_memory_rd_address   <= memory_rd_address;
                ila_memory_rd_data      <= memory_rd_data;
                ila_alu_op_A            <= alu_op_A;
                ila_alu_op_B            <= alu_op_B;
                ila_alu_op_S            <= alu_op_S;
                ila_alu_op_code         <= alu_op_code;   
                
                    	   
                ila_axi_slave_select    <= axi_slave_select;
                ila_axi_offset          <= axi_offset;
                ila_axi_rw              <= axi_rw;
                ila_axi_req             <= axi_req;
                ila_axi_ack             <= axi_ack;
                ila_axi_data_in         <= axi_data_in;
                ila_axi_data_out        <= axi_data_out;
                ila_axi_error           <= axi_error;
                ila_axi_timeout         <= axi_timeout;
                ila_axi_fsm             <= axi_fsm;
    	   end

    	   risc_ila risc_validation_core_inst (
    			.clk 	     (risc_clk),  				// input wire 		 clk
    			.probe0	     (ila_resetn),
    			.probe1      (ila_irq),
    			.probe2      (ila_sw),
    			.probe3      (ila_led),
    			.probe4      (ila_native_i),
    			.probe5      (ila_native_o), 
    			.probe6      (ila_native_t),
    			.probe7      (ila_irq_en),
    			.probe8      (ila_irq_pen),
    			.probe9      (ila_irq_ack),
    			.probe10     (ila_reg_in1_sel),
    			.probe11     (ila_reg_in1_mux),
    			.probe12     (ila_reg_in2_sel),
    			.probe13     (ila_reg_in2_mux),
    			.probe14     (ila_reg_out_sel),
    			.probe15     (ila_reg_out),
    			.probe16     (ila_instruction_address),
    			.probe17     (ila_instruction_data_arg),
    			.probe18     (ila_instruction_data_rd),
    			.probe19     (ila_instruction_data_rs1),
    			.probe20     (ila_instruction_data_rs2),
    			.probe21     (ila_instruction_data_func7),
    			.probe22     (ila_instruction_data_func3),
    			.probe23     (ila_instruction_data_opcode),
    			.probe24     (ila_memory_wr_en),
    			.probe25     (ila_memory_wr_address),
    			.probe26     (ila_memory_wr_data),
    			.probe27     (ila_memory_rd_address),
    			.probe28     (ila_memory_rd_data),
    			.probe29     (ila_alu_op_A),
    			.probe30     (ila_alu_op_B),
    			.probe31     (ila_alu_op_S),
    			.probe32     (ila_alu_op_code),
    			.probe33     (ila_axi_slave_select),
    			.probe34     (ila_axi_offset),
    			.probe35     (ila_axi_rw),
    			.probe36     (ila_axi_req),
    			.probe37     (ila_axi_ack),
    			.probe38     (ila_axi_data_in),
    			.probe39     (ila_axi_data_out),
    			.probe40     (ila_axi_error),
    			.probe41     (ila_axi_timeout),
    			.probe42     (ila_axi_fsm)
            );
    	end
    endgenerate
endmodule
