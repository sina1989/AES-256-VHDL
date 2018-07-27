vlib work
vlib activehdl

vlib activehdl/blk_mem_gen_v8_4_1
vlib activehdl/xil_defaultlib

vmap blk_mem_gen_v8_4_1 activehdl/blk_mem_gen_v8_4_1
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work blk_mem_gen_v8_4_1  -v2k5 \
"../../../../AES_TEST_1.srcs/sources_1/bd/gf_mul_3_LUT/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/gf_mul_3_LUT/ip/gf_mul_3_LUT_blk_mem_gen_0_0/sim/gf_mul_3_LUT_blk_mem_gen_0_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/gf_mul_3_LUT/sim/gf_mul_3_LUT.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

