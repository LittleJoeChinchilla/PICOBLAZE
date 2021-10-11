onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L jtag_axi -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_9 -L blk_mem_gen_v8_3_2 -L xbip_dsp48_wrapper_v3_0_4 -L xbip_utils_v3_0_6 -L xbip_pipe_v3_0_2 -L xbip_dsp48_macro_v3_0_12 -lib xil_defaultlib xil_defaultlib.risc_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {risc_0.udo}

run -all

quit -force
