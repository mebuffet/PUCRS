######################################################################

# Created by Genus(TM) Synthesis Solution 16.10-p006_1 on Wed Jun 21 18:07:51 -0300 2017

# This file contains the RC script for design:TF

######################################################################

set_db -quiet information_level 9
set_db -quiet design_mode_process 100.0
set_db -quiet phys_assume_met_fill 0.0
set_db -quiet tinfo_tstamp_file .rs_micro2.tstamp
set_db -quiet script_search_path ./
set_db -quiet use_area_from_lef true
set_db -quiet flow_metrics_snapshot_uuid 2d23d5c6
set_db -quiet phys_use_segment_parasitics true
set_db -quiet probabilistic_extraction true
set_db -quiet ple_correlation_factors {1.9000 2.0000}
set_db -quiet maximum_interval_of_vias inf
set_db -quiet ple_mode global
set_db -quiet wireload_selection wireload_selection:default_emulate_libset_max/CORE65GPSVT/default_by_area
set_db -quiet operating_condition:default_emulate_libset_max/inv/PVT_1V_25C .tree_type balanced_tree
set_db -quiet operating_condition:default_emulate_libset_max/inv/_nominal_ .tree_type balanced_tree
set_db -quiet operating_condition:default_emulate_libset_max/CORE65GPSVT/nom_1.00V_25C .tree_type balanced_tree
set_db -quiet operating_condition:default_emulate_libset_max/CORE65GPSVT/_nominal_ .tree_type balanced_tree
# BEGIN MSV SECTION
# END MSV SECTION
# BEGIN DFT SECTION
set_db -quiet dft_scan_style muxed_scan
set_db -quiet dft_scanbit_waveform_analysis false
# END DFT SECTION
set_db -quiet design:TF .hdl_filelist {{default -vhdl1993 {SYNTHESIS} {src/Complex_f2.vhd} {src}}}
set_db -quiet design:TF .hdl_user_name TF
set_db -quiet design:TF .verification_directory fv/TF
set_db -quiet design:TF .arch_filename ./src/Complex_f2.vhd
set_db -quiet design:TF .entity_filename ./src/Complex_f2.vhd
set_db -quiet port:TF/A .min_transition no_value
set_db -quiet port:TF/B .min_transition no_value
set_db -quiet port:TF/C .min_transition no_value
set_db -quiet port:TF/D .min_transition no_value
set_db -quiet port:TF/F .min_transition no_value
# BEGIN PHYSICAL ANNOTATION SECTION
# END PHYSICAL ANNOTATION SECTION
