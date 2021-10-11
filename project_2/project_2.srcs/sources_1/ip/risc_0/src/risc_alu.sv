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

import risc_alu_pkg::*;

module risc_alu
(
    input   logic           aclk,
    input   logic           arstn,
    input   logic   [5:0]   opcode,
    input   logic   [7:0]   op_a,
    input   logic   [7:0]   op_b,
    output  logic   [7:0]   result
);
    
    logic [1:0]     SEL_dsp;
    logic [8:0]     A_dsp;
    logic [7:0]     B_dsp;
    logic [8:0]     C_dsp;
    logic [17:0]    P_dsp;
    
    logic [7:0]		A_logic;
    logic [7:0]		B_logic;
    logic [7:0]		P_logic;
    			

    risc_alu_dsp risc_alu_dsp_inst
    (
    	.CLK(aclk),
        .SEL(SEL_dsp),
        .A	(A_dsp),
        .B	(B_dsp),
        .C	(C_dsp),
        .P	(P_dsp)
    );
    
    logic [5:0] opcode_ff [1:0];

    // Arithmetic, compare operation inputs process
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		SEL_dsp <= '0;
    		A_dsp 	<= '0;
    		B_dsp 	<= '0;
    		C_dsp 	<= '0;    		
    	end
    	else begin
    		if (opcode[5:4] == OP_TYPE_ARITHMETIC) begin
    			case (opcode)
    				OP_ADD: begin
    					SEL_dsp <= 0;
    					A_dsp 	<= { op_a[7], op_a };
    					B_dsp 	<= '0;
    					C_dsp 	<= { op_b[7], op_b };
    				end
    				OP_SUB: begin
    					SEL_dsp <= 1;
    					A_dsp 	<= { op_a[7], op_a };
    					B_dsp 	<= '0;
    					C_dsp 	<= { op_b[7], op_b };
    				end
    				OP_MUL: begin
    					SEL_dsp <= 2;
    					A_dsp 	<= { op_a[7], op_a };
    					B_dsp 	<= op_b;
    					C_dsp 	<= '0;
    				end
    				default: begin
    					SEL_dsp <= '0;
    					A_dsp 	<= '0;
    					B_dsp 	<= '0;
    					C_dsp 	<= '0;                     		
    				end
    			endcase    			
    		end
    		else if (opcode[5:4] == OP_TYPE_COMPARE) begin
    			SEL_dsp <= 1;
    			if (opcode == OP_SLTU || opcode == OP_SGTU) begin
    				A_dsp 	<= { 1'b0, op_a };
    				C_dsp 	<= { 1'b0, op_b };  
    			end
    			else begin
    				A_dsp 	<= { op_a[7], op_a };
    				C_dsp 	<= { op_b[7], op_b };
    			end
    			B_dsp 	<= '0;   			
    		end
    		else begin
    			SEL_dsp <= '0;
    			A_dsp 	<= '0;
    			B_dsp 	<= '0;
    			C_dsp 	<= '0;     			
    		end
    	end
    end
    
    // Logic, shift operation inputs process
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		A_logic <= '0;
    		B_logic <= '0;
    	end
    	else begin
    		if (opcode[5:4] == OP_TYPE_LOGIC || OP_TYPE_SHIFT) begin
    			A_logic <= op_a;
    			B_logic <= op_b;
    		end
    		else begin
    			A_logic <= '0;
    			B_logic <= '0;
    		end
    	end
    end
    
    // Opcode delay
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		for (int i = 0; i < 2; i++) opcode_ff[i] <= '0;
    	end
    	else begin
  			opcode_ff[0] <= opcode;
  			opcode_ff[1] <= opcode_ff[0];
    	end
    end
    
    // Logic operands implementation
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		P_logic <= '0;
    	end
    	else begin
    	 	if (opcode_ff[0][5:4] == OP_TYPE_LOGIC) begin
    			case (opcode_ff[0])
    				OP_AND: 	P_logic <= A_logic & B_logic;
    				OP_OR: 		P_logic <= A_logic | B_logic; 
    				OP_XOR: 	P_logic <= A_logic ^ B_logic;	                                
    				default:  	P_logic <= '0;
    			endcase     			
    		end
    		else if (opcode_ff[0][5:4] == OP_TYPE_SHIFT) begin
    			case (opcode_ff[0])
    				OP_SLA: begin
    					case(B_logic)
    						1: 		 	P_logic <= { A_logic[7], A_logic[5:0], { (1) {1'b0} } };
    						2: 			P_logic <= { A_logic[7], A_logic[4:0], { (2) {1'b0} } };
    						3: 			P_logic <= { A_logic[7], A_logic[3:0], { (3) {1'b0} } };
    						4: 			P_logic <= { A_logic[7], A_logic[2:0], { (4) {1'b0} } };
    						5: 			P_logic <= { A_logic[7], A_logic[1:0], { (5) {1'b0} } };
    						6: 			P_logic <= { A_logic[7], A_logic[  0], { (6) {1'b0} } };
    						7: 			P_logic <= { A_logic[7], 		       { (7) {1'b0} } };
    						default: 	P_logic <=   A_logic;
    					endcase                            
    				end
    				OP_SRA: begin
    					case(B_logic)
    						1: 			P_logic <= { { (2) { A_logic[7] } }, A_logic[6:1] };
    						2: 			P_logic <= { { (3) { A_logic[7] } }, A_logic[6:2] };
    						3: 			P_logic <= { { (4) { A_logic[7] } }, A_logic[6:3] };
    						4: 			P_logic <= { { (5) { A_logic[7] } }, A_logic[6:4] };
    						5: 			P_logic <= { { (6) { A_logic[7] } }, A_logic[6:5] };
    						6:  		P_logic <= { { (7) { A_logic[7] } }, A_logic[  6] };
    						7: 			P_logic <= {   (8) { A_logic[7] } };
    						default:	P_logic <=  		    			 A_logic;
    					endcase                                
    				end    		
    			 	OP_SLL: begin
    					case(B_logic)
    						1: 		 	P_logic <= { A_logic[6:0], { (1) {1'b0} } };
    						2: 			P_logic <= { A_logic[5:0], { (2) {1'b0} } };
    						3: 			P_logic <= { A_logic[4:0], { (3) {1'b0} } };
    						4: 			P_logic <= { A_logic[3:0], { (4) {1'b0} } };
    						5: 			P_logic <= { A_logic[2:0], { (5) {1'b0} } };
    						6: 			P_logic <= { A_logic[1:0], { (6) {1'b0} } };
    						7: 			P_logic <= { A_logic[  0], { (7) {1'b0} } };
    						default: 	P_logic <=   A_logic;
    					endcase                            
    				end    				
    				OP_SRL: begin
    					case(B_logic)
    						1: 			P_logic <= { { (1) {1'b0} }, A_logic[7:1] };
    						2: 			P_logic <= { { (2) {1'b0} }, A_logic[7:2] };
    						3: 			P_logic <= { { (3) {1'b0} }, A_logic[7:3] };
    						4: 			P_logic <= { { (4) {1'b0} }, A_logic[7:4] };
    						5: 			P_logic <= { { (5) {1'b0} }, A_logic[7:5] };
    						6: 			P_logic <= { { (6) {1'b0} }, A_logic[7:6] };
    						7: 			P_logic <= { { (7) {1'b0} }, A_logic[7  ] };
    						default: 	P_logic <= 					 A_logic;
    					endcase
    				end         
    				default: P_logic <= '0;
    			endcase
    		end
    		else begin
    			P_logic <= '0;
    		end
    	end
    end
    
    // Output
    always_ff @ (posedge aclk or negedge arstn) begin
    	if (!arstn) begin
    		result <= '0;
    	end
    	else begin
    		if (opcode_ff[1][5:4] == OP_TYPE_ARITHMETIC) begin
    			result <= P_dsp[7:0];
    		end
    		else if (opcode_ff[1][5:4] == OP_TYPE_COMPARE) begin
    			case (opcode_ff[1])
    				OP_SLT, OP_SLTU: 	result <= (P_dsp[17] ? 1 : 0);
    				OP_SGT, OP_SGTU: 	result <= ( (P_dsp[17] || (P_dsp == '0)) ? 0 : 1);
    				OP_SNE: 			result <= (P_dsp == '0 ? 0 : 1);
    				OP_SEQ: 			result <= (P_dsp == '0 ? 1 : 0);
    				default: 			result <= '0;
    			endcase
    		end
    		else if ((opcode_ff[1][5:4] == OP_TYPE_LOGIC) || (opcode_ff[1][5:4] == OP_TYPE_SHIFT)) begin
    			result <= P_logic;
    		end
    		else begin
    			result <= '0;
    		end
    	end
    end
    
    // synthesis translate_off
    logic [7:0] monitor_op_a 	[4];
    logic [7:0] monitor_op_b 	[4];
    logic [5:0] monitor_opcode	[4];
    logic [7:0] monitor_result	[4];
    always_ff @ (posedge aclk) begin
    	monitor_op_a[0] <= op_a;
    	monitor_op_b[0] <= op_b;
    	monitor_opcode[0]	<= opcode;
    	monitor_result[0] <= result;
    	for (int i = 1; i < 4; i++) begin
    		monitor_op_a[i] <= monitor_op_a[i-1];
    		monitor_op_b[i] <= monitor_op_b[i-1];
    		monitor_opcode[i] <= monitor_opcode[i-1];
    		monitor_result[i] <= monitor_result[i-1];
    	end 
    end
    
    task automatic display();
    	risc_alu_opcodes_t _opcode 		= risc_alu_opcodes_t'(opcode);
    	risc_alu_opcodes_t _opcode_ff 	= risc_alu_opcodes_t'(monitor_opcode[0]);
    	risc_alu_opcodes_t _opcode_ff2 	= risc_alu_opcodes_t'(monitor_opcode[1]);
    	
    	$display("***** ALU [t=%0t] *****", $time);
    	
    	if (opcode[5:4] == OP_TYPE_ARITHMETIC || opcode[5:4] == OP_TYPE_COMPARE) 						$display("INPUTS: A=%0d,\tB=%0d,\tOPCODE=%s", $signed(op_a), $signed(op_b), _opcode.name);
    	if (opcode[5:4] == OP_TYPE_LOGIC)		 								 						$display("INPUTS: A=%b,\tB=%b,\tOPCODE=%s", op_a, op_b, _opcode.name);
    	if (opcode[5:4] == OP_TYPE_SHIFT)										 						$display("INPUTS: A=%b,\tB=%0d,\tOPCODE=%s", op_a, op_b, _opcode.name);
     	
    	if (monitor_opcode[0][5:4] == OP_TYPE_ARITHMETIC || monitor_opcode[0][5:4]== OP_TYPE_COMPARE) 	$display("PROCESS: A=%0d,\tB=%0d,\tOPCODE=%s", $signed(monitor_op_a[0]), $signed(monitor_op_b[0]), _opcode_ff.name);
    	if (monitor_opcode[0][5:4] == OP_TYPE_LOGIC)		 								 		 	$display("PROCESS: A=%b,\tB=%b,\tOPCODE=%s", monitor_op_a[0], monitor_op_b[0], _opcode_ff.name);
    	if (monitor_opcode[0][5:4] == OP_TYPE_SHIFT)										 		 	$display("PROCESS: A=%b,\tB=%0d,\tOPCODE=%s", monitor_op_a[0], $unsigned(monitor_op_b[0]), _opcode_ff.name);   	
    	
    	if (monitor_opcode[1][5:4] == OP_TYPE_ARITHMETIC || monitor_opcode[1][5:4] == OP_TYPE_COMPARE) 	$display("RESULT: P=%0d", $signed(P_dsp));
    	if (monitor_opcode[1][5:4] == OP_TYPE_LOGIC || monitor_opcode[1][5:4] == OP_TYPE_SHIFT)		 	$display("RESULT: P=%b", P_logic);	    	
    	
    	if (monitor_opcode[2][5:4] == OP_TYPE_ARITHMETIC || monitor_opcode[2][5:4] == OP_TYPE_COMPARE) 	$display("OUTPUT: P=%0d", $signed(result));
    	if (monitor_opcode[2][5:4] == OP_TYPE_LOGIC || monitor_opcode[2][5:4] == OP_TYPE_SHIFT)		 	$display("OUTPUT: P=%b", result);	    	
    endtask
    // synthesis translate_on
endmodule
