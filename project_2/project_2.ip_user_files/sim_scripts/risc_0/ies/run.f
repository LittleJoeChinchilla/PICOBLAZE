-makelib ies/xil_defaultlib \
  "C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
  "C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
  "C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
  "C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
  "C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
  "C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
  "C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/jtag_axi \
  "../../../ipstatic/jtag_axi/hdl/jtag_axi_v1_1_rfs.v" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_jtag_axi4_lite/sim/risc_jtag_axi4_lite.v" \
-endlib
-makelib ies/lib_cdc_v1_0_2 \
  "../../../ipstatic/lib_cdc_v1_0_2/hdl/src/vhdl/cdc_sync.vhd" \
-endlib
-makelib ies/proc_sys_reset_v5_0_9 \
  "../../../ipstatic/proc_sys_reset_v5_0_9/hdl/src/vhdl/upcnt_n.vhd" \
  "../../../ipstatic/proc_sys_reset_v5_0_9/hdl/src/vhdl/sequence_psr.vhd" \
  "../../../ipstatic/proc_sys_reset_v5_0_9/hdl/src/vhdl/lpf.vhd" \
  "../../../ipstatic/proc_sys_reset_v5_0_9/hdl/src/vhdl/proc_sys_reset.vhd" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_reset/sim/risc_reset.vhd" \
-endlib
-makelib ies/blk_mem_gen_v8_3_2 \
  "../../../ipstatic/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_registers_memory/sim/risc_registers_memory.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_clock_internal/risc_clock_internal_clk_wiz.v" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_clock_internal/risc_clock_internal.v" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_clock_external/risc_clock_external_clk_wiz.v" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_clock_external/risc_clock_external.v" \
-endlib
-makelib ies/xbip_dsp48_wrapper_v3_0_4 \
  "../../../ipstatic/xbip_dsp48_wrapper_v3_0_4/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/xbip_utils_v3_0_6 \
  "../../../ipstatic/xbip_utils_v3_0_6/hdl/xbip_utils_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies/xbip_pipe_v3_0_2 \
  "../../../ipstatic/xbip_pipe_v3_0_2/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \
  "../../../ipstatic/xbip_pipe_v3_0_2/hdl/xbip_pipe_v3_0.vhd" \
-endlib
-makelib ies/xbip_dsp48_macro_v3_0_12 \
  "../../../ipstatic/xbip_dsp48_macro_v3_0_12/hdl/xbip_dsp48_macro_v3_0_vh_rfs.vhd" \
  "../../../ipstatic/xbip_dsp48_macro_v3_0_12/hdl/xbip_dsp48_macro_v3_0.vhd" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_alu_dsp/sim/risc_alu_dsp.vhd" \
-endlib
-makelib ies/blk_mem_gen_v8_3_2 \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_shared_memory_8K/sim/risc_shared_memory_8K.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_vio/sim/risc_vio.v" \
-endlib
-makelib ies/blk_mem_gen_v8_3_2 \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_program_memory/sim/risc_program_memory.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_ila/sim/risc_ila.v" \
-endlib
-makelib ies/blk_mem_gen_v8_3_2 \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_data_memory/sim/risc_data_memory.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/logic_axi4_lite_pkg.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/logic_axi4_lite_if.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_stack.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_jtag_axi4_lite_wrapper.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_instruction_decode_pkg.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_alu_pkg.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_registers.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_jtag.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_interrupt_controller.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_instruction_decode.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_clocking.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_axi_driver.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_alu.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_axi_slave_driver.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc.sv" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_core_verilog_wrapper.sv" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../RISC.srcs/sources_1/ip/risc_0/hdl/risc_v0_1.v" \
  "../../../../RISC.srcs/sources_1/ip/risc_0/sim/risc_0.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

