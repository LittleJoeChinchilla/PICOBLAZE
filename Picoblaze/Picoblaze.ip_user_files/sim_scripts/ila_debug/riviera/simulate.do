onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ila_debug -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -O5 xil_defaultlib.ila_debug xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {ila_debug.udo}

run -all

endsim

quit -force
