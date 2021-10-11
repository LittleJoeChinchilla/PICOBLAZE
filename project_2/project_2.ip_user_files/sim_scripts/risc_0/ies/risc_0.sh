#!/bin/bash -f
# Vivado (TM) v2016.1 (64-bit)
#
# Filename    : risc_0.sh
# Simulator   : Cadence Incisive Enterprise Simulator
# Description : Simulation script for compiling, elaborating and verifying the project source files.
#               The script will automatically create the design libraries sub-directories in the run
#               directory, add the library logical mappings in the simulator setup file, create default
#               'do/prj' file, execute compilation, elaboration and simulation steps.
#
# Generated by Vivado on Thu Oct 22 19:16:04 +0200 2020
# IP Build 1537824 on Fri Apr  8 04:28:57 MDT 2016 
#
# usage: risc_0.sh [-help]
# usage: risc_0.sh [-lib_map_path]
# usage: risc_0.sh [-noclean_files]
# usage: risc_0.sh [-reset_run]
#
# Prerequisite:- To compile and run simulation, you must compile the Xilinx simulation libraries using the
# 'compile_simlib' TCL command. For more information about this command, run 'compile_simlib -help' in the
# Vivado Tcl Shell. Once the libraries have been compiled successfully, specify the -lib_map_path switch
# that points to these libraries and rerun export_simulation. For more information about this switch please
# type 'export_simulation -help' in the Tcl shell.
#
# You can also point to the simulation libraries by either replacing the <SPECIFY_COMPILED_LIB_PATH> in this
# script with the compiled library directory path or specify this path with the '-lib_map_path' switch when
# executing this script. Please type 'risc_0.sh -help' for more information.
#
# Additional references - 'Xilinx Vivado Design Suite User Guide:Logic simulation (UG900)'
#
# ********************************************************************************************************

# Directory path for design sources and include directories (if any) wrt this path
ref_dir="."

# Override directory with 'export_sim_ref_dir' env path value if set in the shell
if [[ (! -z "$export_sim_ref_dir") && ($export_sim_ref_dir != "") ]]; then
  ref_dir="$export_sim_ref_dir"
fi

# Command line options
# Script info
echo -e "risc_0.sh - Script generated by export_simulation (Vivado v2016.1 (64-bit)-id)\n"

# Main steps
run()
{
  check_args $# $1
  setup $1 $2
  execute
}

# RUN_STEP: <execute>
execute()
{
  XILINX_VIVADO=C:/Xilinx/Vivado/2016.1
  export XILINX_VIVADO
  irun -V93 -RELAX \
       -64bit \
       -timescale 1ps/1ps \
       -top xil_defaultlib.risc_0 \
       -f run.f \
       -top glbl \
       glbl.v \
       -sv \
       +incdir+"$ref_dir/../../../../RISC.srcs/sources_1/ip/risc_0/src" \
       +incdir+"$ref_dir/../../../ipstatic/clk_wiz_v5_3_0" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_ila/ila_v6_1_0/hdl/verilog" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_ila/ltlib_v1_0_0/hdl/verilog" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_ila/xsdbm_v1_1_2/hdl/verilog" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_ila/xsdbs_v1_0_2/hdl/verilog" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_jtag_axi4_lite/ltlib_v1_0_0/hdl/verilog" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_jtag_axi4_lite/xsdbs_v1_0_2/hdl/verilog" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_vio/ltlib_v1_0_0/hdl/verilog" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_vio/vio_v3_0_11/hdl" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_vio/xsdbm_v1_1_2/hdl/verilog" \
       +incdir+"../../../../RISC.srcs/sources_1/ip/risc_0/src/risc_vio/xsdbs_v1_0_2/hdl/verilog" \
       +incdir+"../../../ipstatic/clk_wiz_v5_3_0"
}

# STEP: setup
setup()
{
  case $1 in
    "-lib_map_path" )
      if [[ ($2 == "") ]]; then
        echo -e "ERROR: Simulation library directory path not specified (type \"./risc_0.sh -help\" for more information)\n"
        exit 1
      fi
     create_lib_mappings $2
     touch hdl.var
    ;;
    "-reset_run" )
      reset_run
      echo -e "INFO: Simulation run files deleted.\n"
      exit 0
    ;;
    "-noclean_files" )
      # do not remove previous data
    ;;
    * )
     create_lib_mappings $2
     touch hdl.var
  esac

  # Add any setup/initialization commands here:-

  # <user specific commands>

}

# Create design library directory paths and define design library mappings in cds.lib
create_lib_mappings()
{
  libs=(xil_defaultlib xpm jtag_axi lib_cdc_v1_0_2 proc_sys_reset_v5_0_9 blk_mem_gen_v8_3_2 xbip_dsp48_wrapper_v3_0_4 xbip_utils_v3_0_6 xbip_pipe_v3_0_2 xbip_dsp48_macro_v3_0_12)
  file="cds.lib"
  dir="ies"

  if [[ -e $file ]]; then
    if [[ ($1 == "") ]]; then
      return
    else
      rm -rf $file
    fi
  fi

  if [[ -e $dir ]]; then
    rm -rf $dir
  fi

  touch $file
  lib_map_path=""
  if [[ ($1 != "") ]]; then
    lib_map_path="$1"
  fi
  if [[ ($lib_map_path != "") ]]; then
    incl_ref="INCLUDE $lib_map_path/cds.lib"
    echo $incl_ref >> $file
  fi

  for (( i=0; i<${#libs[*]}; i++ )); do
    lib="${libs[i]}"
    lib_dir="$dir/$lib"
    if [[ ! -e $lib_dir ]]; then
      mkdir -p $lib_dir
      mapping="DEFINE $lib $dir/$lib"
      echo $mapping >> $file
    fi
  done
}
# Remove generated data from the previous run and re-create setup files/library mappings
reset_run()
{
  files_to_remove=(ncsim.key irun.key ncvlog.log ncvhdl.log compile.log elaborate.log simulate.log run.log waves.shm INCA_libs)
  for (( i=0; i<${#files_to_remove[*]}; i++ )); do
    file="${files_to_remove[i]}"
    if [[ -e $file ]]; then
      rm -rf $file
    fi
  done
}

# Check command line arguments
check_args()
{
  if [[ ($1 == 1 ) && ($2 != "-lib_map_path" && $2 != "-noclean_files" && $2 != "-reset_run" && $2 != "-help" && $2 != "-h") ]]; then
    echo -e "ERROR: Unknown option specified '$2' (type \"./risc_0.sh -help\" for more information)\n"
    exit 1
  fi

  if [[ ($2 == "-help" || $2 == "-h") ]]; then
    usage
  fi

}

# Script usage
usage()
{
  msg="Usage: risc_0.sh [-help]\n\
Usage: risc_0.sh [-lib_map_path]\n\
Usage: risc_0.sh [-reset_run]\n\
Usage: risc_0.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}

# Launch script
run $1 $2