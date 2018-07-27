vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/blk_mem_gen_v8_4_1
vlib questa_lib/msim/xil_defaultlib

vmap blk_mem_gen_v8_4_1 questa_lib/msim/blk_mem_gen_v8_4_1
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work blk_mem_gen_v8_4_1 -64 \
"../../../../AES_TEST_1.srcs/sources_1/bd/gf_mul_2_LUT/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 \
"../../../bd/gf_mul_2_LUT/ip/gf_mul_2_LUT_blk_mem_gen_0_0/sim/gf_mul_2_LUT_blk_mem_gen_0_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/gf_mul_2_LUT/sim/gf_mul_2_LUT.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

