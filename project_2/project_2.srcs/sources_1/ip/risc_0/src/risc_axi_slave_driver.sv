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
`include "logic.svh"

import logic_axi4_lite_pkg::*;

module risc_axi_slave_driver #(
	parameter WIDTH						= 8,
	parameter TIMEOUT					= 1000,
	parameter BASEADDRESS				= 32'h0,
	parameter SIZE						= 8192
)(
    input               						clk,
    input               						rstn,
    `LOGIC_MODPORT(logic_axi4_lite_if, slave) 	s_axi,
    input 			[15:0]						address,
    input										wr_en,
    input			[WIDTH-1:0]					wr_data,
    output logic	[WIDTH-1:0]					rd_data
);
	
	logic [ 3:0] mem_axi_wr_strobe;
	logic [31:0] mem_axi_address;
	logic [31:0] mem_axi_wr_data;
	logic [31:0] mem_axi_rd_data;

	logic [ 3:0] mem_id_wr_strobe;
	logic [31:0] mem_id_address;
	logic [31:0] mem_id_wr_data;
	logic [31:0] mem_id_rd_data;
	
	risc_shared_memory_8K risc_shared_memory_inst (
		.clka	(clk),
		.wea	(mem_axi_wr_strobe),
		.addra	(mem_axi_address),
		.dina	(mem_axi_wr_data),
		.douta	(mem_axi_rd_data),
		.clkb	(clk),
		.web	(mem_id_wr_strobe),
		.addrb	(mem_id_address),
		.dinb	(mem_id_wr_data),
		.doutb	(mem_id_rd_data)
	);
	
	logic [1:0] address_lsb_ff [1:0];
	
	always_ff @ (posedge clk or negedge rstn) begin
		if (!rstn) begin
			for (int i = 0; i < 2; i++) address_lsb_ff[i] <= 0;
		end
		else begin
			address_lsb_ff[0] <= address[1:0];
			address_lsb_ff[1] <= address_lsb_ff[0];
		end
	end
		
	always_comb begin
		case (address[1:0]) 
			2'b00: 	 mem_id_wr_strobe = wr_en ? 4'b0001 : 4'b0000;
			2'b01: 	 mem_id_wr_strobe = wr_en ? 4'b0010 : 4'b0000;
			2'b10: 	 mem_id_wr_strobe = wr_en ? 4'b0100 : 4'b0000;
			2'b11: 	 mem_id_wr_strobe = wr_en ? 4'b1000 : 4'b0000;
			default: mem_id_wr_strobe = '0;
		endcase
		mem_id_address = { 16'b0, address[15:2], 2'b00 };
		case (address[1:0]) 
			2'b00: 	 mem_id_wr_data = { 24'b0, wr_data };
			2'b01: 	 mem_id_wr_data = { 16'b0, wr_data,  8'b0 };
			2'b10: 	 mem_id_wr_data = {  8'b0, wr_data, 16'b0 };
			2'b11: 	 mem_id_wr_data = {        wr_data, 24'b0 };
			default: mem_id_wr_data = '0;
		endcase
		case (address_lsb_ff[0][1:0]) 
			2'b00: 	 rd_data = mem_id_rd_data[ 7: 0];
			2'b01: 	 rd_data = mem_id_rd_data[15: 8];
			2'b10: 	 rd_data = mem_id_rd_data[23:16];
			2'b11: 	 rd_data = mem_id_rd_data[31:24];
			default: rd_data = '0;
		endcase		
	end
	
	typedef enum logic [2:0] {
		FSM_AXI_IDLE,
		FSM_AXI_READ_RESPONSE,
		FSM_AXI_WRITE_DATA,
		FSM_AXI_WRITE_RESPONSE,
		FSM_AXI_MEM_WRITE,
		FSM_AXI_MEM_READ,
		FSM_AXI_MEM_READ_DELAY,
		FSM_AXI_RETURN
	} fsm_t;
	
	fsm_t fsm;
	
	localparam TIMEOUT_CNT_WIDTH = int'($ceil($clog2(TIMEOUT)));
	
	logic [TIMEOUT_CNT_WIDTH-1:0] timeout_cnt;
	
	logic [31:0] axi_address;
	logic [ 3:0] axi_we;
	logic [31:0] axi_data;
	logic axi_error;
	
	always_ff @ (posedge clk or negedge rstn) begin
		if (!rstn) begin
			fsm 			<= FSM_AXI_IDLE;
			timeout_cnt		<= TIMEOUT;
			axi_address		<= 0;
			axi_we			<= 0;
			axi_data		<= 0;
			axi_error		<= 0;
			// Reset AW channel
			s_axi.awready 	<= 0;
			// Reset W channel
			s_axi.wready 	<= 0;
			// Reset B channel
			s_axi.bvalid	<= 0;
			s_axi.bresp		<= '0;
			// Reset AR channel
			s_axi.arready	<= 0;
			// Reset R channel
			s_axi.rvalid	<= 0;
			s_axi.rdata		<= '0;
			s_axi.rresp		<= 0;
		end
		else begin
			case (fsm)
				FSM_AXI_IDLE: begin
					if (s_axi.awvalid && s_axi.awready) begin
						if (s_axi.awaddr >= BASEADDRESS && s_axi.awaddr < BASEADDRESS+SIZE) begin
							axi_address <= s_axi.awaddr;
							axi_error	<= 0;
							if (s_axi.wvalid && s_axi.wready) begin
								axi_we			<= s_axi.wstrb;
								axi_data		<= s_axi.wdata;			
								s_axi.wready	<= 0;
								fsm 			<= FSM_AXI_MEM_WRITE;
							end
							else begin
								fsm <= FSM_AXI_WRITE_DATA;
							end							
						end
						else begin
							axi_address	<= 0;
							axi_error	<= 1;
							if (s_axi.wvalid && s_axi.wready) begin						
								s_axi.wready	<= 0;
								fsm <= FSM_AXI_WRITE_RESPONSE;
							end
							else begin
								fsm <= FSM_AXI_WRITE_DATA;
							end									
						end
						s_axi.awready	<= 0;
						s_axi.arready 	<= 0;
					end
					else if (s_axi.arvalid && s_axi.arready) begin
						if (s_axi.araddr >= BASEADDRESS && s_axi.araddr < BASEADDRESS+SIZE) begin
							axi_address <= s_axi.araddr;
							axi_error	<= 0;
							fsm			<= FSM_AXI_MEM_READ;
						end
						else begin
							axi_address	<= 0;
							axi_error	<= 1;
							fsm 		<= FSM_AXI_READ_RESPONSE;
						end			
						s_axi.awready	<= 0;
						s_axi.arready 	<= 0;
						s_axi.wready	<= 0;
					end
					else begin
						s_axi.awready <= 1;
						s_axi.arready <= 1;
						s_axi.wready  <= 1;
						axi_error	  <= 0;
					end
				end
				FSM_AXI_WRITE_DATA: begin
					if (s_axi.wvalid && s_axi.wready) begin
						if (axi_error) begin
							axi_we			<= 0;
							axi_data		<= 0;
							fsm				<= FSM_AXI_WRITE_RESPONSE;
						end
						else begin
							axi_we			<= s_axi.wstrb;
							axi_data		<= s_axi.wdata;			
							fsm 			<= FSM_AXI_MEM_WRITE;							
						end
						s_axi.wready <= 0;
					end
				end
				FSM_AXI_MEM_WRITE: begin
					mem_axi_wr_strobe		<= axi_we;
		 			mem_axi_address			<= axi_address;
			 		mem_axi_wr_data			<= axi_data;
			 		fsm						<= FSM_AXI_WRITE_RESPONSE;
				end
				FSM_AXI_WRITE_RESPONSE: begin
					mem_axi_wr_strobe		<= 0;
					mem_axi_address			<= 0;
					mem_axi_wr_data			<= 0;
					if (s_axi.bvalid && s_axi.bready) begin
						s_axi.bvalid		<= 0;
						s_axi.bresp			<= 0;	
						fsm 				<= FSM_AXI_RETURN;
					end
					else begin
						s_axi.bvalid		<= 1;
						if (axi_error) s_axi.bresp <= RESPONSE_DECERR;
						else		   s_axi.bresp <= RESPONSE_OKAY;						
					end

				end
				FSM_AXI_MEM_READ: begin
					mem_axi_address			<= axi_address;
					mem_axi_wr_strobe		<= 0;
					mem_axi_wr_data			<= 0;
					fsm						<= FSM_AXI_MEM_READ_DELAY;
				end
				FSM_AXI_MEM_READ_DELAY: begin
					mem_axi_address			<= 0;
					fsm 					<= FSM_AXI_READ_RESPONSE;
				end
				FSM_AXI_READ_RESPONSE: begin
					if (s_axi.rvalid && s_axi.rready) begin
						s_axi.rvalid 	<= 0;
						s_axi.rdata		<= 0;
						s_axi.rresp 	<= 0;
						fsm				<= FSM_AXI_RETURN;
					end
					else begin
						s_axi.rvalid <= 1;
						if (axi_error) begin
							s_axi.rdata	 <= 0;
							s_axi.rresp  <= RESPONSE_DECERR;
						end
						else begin
							s_axi.rdata	 <= mem_axi_rd_data;
							s_axi.rresp	 <= RESPONSE_OKAY;
						end
					end
				end
				FSM_AXI_RETURN: begin
					fsm 			<= FSM_AXI_IDLE;
					timeout_cnt		<= TIMEOUT;
					axi_address		<= 0;
					axi_we			<= 0;
					axi_data		<= 0;
					axi_error		<= 0;
					// Reset AW channel
					s_axi.awready 	<= 0;
					// Reset W channel
					s_axi.wready 	<= 0;
					// Reset B channel
					s_axi.bvalid	<= 0;
					s_axi.bresp		<= '0;
					// Reset AR channel
					s_axi.arready	<= 0;
					// Reset R channel
					s_axi.rvalid	<= 0;
					s_axi.rdata		<= 0;
					s_axi.rresp		<= 0;
				end
			endcase
		end
	end
endmodule
