#################################################################################
#
# Created by Genus(TM) Synthesis Solution GENUS15.20 - 15.20-p004_1 on Tue Sep 06 16:51:33 -0300 2016
#
#################################################################################

## library_sets
create_library_set -name default_emulate_libset_max \
    -timing { /home/micro1/lab3/synthesis/../characterization/inv.lib \
              /soft64/design-kits/stm/65nm-cmos065_537/CORE65GPSVT/5.2/libs/CORE65GPSVT_nom_1.00V_25C.lib }

## opcond
create_opcond -name default_emulate_opcond -process 1.0 -voltage 1.0 -temperature 25.0

## timing_condition
create_timing_condition -name default_emulate_timing_cond_max \
    -opcond default_emulate_opcond \
    -library_sets { default_emulate_libset_max }

## rc_corner
create_rc_corner -name default_emulate_rc_corner \
    -temperature 25.0 \
    -cap_table /soft64/design-kits/stm/65nm-cmos065_536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.captable \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0}

## delay_corner
create_delay_corner -name default_emulate_delay_corner \
    -early_timing_condition { default_emulate_timing_cond_max } \
    -late_timing_condition { default_emulate_timing_cond_max } \
    -early_rc_corner default_emulate_rc_corner \
    -late_rc_corner default_emulate_rc_corner

## constraint_mode
create_constraint_mode -name default_emulate_constraint_mode \
    -sdc_files { layout//anel.default_emulate_constraint_mode.sdc }

## analysis_view
create_analysis_view -name default_emulate_view \
    -constraint_mode default_emulate_constraint_mode \
    -delay_corner default_emulate_delay_corner

## set_analysis_view
set_analysis_view -setup { default_emulate_view } \
                  -hold { default_emulate_view }
