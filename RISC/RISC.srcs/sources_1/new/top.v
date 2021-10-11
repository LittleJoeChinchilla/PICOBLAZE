`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2020 12:47:56
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
        input                       sysclk,
        input               [3:0]   sw,
        input               [3:0]   btn,
        output      reg     [3:0]   led
    );
    
    wire    reset;
    wire    [7:0]   outport;
    reg     [7:0]   inport;
    
    risc_0 processor (
        .sys_clk(sysclk),
        .sys_reset(reset),
        .native_i(inport),
        .native_o(outport),
        .native_t(),
        .validation_reset()
    );
  
            
            assign reset = btn[0];
            
            always @(posedge sysclk)
            begin
                led[3:0] = outport[3:0];
                inport = {4'b0000, sw};
            end
            
endmodule
