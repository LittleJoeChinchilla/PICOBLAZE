// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
// Date        : Sun Sep 20 13:53:02 2020
// Host        : DESKTOP-2340M74 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/PROJEKT/PICOBLAZE/Picoblaze/Picoblaze.srcs/sources_1/ip/ila_debug/ila_debug_stub.v
// Design      : ila_debug
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2016.1" *)
module ila_debug(clk, probe0, probe1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[0:0],probe1[15:0]" */;
  input clk;
  input [0:0]probe0;
  input [15:0]probe1;
endmodule
