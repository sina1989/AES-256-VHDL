vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/blk_mem_gen_v8_4_1
vlib modelsim_lib/msim/xil_defaultlib

vmap blk_mem_gen_v8_4_1 modelsim_lib/msim/blk_mem_gen_v8_4_1
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work blk_mem_gen_v8_4_1 -64 -incr \
"../../../../AES_TEST_1.srcs/sources_1/bd/gf_mul_3_LUT/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr \
"../../../bd/gf_mul_3_LUT/ip/gf_mul_3_LUT_blk_mem_gen_0_0/sim/gf_mul_3_LUT_blk_mem_gen_0_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/gf_mul_3_LUT/sim/gf_mul_3_LUT.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

