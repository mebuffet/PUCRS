# ####################################################################

#  Created by Genus(TM) Synthesis Solution 16.10-p006_1 on Tue Nov 28 01:05:00 -0200 2017

# ####################################################################

set sdc_version 1.7

set_units -capacitance 1000.0fF
set_units -time 1000.0ps

# Set the current design
current_design PIF2WB

create_clock -name "CLK" -add -period 5.2 -waveform {0.0 2.6} [get_ports CLK]
set_clock_gating_check -setup 0.0 
set_wire_load_selection_group "default_by_area" -library "CORE65GPSVT"
set_dont_use [get_lib_cells HS65_GS_BK1SX1]
set_dont_use [get_lib_cells HS65_GS_BK1X1]
set_dont_use [get_lib_cells HS65_GS_DFPHQNX18]
set_dont_use [get_lib_cells HS65_GS_DFPHQNX27]
set_dont_use [get_lib_cells HS65_GS_DFPHQNX35]
set_dont_use [get_lib_cells HS65_GS_DFPHQX18]
set_dont_use [get_lib_cells HS65_GS_DFPHQX27]
set_dont_use [get_lib_cells HS65_GS_DFPHQX35]
set_dont_use [get_lib_cells HS65_GS_DFPQNX18]
set_dont_use [get_lib_cells HS65_GS_DFPQNX27]
set_dont_use [get_lib_cells HS65_GS_DFPQNX35]
set_dont_use [get_lib_cells HS65_GS_DFPQX18]
set_dont_use [get_lib_cells HS65_GS_DFPQX27]
set_dont_use [get_lib_cells HS65_GS_DFPQX35]
set_dont_use [get_lib_cells HS65_GS_DFPRQNX18]
set_dont_use [get_lib_cells HS65_GS_DFPRQNX27]
set_dont_use [get_lib_cells HS65_GS_DFPRQNX35]
set_dont_use [get_lib_cells HS65_GS_DFPRQX18]
set_dont_use [get_lib_cells HS65_GS_DFPRQX27]
set_dont_use [get_lib_cells HS65_GS_DFPRQX35]
set_dont_use [get_lib_cells HS65_GS_DFPSQNX18]
set_dont_use [get_lib_cells HS65_GS_DFPSQNX27]
set_dont_use [get_lib_cells HS65_GS_DFPSQNX35]
set_dont_use [get_lib_cells HS65_GS_DFPSQX18]
set_dont_use [get_lib_cells HS65_GS_DFPSQX27]
set_dont_use [get_lib_cells HS65_GS_DFPSQX35]
set_dont_use [get_lib_cells HS65_GS_SDFPBTQX9]
set_dont_use [get_lib_cells HS65_GS_SDFPHQNTX18]
set_dont_use [get_lib_cells HS65_GS_SDFPHQNTX27]
set_dont_use [get_lib_cells HS65_GS_SDFPHQNTX35]
set_dont_use [get_lib_cells HS65_GS_SDFPHQNX18]
set_dont_use [get_lib_cells HS65_GS_SDFPHQNX27]
set_dont_use [get_lib_cells HS65_GS_SDFPHQNX35]
set_dont_use [get_lib_cells HS65_GS_SDFPHQTX18]
set_dont_use [get_lib_cells HS65_GS_SDFPHQTX27]
set_dont_use [get_lib_cells HS65_GS_SDFPHQTX35]
set_dont_use [get_lib_cells HS65_GS_SDFPHQX18]
set_dont_use [get_lib_cells HS65_GS_SDFPHQX27]
set_dont_use [get_lib_cells HS65_GS_SDFPHQX35]
set_dont_use [get_lib_cells HS65_GS_SDFPHRQNTX18]
set_dont_use [get_lib_cells HS65_GS_SDFPHRQNTX27]
set_dont_use [get_lib_cells HS65_GS_SDFPHRQNTX35]
set_dont_use [get_lib_cells HS65_GS_SDFPHRQTX18]
set_dont_use [get_lib_cells HS65_GS_SDFPHRQTX27]
set_dont_use [get_lib_cells HS65_GS_SDFPHRQTX35]
set_dont_use [get_lib_cells HS65_GS_SDFPQNTX18]
set_dont_use [get_lib_cells HS65_GS_SDFPQNTX27]
set_dont_use [get_lib_cells HS65_GS_SDFPQNTX35]
set_dont_use [get_lib_cells HS65_GS_SDFPQNX18]
set_dont_use [get_lib_cells HS65_GS_SDFPQNX27]
set_dont_use [get_lib_cells HS65_GS_SDFPQNX35]
set_dont_use [get_lib_cells HS65_GS_SDFPQTX18]
set_dont_use [get_lib_cells HS65_GS_SDFPQTX27]
set_dont_use [get_lib_cells HS65_GS_SDFPQTX35]
set_dont_use [get_lib_cells HS65_GS_SDFPQX18]
set_dont_use [get_lib_cells HS65_GS_SDFPQX27]
set_dont_use [get_lib_cells HS65_GS_SDFPQX35]
set_dont_use [get_lib_cells HS65_GS_SDFPRQNTX18]
set_dont_use [get_lib_cells HS65_GS_SDFPRQNTX27]
set_dont_use [get_lib_cells HS65_GS_SDFPRQNTX35]
set_dont_use [get_lib_cells HS65_GS_SDFPRQNX18]
set_dont_use [get_lib_cells HS65_GS_SDFPRQNX27]
set_dont_use [get_lib_cells HS65_GS_SDFPRQNX35]
set_dont_use [get_lib_cells HS65_GS_SDFPRQTX18]
set_dont_use [get_lib_cells HS65_GS_SDFPRQTX27]
set_dont_use [get_lib_cells HS65_GS_SDFPRQTX35]
set_dont_use [get_lib_cells HS65_GS_SDFPRQX18]
set_dont_use [get_lib_cells HS65_GS_SDFPRQX27]
set_dont_use [get_lib_cells HS65_GS_SDFPRQX35]
set_dont_use [get_lib_cells HS65_GS_SDFPSQNTX18]
set_dont_use [get_lib_cells HS65_GS_SDFPSQNTX27]
set_dont_use [get_lib_cells HS65_GS_SDFPSQNTX35]
set_dont_use [get_lib_cells HS65_GS_SDFPSQNX18]
set_dont_use [get_lib_cells HS65_GS_SDFPSQNX27]
set_dont_use [get_lib_cells HS65_GS_SDFPSQNX35]
set_dont_use [get_lib_cells HS65_GS_SDFPSQTX18]
set_dont_use [get_lib_cells HS65_GS_SDFPSQTX27]
set_dont_use [get_lib_cells HS65_GS_SDFPSQTX35]
set_dont_use [get_lib_cells HS65_GS_SDFPSQX18]
set_dont_use [get_lib_cells HS65_GS_SDFPSQX27]
set_dont_use [get_lib_cells HS65_GS_SDFPSQX35]
