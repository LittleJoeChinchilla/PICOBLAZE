// (c) Copyright 1995-2020 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: user.org:user:risc:0.1
// IP Revision: 74

(* X_CORE_INFO = "risc_v0_1,Vivado 2016.1" *)
(* CHECK_LICENSE_TYPE = "risc_0,risc_v0_1,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module risc_0 (
  sys_clk,
  sys_reset,
  native_i,
  native_o,
  native_t,
  validation_reset
);

input wire sys_clk;
input wire sys_reset;
(* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 native TRI_I" *)
input wire [7 : 0] native_i;
(* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 native TRI_O" *)
output wire [7 : 0] native_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 native TRI_T" *)
output wire [7 : 0] native_t;
output wire validation_reset;

  risc_v0_1 #(
    .C_RISC_DATA_WIDTH(8),
    .C_RISC_PROGRAM_MEMORY_SIZE("8K"),
    .C_RISC_DATA_MEMORY_SIZE("8K"),
    .C_RISC_VALIDATION_EN("true"),
    .C_RISC_JTAG_EN("true"),
    .C_RISC_ZYNQ_EN("false"),
    .C_RISC_NATIVE_I_REG(10),
    .C_RISC_NATIVE_O_REG(11),
    .C_RISC_NATIVE_T_REG(12),
    .C_RISC_INTERRUPT_EN("false"),
    .C_RISC_OUTPUT_CLKRST_EN("false"),
    .C_RISC_IF("NATIVE"),
    .C_RISC_SIMPLE_I_REG(10),
    .C_RISC_SIMPLE_O_REG(10),
    .C_RISC_AXI4_SLAVE0_EN("false"),
    .C_RISC_AXI4_SLAVE0_BASE(32'H00000000),
    .C_RISC_AXI4_SLAVE0_SIZE("1K"),
    .C_RISC_AXI4_SLAVE1_EN("false"),
    .C_RISC_AXI4_SLAVE1_BASE(32'H00000000),
    .C_RISC_AXI4_SLAVE1_SIZE("1K"),
    .C_RISC_AXI4_SLAVE2_EN("false"),
    .C_RISC_AXI4_SLAVE2_BASE(32'H00000000),
    .C_RISC_AXI4_SLAVE2_SIZE("1K"),
    .C_RISC_AXI4_SLAVE3_EN("false"),
    .C_RISC_AXI4_SLAVE3_BASE(32'H00000000),
    .C_RISC_AXI4_SLAVE3_SIZE("1K"),
    .C_RISC_AXI4_SLAVE4_EN("false"),
    .C_RISC_AXI4_SLAVE4_BASE(32'H00000000),
    .C_RISC_AXI4_SLAVE4_SIZE("1K"),
    .C_RISC_AXI4_SLAVE5_EN("false"),
    .C_RISC_AXI4_SLAVE5_BASE(32'H00000000),
    .C_RISC_AXI4_SLAVE5_SIZE("1K"),
    .C_M_AXI_LITE_ADDR_WIDTH(32),
    .C_M_AXI_LITE_DATA_WIDTH(32),
    .C_RISC_RESET_VECTOR(32'H00000000),
    .C_RISC_EXCEPTION_VECTOR(32'H000000C8),
    .C_RISC_INTERRUPT_VECTOR(32'H00000064),
    .C_RISC_AXI4_MASTER_EN("false"),
    .C_RISC_AXI4_MASTER_BASE(32'H00000000),
    .C_RISC_AXI4_MASTER_SIZE("1K"),
    .C_RISC_MEM_WIDTH0_SELECTOR("MEMORY"),
    .C_RISC_MEM_WIDTH1_SELECTOR("MEMORY"),
    .C_RISC_MEM_WIDTH2_SELECTOR("MEMORY"),
    .C_RISC_MEM_WIDTH3_SELECTOR("MEMORY"),
    .C_RISC_MEM_WIDTH4_SELECTOR("MEMORY"),
    .C_RISC_MEM_WIDTH5_SELECTOR("MEMORY"),
    .C_RISC_MEM_WIDTH6_SELECTOR("MEMORY"),
    .C_RISC_MEM_WIDTH7_SELECTOR("MEMORY")
  ) inst (
    .zynq_pl_clk(1'B0),
    .zynq_pl_resetn(1'B1),
    .sys_clk(sys_clk),
    .sys_reset(sys_reset),
    .irq(1'B0),
    .sw(1'B0),
    .led(),
    .native_i(native_i),
    .native_o(native_o),
    .native_t(native_t),
    .risc_clk(),
    .risc_resetn(),
    .validation_reset(validation_reset),
    .m_axi_lite_awaddr(),
    .m_axi_lite_awprot(),
    .m_axi_lite_awvalid(),
    .m_axi_lite_awready(1'B0),
    .m_axi_lite_wdata(),
    .m_axi_lite_wstrb(),
    .m_axi_lite_wvalid(),
    .m_axi_lite_wready(1'B0),
    .m_axi_lite_bresp(2'B0),
    .m_axi_lite_bvalid(1'B0),
    .m_axi_lite_bready(),
    .m_axi_lite_araddr(),
    .m_axi_lite_arprot(),
    .m_axi_lite_arvalid(),
    .m_axi_lite_arready(1'B0),
    .m_axi_lite_rdata(32'B0),
    .m_axi_lite_rresp(2'B0),
    .m_axi_lite_rvalid(1'B0),
    .m_axi_lite_rready(),
    .s_axi_lite_awaddr(32'B0),
    .s_axi_lite_awprot(3'B0),
    .s_axi_lite_awvalid(1'B0),
    .s_axi_lite_awready(),
    .s_axi_lite_wdata(32'B0),
    .s_axi_lite_wstrb(4'B0),
    .s_axi_lite_wvalid(1'B0),
    .s_axi_lite_wready(),
    .s_axi_lite_bresp(),
    .s_axi_lite_bvalid(),
    .s_axi_lite_bready(1'B0),
    .s_axi_lite_araddr(32'B0),
    .s_axi_lite_arprot(3'B0),
    .s_axi_lite_arvalid(1'B0),
    .s_axi_lite_arready(),
    .s_axi_lite_rdata(),
    .s_axi_lite_rresp(),
    .s_axi_lite_rvalid(),
    .s_axi_lite_rready(1'B0)
  );
endmodule
