# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/PROJEKT/PICOBLAZE/Picoblaze/Picoblaze.cache/wt [current_project]
set_property parent.project_path D:/PROJEKT/PICOBLAZE/Picoblaze/Picoblaze.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files -quiet D:/PROJEKT/PICOBLAZE/Picoblaze/Picoblaze.srcs/sources_1/ip/ila_debug/ila_debug.dcp
set_property used_in_implementation false [get_files D:/PROJEKT/PICOBLAZE/Picoblaze/Picoblaze.srcs/sources_1/ip/ila_debug/ila_debug.dcp]
read_verilog -library xil_defaultlib {
  D:/PROJEKT/PICOBLAZE/KCPSM6/KCPSM6_Release9_30Sept14/Verilog/kcpsm6.v
  D:/PROJEKT/PICOBLAZE/Picoblaze/Picoblaze.srcs/sources_1/new/top.v
  D:/PROJEKT/PICOBLAZE/Picoblaze/Assembler/program_memory.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/PROJEKT/PICOBLAZE/Picoblaze/Picoblaze.srcs/constrs_1/new/zybo.xdc
set_property used_in_implementation false [get_files D:/PROJEKT/PICOBLAZE/Picoblaze/Picoblaze.srcs/constrs_1/new/zybo.xdc]


synth_design -top top -part xc7z020clg400-1


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }