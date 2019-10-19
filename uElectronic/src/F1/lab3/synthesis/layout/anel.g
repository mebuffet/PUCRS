######################################################################

# Created by Genus(TM) Synthesis Solution GENUS15.20 - 15.20-p004_1 on Tue Sep 06 16:51:33 -0300 2016

# This file contains the RC script for design:anel

######################################################################

set_db / .information_level 9
set_db / .design_mode_process 100.0
set_db / .script_search_path ./
set_db / .use_area_from_lef true
set_db / .flow_metrics_snapshot_uuid 23a65732
::legacy::set_attribute -quiet phys_use_segment_parasitics true /
::legacy::set_attribute -quiet probabilistic_extraction true /
::legacy::set_attribute -quiet ple_correlation_factors {1.9000 2.0000} /
::legacy::set_attribute -quiet maximum_interval_of_vias infinity /
::legacy::set_attribute -quiet ple_mode global /
::legacy::set_attribute -quiet wireload_selection wireload_selection:default_emulate_libset_max/CORE65GPSVT/default_by_area /
::legacy::set_attribute -quiet tree_type balanced_tree operating_condition:default_emulate_libset_max/inv/PVT_1V_25C
::legacy::set_attribute -quiet tree_type balanced_tree operating_condition:default_emulate_libset_max/inv/_nominal_
::legacy::set_attribute -quiet tree_type balanced_tree operating_condition:default_emulate_libset_max/CORE65GPSVT/nom_1.00V_25C
::legacy::set_attribute -quiet tree_type balanced_tree operating_condition:default_emulate_libset_max/CORE65GPSVT/_nominal_
# BEGIN MSV SECTION
# END MSV SECTION
# BEGIN DFT SECTION
::legacy::set_attribute -quiet dft_scan_style muxed_scan /
::legacy::set_attribute -quiet dft_scanbit_waveform_analysis false /
# END DFT SECTION
::legacy::set_attribute -quiet hdl_filelist {{default -vhdl1993 {SYNTHESIS} {src/anel.vhd} {src}}} design:anel
::legacy::set_attribute -quiet hdl_user_name anel design:anel
::legacy::set_attribute -quiet verification_directory fv/anel design:anel
::legacy::set_attribute -quiet arch_filename src/anel.vhd design:anel
::legacy::set_attribute -quiet entity_filename src/anel.vhd design:anel
::legacy::set_attribute -quiet preserve const_prop_delete_ok {hnet:anel/ring[0]}
::legacy::set_attribute -quiet preserve true {inst:anel/inv_instance[12].inv_i}
::legacy::set_attribute -quiet disabled_arcs lib_arc:default_emulate_libset_max/CORE65GPSVT/HS65_GS_BFX2/A_Z_n90 inst:anel/cdn_loop_breaker
# BEGIN PHYSICAL ANNOTATION SECTION
# END PHYSICAL ANNOTATION SECTION
