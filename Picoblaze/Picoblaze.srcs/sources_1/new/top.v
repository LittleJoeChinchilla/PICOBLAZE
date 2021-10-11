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
        output      reg     [3:0]   led
    );
    
    wire	[11:0]	address;
    wire    [17:0]  instruction;
    wire            bram_enable;
    wire    [7:0]   port_id;
    wire    [7:0]   out_port;
    reg     [7:0]   in_port;
    wire            write_strobe;
    wire            k_write_strobe;
    wire            read_strobe;
    wire            interrupt;
    wire            interrupt_ack;
    wire            kcpsm6_sleep;
    reg             kcpsm6_reset;
    
    kcpsm6 #(
        .interrupt_vector    (12'h3FF),
        .scratch_pad_memory_size(64),
        .hwbuild        (8'h00)
        )
    processor (
        .address            (address),
        .instruction        (instruction),
        .bram_enable        (bram_enable),
        .port_id            (port_id),
        .write_strobe       (write_strobe),
        .k_write_strobe     (k_write_strobe),
        .out_port           (out_port),
        .read_strobe        (read_strobe),
        .in_port            (in_port),
        .interrupt          (interrupt),
        .interrupt_ack      (interrupt_ack),
        .reset              (kcpsm6_reset),
        .sleep              (kcpsm6_sleep),
        .clk                (sysclk)
        );
      
     program_memory program_rom(
        .enable             (bram_enable),
        .address            (address),
        .instruction        (instruction),
        .clk                (sysclk)
        );




    reg    [15:0]  debug_timer;

    ila_debug debug(
        .clk                (sysclk),
        .probe0             (led[0]),
        .probe1             (debug_timer)
    );
 
        
        always@(posedge sysclk)
            begin
                if (write_strobe == 1)
                begin
                    case (port_id)
                    0:
                        begin
                            led[3:0] = out_port[3:0];
                        end
                    1:
                        begin
                            debug_timer[7:0] = out_port;
                        end
                    2:
                        begin
                            debug_timer[15:8] = out_port;
                        end
                    endcase
                 end
                 case (port_id)
                 0:
                     begin
                        in_port[7:0] = {4'b0000,sw[3:0]};
                     end
                 endcase             
            end
        
        assign kcpsm6_sleep = 1'b0;
        assign interrupt = 1'b0;
    
endmodule
