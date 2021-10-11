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

module risc_axi_master_driver #(
	parameter TIMEOUT			        = 16'd1000,
	parameter AXI_SLAVE_0_ENABLE 		= 1,
	parameter AXI_SLAVE_0_BASEADDRESS 	= 32'h0,
	parameter AXI_SLAVE_0_SIZE		  	= 1024,
	//----------------------------------------------------//
	parameter AXI_SLAVE_1_ENABLE 		= 0,
	parameter AXI_SLAVE_1_BASEADDRESS 	= 32'h0,
	parameter AXI_SLAVE_1_SIZE		  	= 1024,	
	//----------------------------------------------------//
	parameter AXI_SLAVE_2_ENABLE 		= 0,
	parameter AXI_SLAVE_2_BASEADDRESS 	= 32'h0,
	parameter AXI_SLAVE_2_SIZE		  	= 1024,
	//----------------------------------------------------//
	parameter AXI_SLAVE_3_ENABLE 		= 0,
	parameter AXI_SLAVE_3_BASEADDRESS 	= 32'h0,
	parameter AXI_SLAVE_3_SIZE		  	= 1024,
	//----------------------------------------------------//
	parameter AXI_SLAVE_4_ENABLE 		= 0,
	parameter AXI_SLAVE_4_BASEADDRESS 	= 32'h0,
	parameter AXI_SLAVE_4_SIZE		  	= 1024,
	//----------------------------------------------------//
	parameter AXI_SLAVE_5_ENABLE 		= 0,
	parameter AXI_SLAVE_5_BASEADDRESS 	= 32'h0,
	parameter AXI_SLAVE_5_SIZE		  	= 1024,	
	//----------------------------------------------------//
	parameter AXI_SLAVE_6_ENABLE 		= 0,
	parameter AXI_SLAVE_6_BASEADDRESS 	= 32'h0,
	parameter AXI_SLAVE_6_SIZE		  	= 1024	
)(
    input               						clk,
    input               						rstn,
    `LOGIC_MODPORT(logic_axi4_lite_if, master) 	m_axi,
    input 			[ 2:0]						slave_select,
    input 			[15:0]						offset,
    input										rw,				// read = 1, write = 0
    input										req,
    output logic								ack,
    input 			[ 7:0]						data_in,
    output logic 	[ 7:0]						data_out,
    output logic								error,
    output logic    [15:0]                      probe_timeout,
    output logic    [3:0]                       probe_fsm
);
	
	typedef enum logic [3:0] {
		FSM_IDLE,
		FSM_READ,
		FSM_READ_ADDRESS_ACK,
		FSM_READ_RESPONSE,
		FSM_WRITE,
		FSM_WRITE_ADDRESS_ACK,
		FSM_WRITE_DATA_ACK,
		FSM_WRITE_RESPONSE,
		FSM_RETURN
	} fsm_t;
	
	fsm_t fsm;
	
	logic [15:0] timeout_cnt;
	
	assign probe_timeout = timeout_cnt;
	assign probe_fsm = fsm;
	
	logic read_request_by_write;
	logic [31:0] read_request_by_write_data;
	
	always_ff @ (posedge clk or negedge rstn) begin
		if (!rstn) begin
		    read_request_by_write <= 0;
			read_request_by_write_data <= 0;
			fsm 			<= FSM_IDLE;
			data_out 		<= '0;
			error 			<= 0;
			ack 			<= 0;
			timeout_cnt		<= TIMEOUT;
			// Reset AW channel
			m_axi.awaddr 	<= '0;
			m_axi.awvalid 	<= 0;
			// Reset W channel
			m_axi.wdata		<= '0;
			m_axi.wstrb		<= '0;
			m_axi.wvalid	<= 0;
			// Reset B channel
			m_axi.bready	<= 0;
			// Reset AR channel
			m_axi.araddr	<= '0;
			m_axi.arvalid	<= 0;
			// Reset R channel
			m_axi.rready	<= 0;
		end
		else begin
			case (fsm)
				FSM_IDLE: begin
					if (req) begin
						ack 		<= 0;
						error 		<= 0;
						data_out 	<= '0;
						timeout_cnt <= TIMEOUT;
						if (rw) fsm <= FSM_READ;
						else fsm <= FSM_WRITE;
					end
				end
				FSM_READ: begin
					case (slave_select)
						0: begin
							if (AXI_SLAVE_0_ENABLE && offset < AXI_SLAVE_0_SIZE) begin
								m_axi.araddr 	<= { AXI_SLAVE_0_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.arvalid 	<= 1;
								m_axi.rready	<= 1;
								fsm				<= FSM_READ_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end
						end
						1: begin
							if (AXI_SLAVE_1_ENABLE && offset < AXI_SLAVE_1_SIZE) begin
								m_axi.araddr 	<= { AXI_SLAVE_1_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.arvalid 	<= 1;
								m_axi.rready	<= 1;
								fsm				<= FSM_READ_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end							
						end
						2: begin
							if (AXI_SLAVE_2_ENABLE && offset < AXI_SLAVE_2_SIZE) begin
								m_axi.araddr 	<= { AXI_SLAVE_2_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.arvalid 	<= 1;
								m_axi.rready	<= 1;
								fsm				<= FSM_READ_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end							
						end
						3: begin
							if (AXI_SLAVE_3_ENABLE && offset < AXI_SLAVE_3_SIZE) begin
								m_axi.araddr 	<= { AXI_SLAVE_3_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.arvalid 	<= 1;
								m_axi.rready	<= 1;
								fsm				<= FSM_READ_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end							
						end
						4: begin
							if (AXI_SLAVE_4_ENABLE && offset < AXI_SLAVE_4_SIZE) begin
								m_axi.araddr 	<= { AXI_SLAVE_4_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.arvalid 	<= 1;
								m_axi.rready	<= 1;
								fsm				<= FSM_READ_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end							
						end
						5: begin
							if (AXI_SLAVE_5_ENABLE && offset < AXI_SLAVE_5_SIZE) begin
								m_axi.araddr 	<= { AXI_SLAVE_5_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.arvalid 	<= 1;
								m_axi.rready	<= 1;
								fsm				<= FSM_READ_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end							
						end
						6: begin
							if (AXI_SLAVE_6_ENABLE && offset < AXI_SLAVE_6_SIZE) begin
								m_axi.araddr 	<= { AXI_SLAVE_6_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.arvalid 	<= 1;
								m_axi.rready	<= 1;
								fsm				<= FSM_READ_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end							
						end
						default: begin
							ack		<= 1;
							error 	<= 1;
							fsm		<= FSM_RETURN;
						end
					endcase
				end
				FSM_READ_ADDRESS_ACK: begin
					if (m_axi.arready && m_axi.rvalid) begin
						if (m_axi.rresp) begin
							data_out		<= '0;
							error 			<= 1;
						end
						else begin
							case (offset[1:0])
								0:	data_out <= m_axi.rdata[0][7:0];
								1:	data_out <= m_axi.rdata[1][7:0];
								2:	data_out <= m_axi.rdata[2][7:0];
								3:	data_out <= m_axi.rdata[3][7:0];
							endcase							
							error 			<= 0;
						end
						m_axi.araddr 	<= '0;
						m_axi.arvalid 	<= 0;
						m_axi.rready	<= 0;
						ack 			<= 1;
						fsm 			<= FSM_RETURN;
					end
					else if (m_axi.arready) begin
						m_axi.araddr 	<= '0;
						m_axi.arvalid 	<= 0;
						fsm <= FSM_READ_RESPONSE;
					end
					else begin
						if (timeout_cnt == 0) begin
							data_out <= 0;
							ack		 <= 1;
							error	 <= 1;
							fsm		 <= FSM_RETURN;
							timeout_cnt	<= TIMEOUT;
						end
						else begin
							timeout_cnt <= timeout_cnt - 1;
						end
					end
				end
				FSM_READ_RESPONSE: begin
					if (m_axi.rvalid) begin
						if (m_axi.rresp) begin
							data_out		<= '0;
							error 			<= 1;
						end
						else begin
							case (offset[1:0])
								0:	data_out <= m_axi.rdata[0][7:0];
								1:	data_out <= m_axi.rdata[1][7:0];
								2:	data_out <= m_axi.rdata[2][7:0];
								3:	data_out <= m_axi.rdata[3][7:0];
							endcase							
							error 			<= 0;
						end
						m_axi.rready	<= 0;
						if (read_request_by_write) begin
						    read_request_by_write_data <= m_axi.rdata;
						    read_request_by_write <= 0;
						    fsm <= FSM_WRITE;
						end
						else begin
						  ack 			<= 1;
						  fsm 			<= FSM_RETURN;
						end
					end
					else begin
						if (timeout_cnt == 0) begin
							data_out <= 0;
							ack		 <= 1;
							error	 <= 1;
							fsm		 <= FSM_RETURN;
							timeout_cnt	<= TIMEOUT;
						end
						else begin
							timeout_cnt <= timeout_cnt - 1;
						end
					end
				end
				FSM_WRITE: begin
					case (slave_select)
						0: begin
							if (AXI_SLAVE_0_ENABLE && offset < AXI_SLAVE_0_SIZE) begin
								m_axi.awaddr 	<= { AXI_SLAVE_0_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.awvalid 	<= 1;
								m_axi.wvalid	<= 1;
								m_axi.bready	<= 1;
								case (offset[1:0])
									0: begin
										m_axi.wdata[3] <= read_request_by_write_data[31:24];
										m_axi.wdata[2] <= read_request_by_write_data[23:16];
										m_axi.wdata[1] <= read_request_by_write_data[15: 8];
										m_axi.wdata[0] <= data_in;
										m_axi.wstrb	<= 4'b0001;
									end
									1: begin
										m_axi.wdata[3] <= read_request_by_write_data[31:24];
										m_axi.wdata[2] <= read_request_by_write_data[23:16];
										m_axi.wdata[1] <= data_in;
										m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
										m_axi.wstrb	<= 4'b0010;
									end
									2: begin
										m_axi.wdata[3] <= read_request_by_write_data[31:24];
										m_axi.wdata[2] <= data_in;
										m_axi.wdata[1] <= read_request_by_write_data[15: 8];
										m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
										m_axi.wstrb	<= 4'b0100;
									end
									3: begin
										m_axi.wdata[3] <= data_in;
										m_axi.wdata[2] <= read_request_by_write_data[23:16];
										m_axi.wdata[1] <= read_request_by_write_data[15: 8];
										m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
										m_axi.wstrb	<= 4'b1000;
									end
								endcase
								fsm				<= FSM_WRITE_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end
						end
						1: begin
							if (AXI_SLAVE_1_ENABLE && offset < AXI_SLAVE_1_SIZE) begin
								m_axi.awaddr 	<= { AXI_SLAVE_1_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.awvalid 	<= 1;
								m_axi.wvalid	<= 1;
								m_axi.bready	<= 1;
								case (offset[1:0])
                                    0: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= data_in;
                                        m_axi.wstrb    <= 4'b0001;
                                    end
                                    1: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= data_in;
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0010;
                                    end
                                    2: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= data_in;
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0100;
                                    end
                                    3: begin
                                        m_axi.wdata[3] <= data_in;
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b1000;
                                    end
                                endcase
								fsm				<= FSM_WRITE_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end						
						end
						2: begin
							if (AXI_SLAVE_2_ENABLE && offset < AXI_SLAVE_2_SIZE) begin
								m_axi.awaddr 	<= { AXI_SLAVE_2_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.awvalid 	<= 1;
								m_axi.wvalid	<= 1;
								m_axi.bready	<= 1;
								case (offset[1:0])
                                    0: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= data_in;
                                        m_axi.wstrb    <= 4'b0001;
                                    end
                                    1: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= data_in;
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0010;
                                    end
                                    2: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= data_in;
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0100;
                                    end
                                    3: begin
                                        m_axi.wdata[3] <= data_in;
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b1000;
                                    end
                                endcase
								fsm				<= FSM_WRITE_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end						
						end
						3: begin
							if (AXI_SLAVE_3_ENABLE && offset < AXI_SLAVE_3_SIZE) begin
								m_axi.awaddr 	<= { AXI_SLAVE_3_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.awvalid 	<= 1;
								m_axi.wvalid	<= 1;
								m_axi.bready	<= 1;
								case (offset[1:0])
                                    0: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= data_in;
                                        m_axi.wstrb    <= 4'b0001;
                                    end
                                    1: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= data_in;
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0010;
                                    end
                                    2: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= data_in;
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0100;
                                    end
                                    3: begin
                                        m_axi.wdata[3] <= data_in;
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b1000;
                                    end
                                endcase
								fsm				<= FSM_WRITE_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end							
						end
						4: begin
							if (AXI_SLAVE_4_ENABLE && offset < AXI_SLAVE_4_SIZE) begin
								m_axi.awaddr 	<= { AXI_SLAVE_4_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.awvalid 	<= 1;
								m_axi.wvalid	<= 1;
								m_axi.bready	<= 1;
								case (offset[1:0])
                                    0: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= data_in;
                                        m_axi.wstrb    <= 4'b0001;
                                    end
                                    1: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= data_in;
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0010;
                                    end
                                    2: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= data_in;
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0100;
                                    end
                                    3: begin
                                        m_axi.wdata[3] <= data_in;
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b1000;
                                    end
                                endcase
								fsm				<= FSM_WRITE_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end							
						end
						5: begin
							if (AXI_SLAVE_5_ENABLE && offset < AXI_SLAVE_5_SIZE) begin
								m_axi.awaddr 	<= { AXI_SLAVE_5_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.awvalid 	<= 1;
								m_axi.wvalid	<= 1;
								m_axi.bready	<= 1;
								case (offset[1:0])
                                    0: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= data_in;
                                        m_axi.wstrb    <= 4'b0001;
                                    end
                                    1: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= data_in;
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0010;
                                    end
                                    2: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= data_in;
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0100;
                                    end
                                    3: begin
                                        m_axi.wdata[3] <= data_in;
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b1000;
                                    end
                                endcase
								fsm				<= FSM_WRITE_ADDRESS_ACK;
							end
							else begin
								ack				<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end							
						end
						6: begin
							if (AXI_SLAVE_6_ENABLE && offset < AXI_SLAVE_6_SIZE) begin
								m_axi.awaddr 	<= { AXI_SLAVE_6_BASEADDRESS[31:16], offset[15:2], 2'b00 };
								m_axi.awvalid 	<= 1;
								m_axi.wvalid	<= 1;
								m_axi.bready	<= 1;
								case (offset[1:0])
                                    0: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= data_in;
                                        m_axi.wstrb    <= 4'b0001;
                                    end
                                    1: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= data_in;
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0010;
                                    end
                                    2: begin
                                        m_axi.wdata[3] <= read_request_by_write_data[31:24];
                                        m_axi.wdata[2] <= data_in;
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b0100;
                                    end
                                    3: begin
                                        m_axi.wdata[3] <= data_in;
                                        m_axi.wdata[2] <= read_request_by_write_data[23:16];
                                        m_axi.wdata[1] <= read_request_by_write_data[15: 8];
                                        m_axi.wdata[0] <= read_request_by_write_data[ 7: 0];
                                        m_axi.wstrb    <= 4'b1000;
                                    end
                                endcase
								fsm				<= FSM_WRITE_ADDRESS_ACK;
							end
							else begin
								ack 			<= 1;
								error 			<= 1;
								fsm				<= FSM_RETURN;
							end						
						end
						default: begin
							ack 	<= 1;
							error 	<= 1;
							fsm		<= FSM_RETURN;
						end
					endcase					
				end
				FSM_WRITE_ADDRESS_ACK: begin
					if (m_axi.awready && m_axi.wready && m_axi.bvalid) begin
						m_axi.awaddr 	<= '0;
						m_axi.awvalid	<= 0;
						m_axi.wvalid	<= 0;
						m_axi.wdata		<= '0;
						m_axi.wstrb		<= '0;
						m_axi.bready	<= 0;
						if (m_axi.bresp) begin
							error <= 1;
						end
						else begin
							error <= 0;
						end
						ack   	<= 1;
						fsm 	<= FSM_RETURN;
					end
					else if (m_axi.awready && m_axi.wready) begin
						m_axi.awaddr 	<= '0;
						m_axi.awvalid	<= 0;
						m_axi.wvalid	<= 0;
						m_axi.wdata		<= '0;
						m_axi.wstrb		<= '0;
						fsm 			<= FSM_WRITE_RESPONSE;
					end
					else if (m_axi.awready) begin
						m_axi.awaddr 	<= '0;
						m_axi.awvalid	<= 0;		
						fsm				<= FSM_WRITE_DATA_ACK;
					end
					else begin
						if (timeout_cnt == 0) begin
							data_out <= 0;
							ack		 <= 1;
							error	 <= 1;
							fsm		 <= FSM_RETURN;
							timeout_cnt	<= TIMEOUT;
						end
						else begin
							timeout_cnt <= timeout_cnt - 1;
						end
					end
				end
				FSM_WRITE_DATA_ACK: begin
					if (m_axi.wready && m_axi.bvalid) begin
						m_axi.wvalid	<= 0;
						m_axi.wdata		<= '0;
						m_axi.wstrb		<= '0;
						m_axi.bready	<= 0;
						if (m_axi.bresp) begin
							error <= 1;
						end
						else begin
							error <= 0;
						end
						ack   	<= 1;
						fsm 	<= FSM_RETURN;
					end
					else if (m_axi.wready) begin
						m_axi.wvalid	<= 0;
						m_axi.wdata		<= '0;
						m_axi.wstrb		<= '0;
						fsm 			<= FSM_WRITE_RESPONSE;
					end			
					else begin
						if (timeout_cnt == 0) begin
							data_out <= 0;
							ack		 <= 1;
							error	 <= 1;
							fsm		 <= FSM_RETURN;
							timeout_cnt	<= TIMEOUT;
						end
						else begin
							timeout_cnt <= timeout_cnt - 1;
						end
					end
				end
				FSM_WRITE_RESPONSE: begin
					if (m_axi.bvalid) begin
						m_axi.bready	<= 0;
						if (m_axi.bresp) begin
							error <= 1;
						end
						else begin
							error <= 0;
						end
						ack   	<= 1;
						fsm 	<= FSM_RETURN;
					end
					else begin
						if (timeout_cnt == 0) begin
							data_out <= 0;
							ack		 <= 1;
							error	 <= 1;
							fsm		 <= FSM_RETURN;
							timeout_cnt	<= TIMEOUT;
						end
						else begin
							timeout_cnt <= timeout_cnt - 1;
						end
					end				end
				FSM_RETURN: begin
					if (!req) begin
						ack 		<= 0;
						error		<= 0;
						data_out 	<= '0;
						fsm			<= FSM_IDLE;
						timeout_cnt	<= TIMEOUT;
						read_request_by_write <= 0;
						read_request_by_write_data <= 0;
					end
				end
			endcase
		end
	end
endmodule
