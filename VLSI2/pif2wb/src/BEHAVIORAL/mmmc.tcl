#op cond
create_opcond -name cond_WORST -process 1.0 -voltage 1.00 -temperature 125.0
create_opcond -name cond_NOMINAL -process 1.0 -voltage 1.00 -temperature 25.0
create_opcond -name cond_BEST -process 1.0 -voltage 0.95 -temperature -40.0

#create library set
create_library_set -name WORST -timing /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_wc_1.00V_125C.lib
create_library_set -name NOMINAL -timing /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_nom_1.00V_25C.lib
create_library_set -name BEST -timing /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_bc_0.95V_m40C.lib

# timing_condition
create_timing_condition -name WORST_timing -opcond cond_WORST -library_sets WORST -opcond_library /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_wc_1.00V_125C.lib
create_timing_condition -name NOMINAL_timing -opcond cond_NOMINAL -library_sets NOMINAL -opcond_library /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_nom_1.00V_25C.lib
create_timing_condition -name BEST_timing -opcond cond_BEST -library_sets BEST -opcond_library /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_bc_0.95V_m40C.lib

#constraints
create_constraint_mode -name default_constraint -sdc_files /home/vlsi2_g05/VLSI2/pif2wb/src/constraints_pre_rtl.sdc

#delay corner
create_delay_corner -name delay_corner_WORST -timing_condition WORST_timing
create_delay_corner -name delay_corner_NOMINAL -timing_condition NOMINAL_timing
create_delay_corner -name delay_corner_BEST -timing_condition BEST_timing

#analysis_view
create_analysis_view -name view_WORST -constraint_mode default_constraint -delay_corner delay_corner_WORST
create_analysis_view -name view_NOMINAL -constraint_mode default_constraint -delay_corner delay_corner_NOMINAL
create_analysis_view -name view_BEST -constraint_mode default_constraint -delay_corner delay_corner_BEST

set_analysis_view -setup view_NOMINAL
