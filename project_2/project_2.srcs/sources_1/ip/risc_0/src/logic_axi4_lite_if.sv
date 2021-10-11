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

`include "logic.svh"

/* Interface: logic_axi4_lite_if
 *
 * AXI4-Lite interface.
 *
 * Parameters:
 *  DATA_BYTES      - Number of bytes for wdata and rdata signals.
 *  ADDRESS_WIDTH   - Number of bits for awaddr and araddr signals.
 *
 * Ports:
 *  aclk        - Clock. Used only for internal checkers and assertions
 *  areset_n    - Asynchronous active-low reset. Used only for internal checkers
 *                and assertions
 */
interface logic_axi4_lite_if #(
	int DATA_BYTES = 4,
	int ADDRESS_WIDTH = 32
) (
	input aclk,
	input areset_n
);

	typedef logic [ADDRESS_WIDTH-1:0] 		addr_t;
	typedef logic [DATA_BYTES-1:0][7:0] 	data_t;
	typedef logic [DATA_BYTES-1:0] 			strb_t;
	typedef logic_axi4_lite_pkg::response_t resp_t;

	`ifdef SYNTHESIS		
		/* Write address channel */
		addr_t 				awaddr;
		logic 				awvalid;
		logic 				awready;
		/* Write data channel */
		data_t 				wdata;
		strb_t 				wstrb;
		logic 				wvalid;
		logic 				wready;
		/* Write response channel */
		resp_t 				bresp;
		logic 				bvalid;
		logic 				bready;
		/* Read address channel */
		addr_t 				araddr;
		logic 				arvalid;
		logic 				arready;
		/* Read data channel */
		data_t 				rdata;
		resp_t 				rresp;
		logic 				rvalid;
		logic 				rready;
	`else
		/* Write address channel */
		addr_t 				awaddr;
		logic 				awvalid;
		logic 				awready;
		/* Write data channel */
		data_t 				wdata;
		strb_t 				wstrb;
		logic 				wvalid;
		logic 				wready;
		/* Write response channel */
		resp_t 				bresp;
		logic 				bvalid;
		logic 				bready;
		/* Read address channel */
		addr_t 				araddr;
		logic 				arvalid;
		logic 				arready;
		/* Read data channel */
		data_t 				rdata;
		resp_t 				rresp;
		logic 				rvalid;
		logic 				rready;
	`endif

	`ifndef LOGIC_MODPORT_DISABLED
		modport master (
				/* Write address channel */
				output 				awaddr,
				output 				awvalid,
				input 				awready,
				/* Write data channel */
				output 				wdata,
				output 				wstrb,
				output 				wvalid,
				input 				wready,
				/* Write response channel */
				input 				bresp,
				input 				bvalid,
				output 				bready,
				/* Read address channel */
				output 				araddr,
				output 				arvalid,
				input 				arready,
				/* Read data channel */
				input 				rdata,
				input 				rresp,
				input 				rvalid,
				output 				rready
			);
		
		modport slave (
				/* Write address channel */
				output 				awaddr,
				output 				awvalid,
				input 				awready,
				/* Write data channel */
				output 				wdata,
				output 				wstrb,
				output 				wvalid,
				input 				wready,
				/* Write response channel */
				input 				bresp,
				input 				bvalid,
				output 				bready,
				/* Read address channel */
				output 				araddr,
				output 				arvalid,
				input 				arready,
				/* Read data channel */
				input 				rdata,
				input 				rresp,
				input 				rvalid,
				output 				rready
			);

		modport monitor (
				/* Write address channel */
				input 				awaddr,
				input 				awvalid,
				input 				awready,
				/* Write data channel */
				input 				wdata,
				input 				wstrb,
				input 				wvalid,
				input 				wready,
				/* Write response channel */
				input 				bresp,
				input 				bvalid,
				input 				bready,
				/* Read address channel */
				input 				araddr,
				input 				arvalid,
				input 				arready,
				/* Read data channel */
				input 				rdata,
				input 				rresp,
				input 				rvalid,
				input 				rready
			);
	`endif

	`ifndef SYNTHESIS
		clocking cb_master @(posedge aclk);
			/* Write address channel */
			input 				awaddr;
			inout 				awvalid;
			inout 				awready;
			/* Write data channel */
			input 				wdata;
			input 				wstrb;
			input 				wvalid;
			inout 				wready;
			/* Write response channel */
			inout 				bresp;
			inout 				bvalid;
			input 				bready;
			/* Read address channel */
			input 				araddr;
			input 				arvalid;
			inout 				arready;
			/* Read data channel */
			inout 				rdata;
			inout 				rresp;
			inout 				rvalid;
			input 				rready;
		endclocking

		modport cb_master_modport (
				input 			areset_n,
				clocking 		cb_master
			);
		
		clocking cb_slave @(posedge aclk);
			/* Write address channel */
			inout 				awaddr;
			inout 				awvalid;
			input 				awready;
			/* Write data channel */
			inout 				wdata;
			inout 				wstrb;
			inout 				wvalid;
			input 				wready;
			/* Write response channel */
			input 				bresp;
			input 				bvalid;
			inout 				bready;
			/* Read address channel */
			inout 				araddr;
			inout 				arvalid;
			input 				arready;
			/* Read data channel */
			input 				rdata;
			input 				rresp;
			input 				rvalid;
			inout 				rready;
		endclocking

		modport cb_slave_modport (
				input 			areset_n,
				clocking 		cb_slave
			);
	`endif
endinterface
