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

module risc_stack #(
	parameter RISC_STACK_WIDTH = 32,
	parameter RISC_STACK_DEPTH = 64
)(
    input	logic							clk,
    input	logic							reset_n,
    input 	logic 						 	pop_en,
    output	logic [RISC_STACK_WIDTH-1:0] 	pop_data,
    output	logic							pop_empty,
    input	logic  							push_en,
    input	logic [RISC_STACK_WIDTH-1:0]	push_data,
    output	logic 							push_full
);

	logic [		  RISC_STACK_WIDTH -1:0]    stack [RISC_STACK_DEPTH-1:0];
	logic [$clog2(RISC_STACK_DEPTH)+1-1:0] 	cnt;
	logic [$clog2(RISC_STACK_DEPTH)+1-1:0] 	max_cnt;

	assign max_cnt = {1'b0, {($clog2(RISC_STACK_DEPTH)) {1'b1} }};
	
	always_ff @ (posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			cnt <= '0;
			for (int i = 0; i < RISC_STACK_DEPTH; i++) stack[i] <= '0;
			pop_empty 	<= 1;
			push_full 	<= 0;
		end
		else begin
			if (push_en && pop_en) begin
				pop_data 	<= stack[cnt];
				stack[cnt] 	<= push_data;
			end
			else if (push_en && !push_full) begin
				stack[cnt] 		<= push_data;
				cnt 			<= cnt + 1;
				if (cnt >= max_cnt) begin
					push_full 	<= 1;
				end
				else begin
					pop_empty 	<= 0;					
				end 
			end
			else if (pop_en && !pop_empty) begin
				pop_data 	<= stack[cnt-1];
				cnt 		<= cnt - 1;
				if (cnt == 1) begin
					pop_empty 	<= 1;
				end
				else begin
					push_full 	<= 0;
				end
			end
		end
	end	
	
endmodule