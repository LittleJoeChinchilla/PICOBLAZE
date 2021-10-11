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

module risc_jtag_axi4_lite_wrapper
(
    input	logic							   clk,
    input	logic							   rstn,
    `LOGIC_MODPORT(logic_axi4_lite_if, master) m_axi
);
	
	parameter ADDRESS_WIDTH = 32;
	parameter DATA_BYTES    = 4;
	
	logic	[ADDRESS_WIDTH-1:0]		m_axi_awaddr;
	logic 							m_axi_awvalid;
	logic							m_axi_awready;
	
	logic	[8*DATA_BYTES-1:0]		m_axi_wdata;
	logic							m_axi_wready;
	logic	[DATA_BYTES-1:0]  		m_axi_wstrb;
	logic							m_axi_wvalid;
	
	logic	[ADDRESS_WIDTH-1:0]		m_axi_araddr;
	logic							m_axi_arready;
	logic							m_axi_arvalid;

	logic							m_axi_bready;
	logic	[1:0]					m_axi_bresp;
	logic							m_axi_bvalid;
	
	logic	[8*DATA_BYTES-1:0]		m_axi_rdata;
	logic							m_axi_rready;
	logic	[1:0]					m_axi_rresp;
	logic							m_axi_rvalid;	
	
	risc_jtag_axi4_lite risc_jtag_axi4_lite_inst (
		.aclk			(clk),				// input wire aclk
		.aresetn		(rstn),				// input wire aresetn
		.m_axi_awaddr	(m_axi_awaddr),  	// output wire [31 : 0] m_axi_awaddr
		.m_axi_awprot	(m_axi_awprot),    	// output wire [2 : 0] m_axi_awprot
		.m_axi_awvalid	(m_axi_awvalid),  	// output wire m_axi_awvalid
		.m_axi_awready	(m_axi_awready),  	// input wire m_axi_awready
		.m_axi_wdata	(m_axi_wdata),      // output wire [31 : 0] m_axi_wdata
		.m_axi_wstrb	(m_axi_wstrb),      // output wire [3 : 0] m_axi_wstrb
		.m_axi_wvalid	(m_axi_wvalid),    	// output wire m_axi_wvalid
		.m_axi_wready	(m_axi_wready),  	// input wire m_axi_wready
		.m_axi_bresp	(m_axi_bresp),      // input wire [1 : 0] m_axi_bresp
		.m_axi_bvalid	(m_axi_bvalid),    	// input wire m_axi_bvalid
		.m_axi_bready	(m_axi_bready),    	// output wire m_axi_bready
		.m_axi_araddr	(m_axi_araddr),    	// output wire [31 : 0] m_axi_araddr
		.m_axi_arprot	(m_axi_arprot),    	// output wire [2 : 0] m_axi_arprot
		.m_axi_arvalid	(m_axi_arvalid),  	// output wire m_axi_arvalid
		.m_axi_arready	(m_axi_arready),  	// input wire m_axi_arready
		.m_axi_rdata	(m_axi_rdata),      // input wire [31 : 0] m_axi_rdata
		.m_axi_rresp	(m_axi_rresp),      // input wire [1 : 0] m_axi_rresp
		.m_axi_rvalid	(m_axi_rvalid),    	// input wire m_axi_rvalid
		.m_axi_rready	(m_axi_rready)    	// output wire m_axi_rready
	);	
	
	always_comb begin
		m_axi.awaddr 	= m_axi_awaddr;
		m_axi.awvalid 	= m_axi_awvalid;
		m_axi_awready 	= m_axi.awready;
	
		m_axi.wdata 	= m_axi_wdata;
		m_axi_wready 	= m_axi.wready;
		m_axi.wstrb 	= m_axi_wstrb;
		m_axi.wvalid 	= m_axi_wvalid;
	
		m_axi.araddr	= m_axi_araddr;
		m_axi_arready	= m_axi.arready;
		m_axi.arvalid	= m_axi_arvalid;

		m_axi.bready	= m_axi_bready;
		m_axi_bresp		= m_axi.bresp;
		m_axi_bvalid	= m_axi.bvalid;
	
		m_axi_rdata		= m_axi.rdata;
		m_axi.rready	= m_axi_rready;
		m_axi_rresp		= m_axi.rresp;
		m_axi_rvalid	= m_axi.rvalid;			
	end
	
endmodule