onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib gf_mul_3_LUT_opt

do {wave.do}

view wave
view structure
view signals

do {gf_mul_3_LUT.udo}

run -all

quit -force
