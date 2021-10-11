vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/ila_v6_1_0/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/xsdbm_v1_1_2/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/xsdbs_v1_0_2/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/ila_v6_1_0/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/xsdbm_v1_1_2/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/xsdbs_v1_0_2/hdl/verilog" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \

vcom -work xpm -64 \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/ila_v6_1_0/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/xsdbm_v1_1_2/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/xsdbs_v1_0_2/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/ila_v6_1_0/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/xsdbm_v1_1_2/hdl/verilog" "+incdir+../../../../Picoblaze.srcs/sources_1/ip/ila_debug/xsdbs_v1_0_2/hdl/verilog" \
"../../../../Picoblaze.srcs/sources_1/ip/ila_debug/sim/ila_debug.v" \

vlog -work xil_defaultlib "glbl.v"

