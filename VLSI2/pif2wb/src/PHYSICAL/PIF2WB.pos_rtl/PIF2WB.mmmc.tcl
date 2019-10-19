#################################################################################
#
# Created by Genus(TM) Synthesis Solution 16.10-p006_1 on Tue Nov 28 01:05:00 -0200 2017
#
#################################################################################

## library_sets
create_library_set -name default_emulate_libset_max \
    -timing { /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_nom_1.00V_25C.lib }
create_library_set -name WORST \
    -timing { /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_wc_1.00V_125C.lib }
create_library_set -name NOMINAL \
    -timing { /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_nom_1.00V_25C.lib }
create_library_set -name BEST \
    -timing { /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_bc_0.95V_m40C.lib }

## opcond
create_opcond -name default_emulate_opcond -process 1.0 -voltage 1.0 -temperature 25.0
create_opcond -name cond_WORST -process 1.0 -voltage 1.0 -temperature 125.0
create_opcond -name cond_NOMINAL -process 1.0 -voltage 1.0 -temperature 25.0
create_opcond -name cond_BEST -process 1.0 -voltage 0.95 -temperature -40.0

## timing_condition
create_timing_condition -name default_emulate_timing_cond_max \
    -opcond default_emulate_opcond \
    -library_sets { default_emulate_libset_max }
create_timing_condition -name WORST_timing \
    -opcond cond_WORST \
    -opcond_library \/soft64\/design-kits\/stm\/65nm-cmos065_536\/CORE65GPSVT_5.1\/libs\/CORE65GPSVT_wc_1.00V_125C.lib \
    -library_sets { WORST }
create_timing_condition -name NOMINAL_timing \
    -opcond cond_NOMINAL \
    -opcond_library \/soft64\/design-kits\/stm\/65nm-cmos065_536\/CORE65GPSVT_5.1\/libs\/CORE65GPSVT_nom_1.00V_25C.lib \
    -library_sets { NOMINAL }
create_timing_condition -name BEST_timing \
    -opcond cond_BEST \
    -opcond_library \/soft64\/design-kits\/stm\/65nm-cmos065_536\/CORE65GPSVT_5.1\/libs\/CORE65GPSVT_bc_0.95V_m40C.lib \
    -library_sets { BEST }

## rc_corner
create_rc_corner -name default_emulate_rc_corner \
    -temperature 25.0 \
    -cap_table /soft64/design-kits/stm/65nm-cmos065_536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.captable \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0}

## delay_corner
create_delay_corner -name delay_corner_WORST \
    -early_timing_condition { WORST_timing } \
    -late_timing_condition { WORST_timing } \
    -early_rc_corner default_emulate_rc_corner \
    -late_rc_corner default_emulate_rc_corner
create_delay_corner -name delay_corner_NOMINAL \
    -early_timing_condition { NOMINAL_timing } \
    -late_timing_condition { NOMINAL_timing } \
    -early_rc_corner default_emulate_rc_corner \
    -late_rc_corner default_emulate_rc_corner
create_delay_corner -name delay_corner_BEST \
    -early_timing_condition { BEST_timing } \
    -late_timing_condition { BEST_timing } \
    -early_rc_corner default_emulate_rc_corner \
    -late_rc_corner default_emulate_rc_corner

## constraint_mode
create_constraint_mode -name default_constraint \
    -sdc_files { /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl//PIF2WB.default_constraint.sdc }

## analysis_view
create_analysis_view -name view_WORST \
    -constraint_mode default_constraint \
    -delay_corner delay_corner_WORST
create_analysis_view -name view_NOMINAL \
    -constraint_mode default_constraint \
    -delay_corner delay_corner_NOMINAL
create_analysis_view -name view_BEST \
    -constraint_mode default_constraint \
    -delay_corner delay_corner_BEST

## set_analysis_view
set_analysis_view -setup { view_NOMINAL } \
                  -hold { view_NOMINAL }
