onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L blk_mem_gen_v8_4_1 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.gf_mul_2_LUT xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {gf_mul_2_LUT.udo}

run -all

quit -force
