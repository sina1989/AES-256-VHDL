# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7z020clg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.cache/wt [current_project]
set_property parent.project_path C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_repo_paths {
  c:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/ip_repo/encryptor0506_1.0
  c:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs
  c:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/ip_repo/AES_Encryptor_1.0
} [current_project]
set_property ip_output_repo c:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/sboxf.coe
add_files C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/rconf.coe
add_files C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/gf2f.coe
add_files C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/gf3f.coe
read_vhdl -library xil_defaultlib {
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/new/aes_pkg.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/new/AES_Encryption.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/new/add_round_key.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/imports/hdl/gf_mul_2_LUT_wrapper.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/imports/hdl/gf_mul_3_LUT_wrapper.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/new/key_expansion.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/new/mix_cols.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/rcon_LUT/hdl/rcon_LUT_wrapper.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/new/shift_rows.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/new/sub_bytes.vhd
  C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/new/Encryption_IO_Wrapper.vhd
}
add_files C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/rcon_LUT/rcon_LUT.bd
set_property used_in_implementation false [get_files -all c:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/rcon_LUT/ip/rcon_LUT_blk_mem_gen_0_0/rcon_LUT_blk_mem_gen_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/rcon_LUT/rcon_LUT_ooc.xdc]

add_files C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/design_1/design_1.bd
set_property used_in_implementation false [get_files -all c:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/design_1/ip/design_1_blk_mem_gen_0_0/design_1_blk_mem_gen_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/design_1/design_1_ooc.xdc]

add_files C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/gf_mul_3_LUT/gf_mul_3_LUT.bd
set_property used_in_implementation false [get_files -all c:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/gf_mul_3_LUT/ip/gf_mul_3_LUT_blk_mem_gen_0_0/gf_mul_3_LUT_blk_mem_gen_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/gf_mul_3_LUT/gf_mul_3_LUT_ooc.xdc]

add_files C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/gf_mul_2_LUT/gf_mul_2_LUT.bd
set_property used_in_implementation false [get_files -all c:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/gf_mul_2_LUT/ip/gf_mul_2_LUT_blk_mem_gen_0_0/gf_mul_2_LUT_blk_mem_gen_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/sources_1/bd/gf_mul_2_LUT/gf_mul_2_LUT_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/constrs_1/new/constraints.xdc
set_property used_in_implementation false [get_files C:/Users/OmerFarukPC/Desktop/Ders/vivado_projects/AES_TEST_1/AES_TEST_1.srcs/constrs_1/new/constraints.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top Encryption_IO_Wrapper -part xc7z020clg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Encryption_IO_Wrapper.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file Encryption_IO_Wrapper_utilization_synth.rpt -pb Encryption_IO_Wrapper_utilization_synth.pb"