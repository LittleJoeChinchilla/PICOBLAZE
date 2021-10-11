// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
// Date        : Thu Oct 22 19:21:53 2020
// Host        : DESKTOP-2340M74 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/PROJEKT/PICOBLAZE/RISC/RISC.srcs/sources_1/ip/risc_0/risc_0_stub.v
// Design      : risc_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "risc_v0_1,Vivado 2016.1" *)
module risc_0(sys_clk, sys_reset, native_i, native_o, native_t, validation_reset)
/* synthesis syn_black_box black_box_pad_pin="sys_clk,sys_reset,native_i[7:0],native_o[7:0],native_t[7:0],validation_reset" */;
  input sys_clk;
  input sys_reset;
  input [7:0]native_i;
  output [7:0]native_o;
  output [7:0]native_t;
  output validation_reset;
endmodule
