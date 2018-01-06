# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.cache/wt [current_project]
set_property parent.project_path C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.srcs/sources_1/new/blink.v
  C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.srcs/sources_1/new/countdown_double.v
  C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.srcs/sources_1/new/edge_trigger.v
  C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.srcs/sources_1/new/emergency.v
  C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.srcs/sources_1/new/fsm_lights.v
  C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.srcs/sources_1/new/scan_led_hex_display.v
  C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.srcs/sources_1/new/Traffic_lights_ce.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.srcs/constrs_1/new/Traffic_lights_ce.xdc
set_property used_in_implementation false [get_files C:/Users/starrynightzyq/Verilog_learning/Traffic_lights_comprehensive_experiment/Traffic_lights_comprehensive_experiment.srcs/constrs_1/new/Traffic_lights_ce.xdc]


synth_design -top Traffic_lights_ce -part xc7a35tcpg236-1


write_checkpoint -force -noxdef Traffic_lights_ce.dcp

catch { report_utilization -file Traffic_lights_ce_utilization_synth.rpt -pb Traffic_lights_ce_utilization_synth.pb }
