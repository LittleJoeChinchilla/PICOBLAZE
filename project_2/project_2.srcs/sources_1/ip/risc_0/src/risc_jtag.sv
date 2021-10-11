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

module risc_jtag
(
    input 				clk,
    input 				rst,
    input				locked,
    output logic		jtag_reset,
    output logic 		halt,
    output logic [12:0] instruction_address,
    output logic [31:0] instruction_data,
    output logic 		instruction_wr_en
);
	
	logic rstn;
	risc_reset reset_inst (
		.slowest_sync_clk		(clk),
		.ext_reset_in			(rst),
		.aux_reset_in			(1'b0),
		.mb_debug_sys_rst		(1'b0),
		.dcm_locked				(locked),
		.mb_reset				(),
		.bus_struct_reset		(),
		.peripheral_reset		(),
		.interconnect_aresetn	(),
		.peripheral_aresetn		(rstn)
	);
	
	logic  aclk;
	logic  areset_n;
	assign aclk 	= clk;
	assign areset_n = rstn;
	logic_axi4_lite_if #(
		.DATA_BYTES     (32),
		.ADDRESS_WIDTH  (32)
	) s_axi (.*);
	
	risc_jtag_axi4_lite_wrapper risc_jtag_axi4_lite_wrapper_inst (
		.clk	(clk),
		.rstn	(rstn),
		.m_axi	(s_axi)
	);
	
	always_ff @ (posedge clk or negedge rstn) begin
		if (!rstn) begin
			s_axi.awready <= 0;
			s_axi.wready  <= 0;
			s_axi.bvalid  <= 0;
			instruction_address <= '0;
			instruction_data	<= '0;
			instruction_wr_en 	<= 0;
			jtag_reset			<= 0;
			halt				<= 0;
		end
		else begin
			if (s_axi.awvalid && s_axi.wvalid) begin
				s_axi.awready 		<= 1;
				s_axi.wready  		<= 1;
				s_axi.bvalid  		<= 1;	
				if (s_axi.awaddr == 32'h10000) begin
					if (s_axi.wdata[0] == 1) jtag_reset <= 1;
					else					 jtag_reset <= 0;
					instruction_address <= '0;
					instruction_data	<= '0;
					instruction_wr_en 	<= 0;
				end
				else if (s_axi.awaddr >= 32'h0 && s_axi.awaddr < 32'h10000) begin	
					instruction_address <= s_axi.awaddr[12:0];
					instruction_data	<= {s_axi.wdata[3],s_axi.wdata[2],s_axi.wdata[1],s_axi.wdata[0]};
					instruction_wr_en 	<= 1;
				end
				else begin
					instruction_address <= '0;
					instruction_data	<= '0;
					instruction_wr_en 	<= 0;
				end
			end
			else begin
				instruction_address <= '0;
				instruction_data	<= '0;
				instruction_wr_en 	<= 0;
				s_axi.awready <= 0;
				s_axi.wready  <= 0;
				s_axi.bvalid  <= 0;				
			end
		end
	end
	

endmodule