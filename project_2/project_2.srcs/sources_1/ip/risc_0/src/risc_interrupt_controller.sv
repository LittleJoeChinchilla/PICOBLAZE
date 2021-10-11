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

module risc_interrupt_controller (
    input               aclk,
    input               arstn,
    input				irq,
    input				irq_enable,
    output logic		irq_pending,
    input				irq_acknowledge
);
	
	typedef enum logic [1:0] {
		FSM_IDLE 		= 2'b00,
		FSM_PENDING 	= 2'b01,
		FSM_ACKNOWLEDGE = 2'b10
	} fsm_t;
	
	fsm_t fsm;
	
	logic irq_when_disabled;
	
	always_ff @ (posedge aclk or negedge arstn) begin
		if (!arstn) begin
			irq_pending <= 0;
			irq_when_disabled <= 0;
			fsm 		<= FSM_IDLE;
		end
		else begin
			case (fsm)
				FSM_IDLE: begin
					if ((irq || irq_when_disabled) && irq_enable) begin
						irq_pending <= 1;
						irq_when_disabled <= 0;
						fsm 		<= FSM_PENDING;
					end
					else begin
						irq_pending <= 0;
						if (irq && !irq_enable) irq_when_disabled <= 1;
					end
				end
				FSM_PENDING: begin
					if (irq_acknowledge) begin
						irq_pending <= 0;
						fsm 		<= FSM_ACKNOWLEDGE;
					end
				end
				FSM_ACKNOWLEDGE: begin
					if (!irq_acknowledge && !irq) begin
						fsm <= FSM_IDLE;
					end
				end
			endcase
		end
	end
endmodule
