`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2020 10:47:27 PM
// Design Name: 
// Module Name: risc_core_verilog_wrapper
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

`include "logic.svh"
module risc_core_verilog_wrapper #(
    //------- ARCHITECTURE GENERICS -------------------//
    parameter C_RISC_DATA_WIDTH          = 8,
    parameter C_RISC_INTERRUPT_EN        = "false",
    parameter C_RISC_JTAG_EN             = "true",
    parameter C_RISC_VALIDATION_EN       = "true",
    parameter C_RISC_ZYNQ_EN             = "false",
    parameter C_RISC_OUTPUT_CLKRST_EN    = "false",
	parameter C_RISC_RESET_VECTOR		 = 32'd0,
    parameter C_RISC_EXCEPTION_VECTOR    = 32'd100,
    parameter C_RISC_INTERRUPT_VECTOR    = 32'd200,    
    //------- MEMORY GENERICS -------------------------//
    parameter C_RISC_PROGRAM_MEMORY_SIZE = "8K",
    parameter C_RISC_DATA_MEMORY_SIZE    = "8K",
    //------- INTERFACE GENERICS ----------------------//       
    parameter C_RISC_IF                  = "SIMPLE",
    parameter C_RISC_SIMPLE_I_REG        = 10,
    parameter C_RISC_SIMPLE_O_REG        = 10,
    parameter C_RISC_NATIVE_I_REG        = 10,
    parameter C_RISC_NATIVE_O_REG        = 10,
    parameter C_RISC_NATIVE_T_REG        = 10,
    parameter C_M_AXI_LITE_ADDR_WIDTH    = 32,
    parameter C_M_AXI_LITE_DATA_WIDTH    = 32,
    parameter C_RISC_AXI4_SLAVE0_EN      = "false",
    parameter C_RISC_AXI4_SLAVE0_BASE    = 32'h0,
    parameter C_RISC_AXI4_SLAVE0_SIZE    = "1K",
    parameter C_RISC_AXI4_SLAVE1_EN      = "false",
    parameter C_RISC_AXI4_SLAVE1_BASE    = 32'h0,
    parameter C_RISC_AXI4_SLAVE1_SIZE    = "1K",
    parameter C_RISC_AXI4_SLAVE2_EN      = "false",
    parameter C_RISC_AXI4_SLAVE2_BASE    = 32'h0,
    parameter C_RISC_AXI4_SLAVE2_SIZE    = "1K",
    parameter C_RISC_AXI4_SLAVE3_EN      = "false",
    parameter C_RISC_AXI4_SLAVE3_BASE    = 32'h0,
    parameter C_RISC_AXI4_SLAVE3_SIZE    = "1K",    
    parameter C_RISC_AXI4_SLAVE4_EN      = "false",
    parameter C_RISC_AXI4_SLAVE4_BASE    = 32'h0,
    parameter C_RISC_AXI4_SLAVE4_SIZE    = "1K",      
    parameter C_RISC_AXI4_SLAVE5_EN      = "false",
    parameter C_RISC_AXI4_SLAVE5_BASE    = 32'h0,
    parameter C_RISC_AXI4_SLAVE5_SIZE    = "1K",
	parameter C_RISC_AXI4_MASTER_EN      = "false",
    parameter C_RISC_AXI4_MASTER_BASE    = 32'h0,
    parameter C_RISC_AXI4_MASTER_SIZE    = "1K",
    parameter C_RISC_MEM_WIDTH0_SELECTOR = "MEMORY",
    parameter C_RISC_MEM_WIDTH1_SELECTOR = "MEMORY",
    parameter C_RISC_MEM_WIDTH2_SELECTOR = "MEMORY",
    parameter C_RISC_MEM_WIDTH3_SELECTOR = "MEMORY",
    parameter C_RISC_MEM_WIDTH4_SELECTOR = "MEMORY",
    parameter C_RISC_MEM_WIDTH5_SELECTOR = "MEMORY",
    parameter C_RISC_MEM_WIDTH6_SELECTOR = "MEMORY",
    parameter C_RISC_MEM_WIDTH7_SELECTOR = "MEMORY"    
)(
    //------ Internal CLK ---------//
    input              zynq_pl_clk,
    input              zynq_pl_resetn,
    //------ External CLK ---------//
    input              sys_clk,
    input              sys_reset,
    //------ IRQ ------------------//
    input              irq,
    //------ SIMPLE IF ------------//
    input              sw,
    output             led,
    //------ NATIVE IF ------------//
    input  [7:0]       native_i,
    output [7:0]       native_o,
    output [7:0]       native_t,
    //------ AXI4 IF --------------//
    //--- master ---//
    output logic [31:0] m_axi_lite_awaddr,
    output logic [ 2:0] m_axi_lite_awprot,
    output logic        m_axi_lite_awvalid,
    input  wire        m_axi_lite_awready,
    output logic [31:0] m_axi_lite_wdata,
    output logic [ 3:0] m_axi_lite_wstrb,
    output logic        m_axi_lite_wvalid,
    input  wire        m_axi_lite_wready,
    input  wire [ 1:0] m_axi_lite_bresp,
    input  wire        m_axi_lite_bvalid,
    output logic        m_axi_lite_bready,
    output logic [31:0] m_axi_lite_araddr,
    output logic [ 2:0] m_axi_lite_arprot,
    output logic        m_axi_lite_arvalid,
    input  wire        m_axi_lite_arready,
    input  wire [31:0] m_axi_lite_rdata,
    input  wire [ 1:0] m_axi_lite_rresp,
    input  wire        m_axi_lite_rvalid,
    output logic        m_axi_lite_rready,  
    // --- slave ---
    input  wire [31:0] s_axi_lite_awaddr,
    input  wire [ 2:0] s_axi_lite_awprot,
    input  wire        s_axi_lite_awvalid,
    output wire        s_axi_lite_awready,
    input  wire [31:0] s_axi_lite_wdata,
    input  wire [ 3:0] s_axi_lite_wstrb,
    input  wire        s_axi_lite_wvalid,
    output wire        s_axi_lite_wready,
    output wire [ 1:0] s_axi_lite_bresp,
    output wire        s_axi_lite_bvalid,
    input  wire        s_axi_lite_bready,
    input  wire [31:0] s_axi_lite_araddr,
    input  wire [ 2:0] s_axi_lite_arprot,
    input  wire        s_axi_lite_arvalid,
    output wire        s_axi_lite_arready,
    output wire [31:0] s_axi_lite_rdata,
    output wire [ 1:0] s_axi_lite_rresp,
    output wire        s_axi_lite_rvalid,
    input  wire        s_axi_lite_rready,  
    // ---------------------------------------------         
    output             risc_clk,
    output             risc_resetn,
    output             validation_reset       
);
    
    logic aclk;
    logic areset_n;
    assign aclk = risc_clk;
    assign areset_n = risc_resetn;
    logic_axi4_lite_if #(
        .DATA_BYTES     (4),
        .ADDRESS_WIDTH  (32)
    ) m_axi_lite (
        .aclk       (risc_clk),
        .areset_n   (risc_resetn)
    );
    
    always_comb begin
        m_axi_lite_awaddr   = m_axi_lite.awaddr;
        m_axi_lite_awprot   = 0;
        m_axi_lite_awvalid  = m_axi_lite.awvalid;
        m_axi_lite.awready  = m_axi_lite_awready;
        
        m_axi_lite_wdata    = m_axi_lite.wdata;
        m_axi_lite_wstrb    = m_axi_lite.wstrb;
        m_axi_lite_wvalid   = m_axi_lite.wvalid;
        m_axi_lite.wready   = m_axi_lite_wready;

        m_axi_lite.bresp    = m_axi_lite_bresp;
        m_axi_lite.bvalid   = m_axi_lite_bvalid;
        m_axi_lite_bready   = m_axi_lite.bready;

        m_axi_lite_araddr   = m_axi_lite.araddr;
        m_axi_lite_arprot   = 0;
        m_axi_lite_arvalid  = m_axi_lite.arvalid;
        m_axi_lite.arready  = m_axi_lite_arready;
        
        m_axi_lite.rdata    = m_axi_lite_rdata;
        m_axi_lite.rresp    = m_axi_lite_rresp;
        m_axi_lite.rvalid   = m_axi_lite_rvalid;
        m_axi_lite_rready   = m_axi_lite.rready;          
    end
    
    logic_axi4_lite_if #(
        .DATA_BYTES     (4),
        .ADDRESS_WIDTH  (32)
    ) s_axi_lite (.*);    
    
    risc #(
        //------- ARCHITECTURE GENERICS -------------------//
        .C_RISC_DATA_WIDTH          (C_RISC_DATA_WIDTH),
        .C_RISC_INTERRUPT_EN        (C_RISC_INTERRUPT_EN),
        .C_RISC_JTAG_EN             (C_RISC_JTAG_EN),
        .C_RISC_VALIDATION_EN       (C_RISC_VALIDATION_EN),
        .C_RISC_ZYNQ_EN             (C_RISC_ZYNQ_EN),
        .C_RISC_OUTPUT_CLKRST_EN    (C_RISC_OUTPUT_CLKRST_EN),
	    .C_RISC_RESET_VECTOR		(C_RISC_RESET_VECTOR),
        .C_RISC_EXCEPTION_VECTOR    (C_RISC_EXCEPTION_VECTOR),
        .C_RISC_INTERRUPT_VECTOR    (C_RISC_INTERRUPT_VECTOR),           
        //------- MEMORY GENERICS -------------------------//
        .C_RISC_PROGRAM_MEMORY_SIZE (C_RISC_PROGRAM_MEMORY_SIZE),
        .C_RISC_DATA_MEMORY_SIZE    (C_RISC_DATA_MEMORY_SIZE),
        //------- INTERFACE GENERICS ----------------------//       
        .C_RISC_IF                  (C_RISC_IF),
        .C_RISC_SIMPLE_I_REG        (C_RISC_SIMPLE_I_REG),
        .C_RISC_SIMPLE_O_REG        (C_RISC_SIMPLE_O_REG),
        .C_RISC_NATIVE_I_REG        (C_RISC_NATIVE_I_REG),
        .C_RISC_NATIVE_O_REG        (C_RISC_NATIVE_O_REG),
        .C_RISC_NATIVE_T_REG        (C_RISC_NATIVE_T_REG),
        .C_M_AXI_LITE_ADDR_WIDTH    (C_M_AXI_LITE_ADDR_WIDTH),
        .C_M_AXI_LITE_DATA_WIDTH    (C_M_AXI_LITE_DATA_WIDTH),
        .C_RISC_AXI4_SLAVE0_EN      (C_RISC_AXI4_SLAVE0_EN),
        .C_RISC_AXI4_SLAVE0_BASE    (C_RISC_AXI4_SLAVE0_BASE),
        .C_RISC_AXI4_SLAVE0_SIZE    (C_RISC_AXI4_SLAVE0_SIZE),
        .C_RISC_AXI4_SLAVE1_EN      (C_RISC_AXI4_SLAVE1_EN),
        .C_RISC_AXI4_SLAVE1_BASE    (C_RISC_AXI4_SLAVE1_BASE),
        .C_RISC_AXI4_SLAVE1_SIZE    (C_RISC_AXI4_SLAVE1_SIZE),
        .C_RISC_AXI4_SLAVE2_EN      (C_RISC_AXI4_SLAVE2_EN),
        .C_RISC_AXI4_SLAVE2_BASE    (C_RISC_AXI4_SLAVE2_BASE),
        .C_RISC_AXI4_SLAVE2_SIZE    (C_RISC_AXI4_SLAVE2_SIZE),
        .C_RISC_AXI4_SLAVE3_EN      (C_RISC_AXI4_SLAVE3_EN),
        .C_RISC_AXI4_SLAVE3_BASE    (C_RISC_AXI4_SLAVE3_BASE),
        .C_RISC_AXI4_SLAVE3_SIZE    (C_RISC_AXI4_SLAVE3_SIZE),    
        .C_RISC_AXI4_SLAVE4_EN      (C_RISC_AXI4_SLAVE4_EN),
        .C_RISC_AXI4_SLAVE4_BASE    (C_RISC_AXI4_SLAVE4_BASE),
        .C_RISC_AXI4_SLAVE4_SIZE    (C_RISC_AXI4_SLAVE4_SIZE),      
        .C_RISC_AXI4_SLAVE5_EN      (C_RISC_AXI4_SLAVE5_EN),
        .C_RISC_AXI4_SLAVE5_BASE    (C_RISC_AXI4_SLAVE5_BASE),
        .C_RISC_AXI4_SLAVE5_SIZE    (C_RISC_AXI4_SLAVE5_SIZE),
	    .C_RISC_AXI4_MASTER_EN      (C_RISC_AXI4_MASTER_EN),
        .C_RISC_AXI4_MASTER_BASE    (C_RISC_AXI4_MASTER_BASE),
        .C_RISC_AXI4_MASTER_SIZE    (C_RISC_AXI4_MASTER_SIZE),
        .C_RISC_MEM_WIDTH0_SELECTOR (C_RISC_MEM_WIDTH0_SELECTOR),
        .C_RISC_MEM_WIDTH1_SELECTOR (C_RISC_MEM_WIDTH1_SELECTOR),
        .C_RISC_MEM_WIDTH2_SELECTOR (C_RISC_MEM_WIDTH2_SELECTOR),
        .C_RISC_MEM_WIDTH3_SELECTOR (C_RISC_MEM_WIDTH3_SELECTOR),
        .C_RISC_MEM_WIDTH4_SELECTOR (C_RISC_MEM_WIDTH4_SELECTOR),
        .C_RISC_MEM_WIDTH5_SELECTOR (C_RISC_MEM_WIDTH5_SELECTOR),
        .C_RISC_MEM_WIDTH6_SELECTOR (C_RISC_MEM_WIDTH6_SELECTOR),
        .C_RISC_MEM_WIDTH7_SELECTOR (C_RISC_MEM_WIDTH7_SELECTOR)         
        //------- DSP GENERICS ----------------------------//
    ) risc_inst (
        //------ Internal CLK ---------//
        .zynq_pl_clk                (zynq_pl_clk),
        .zynq_pl_resetn             (zynq_pl_resetn),
        //------ External CLK ---------//
        .sys_clk                    (sys_clk),
        .sys_reset                  (sys_reset),
        //------ IRQ ------------------//
        .irq                        (irq),
        //------ SIMPLE IF ------------//
        .sw                         (sw),
        .led                        (led),
        //------ NATIVE IF ------------//
        .native_i                   (native_i),
        .native_o                   (native_o),
        .native_t                   (native_t),
        //------ AXI4 IF --------------//
        .m_axi                      (m_axi_lite),
        .s_axi                      (s_axi_lite),
        //------ Output clk & rst -----//
        .risc_clk                   (risc_clk),
        .risc_resetn                (risc_resetn),
        .validation_reset           (validation_reset)
    );
endmodule
