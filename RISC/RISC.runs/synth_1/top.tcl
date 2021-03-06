# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/PROJEKT/PICOBLAZE/RISC/RISC.cache/wt [current_project]
set_property parent.project_path D:/PROJEKT/PICOBLAZE/RISC/RISC.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths {
  d:/PROJEKT/release/ip_repo
  d:/PROJEKT/release/ip_repo_v0.2
} [current_project]
add_files -quiet D:/PROJEKT/PICOBLAZE/RISC/RISC.srcs/sources_1/ip/risc_0/risc_0.dcp
set_property used_in_implementation false [get_files D:/PROJEKT/PICOBLAZE/RISC/RISC.srcs/sources_1/ip/risc_0/risc_0.dcp]
read_verilog -library xil_defaultlib D:/PROJEKT/PICOBLAZE/RISC/RISC.srcs/sources_1/new/top.v
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/PROJEKT/PICOBLAZE/RISC/RISC.srcs/constrs_1/new/zybo.xdc
set_property used_in_implementation false [get_files D:/PROJEKT/PICOBLAZE/RISC/RISC.srcs/constrs_1/new/zybo.xdc]


synth_design -top top -part xc7z020clg400-1


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
