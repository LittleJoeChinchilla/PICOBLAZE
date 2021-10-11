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

module risc_registers
(
    input	logic		clk,
    input	logic		shadow_en,
    input 	logic [4:0] src_1_sel,
    input	logic [4:0] src_2_sel,
    input	logic [4:0] dest_sel,
    input	logic		dest_en,
    output	logic [7:0] src_1,
    output	logic [7:0] src_2,
    input 	logic [7:0] dest
);
	
	risc_registers_memory memory_1 (
		.clka	(clk),
		.wea	(dest_en),
		.addra	({shadow_en, dest_sel}),
		.dina	(dest),
		.clkb	(clk),
		.addrb	({shadow_en, src_1_sel}),
		.doutb	(src_1)
	);
	
	risc_registers_memory memory_2 (
		.clka	(clk),
		.wea	(dest_en),
		.addra	({shadow_en, dest_sel}),
		.dina	(dest),
		.clkb	(clk),
		.addrb	({shadow_en, src_2_sel}),
		.doutb	(src_2)
	);	
endmodule