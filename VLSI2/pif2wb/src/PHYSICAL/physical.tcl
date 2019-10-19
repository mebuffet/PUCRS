#DEFINICAO DO NODO TECNOLOGICO
set_db design_process_node 65

#CRIACAO DA REDE GLOBAL
set_db init_power_nets vdd
set_db init_ground_nets gnd

#ARQUIVO DE CONFIGURACAO DA SINTESE COMPORTAMENTAL
source /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl/PIF2WB.invs_setup.tcl

#DEFINICAO DO FLOORPLANNING
create_floorplan -site CORE -core_density_size 1 0.7 5 5 5 5
gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/1-floorplan.gif

#DISTRIBUICAO DOS PINOS
edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Top -layer 4 -spread_type center -spacing 0.5 -pin {ACK_I {BTE_O[0]} {BTE_O[1]} CLK {CTI_O[0]} {CTI_O[1]} {CTI_O[2]} CYC_O ERR_I {PIReqCNTL[0]} {PIReqCNTL[1]} {PIReqCNTL[2]} {PIReqCNTL[3]} {PIReqCNTL[4]} {PIReqCNTL[5]} {PIReqCNTL[6]} {PIReqCNTL[7]} {PIReqDataBE[0]} {PIReqDataBE[1]} {PIReqDataBE[2]} {PIReqDataBE[3]} PIReqVALID PIRespRDY POReqRDY {PORespCNTL[0]} {PORespCNTL[1]} {PORespCNTL[2]} {PORespCNTL[3]} {PORespCNTL[4]} {PORespCNTL[5]} {PORespCNTL[6]} {PORespCNTL[7]} PORespVALID RST {SEL_O[0]} {SEL_O[1]} {SEL_O[2]} {SEL_O[3]} STB_O WE_O}
edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Left -layer 4 -spread_type center -spacing 0.5 -pin {{ADR_O[0]} {ADR_O[1]} {ADR_O[2]} {ADR_O[3]} {ADR_O[4]} {ADR_O[5]} {ADR_O[6]} {ADR_O[7]} {ADR_O[8]} {ADR_O[9]} {ADR_O[10]} {ADR_O[11]} {ADR_O[12]} {ADR_O[13]} {ADR_O[14]} {ADR_O[15]} {ADR_O[16]} {ADR_O[17]} {ADR_O[18]} {ADR_O[19]} {ADR_O[20]} {ADR_O[21]} {ADR_O[22]} {ADR_O[23]} {ADR_O[24]} {ADR_O[25]} {ADR_O[26]} {ADR_O[27]} {ADR_O[28]} {ADR_O[29]} {ADR_O[30]} {ADR_O[31]} {DAT_I[0]} {DAT_I[1]} {DAT_I[2]} {DAT_I[3]} {DAT_I[4]} {DAT_I[5]} {DAT_I[6]} {DAT_I[7]} {DAT_I[8]} {DAT_I[9]} {DAT_I[10]} {DAT_I[11]} {DAT_I[12]} {DAT_I[13]} {DAT_I[14]} {DAT_I[15]} {DAT_I[16]} {DAT_I[17]} {DAT_I[18]} {DAT_I[19]} {DAT_I[20]} {DAT_I[21]} {DAT_I[22]} {DAT_I[23]} {DAT_I[24]} {DAT_I[25]} {DAT_I[26]} {DAT_I[27]} {DAT_I[28]} {DAT_I[29]} {DAT_I[30]} {DAT_I[31]}}
edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Right -layer 4 -spread_type center -spacing 0.5 -pin {{DAT_O[0]} {DAT_O[1]} {DAT_O[2]} {DAT_O[3]} {DAT_O[4]} {DAT_O[5]} {DAT_O[6]} {DAT_O[7]} {DAT_O[8]} {DAT_O[9]} {DAT_O[10]} {DAT_O[11]} {DAT_O[12]} {DAT_O[13]} {DAT_O[14]} {DAT_O[15]} {DAT_O[16]} {DAT_O[17]} {DAT_O[18]} {DAT_O[19]} {DAT_O[20]} {DAT_O[21]} {DAT_O[22]} {DAT_O[23]} {DAT_O[24]} {DAT_O[25]} {DAT_O[26]} {DAT_O[27]} {DAT_O[28]} {DAT_O[29]} {DAT_O[30]} {DAT_O[31]} {PIReqADRS[0]} {PIReqADRS[1]} {PIReqADRS[2]} {PIReqADRS[3]} {PIReqADRS[4]} {PIReqADRS[5]} {PIReqADRS[6]} {PIReqADRS[7]} {PIReqADRS[8]} {PIReqADRS[9]} {PIReqADRS[10]} {PIReqADRS[11]} {PIReqADRS[12]} {PIReqADRS[13]} {PIReqADRS[14]} {PIReqADRS[15]} {PIReqADRS[16]} {PIReqADRS[17]} {PIReqADRS[18]} {PIReqADRS[19]} {PIReqADRS[20]} {PIReqADRS[21]} {PIReqADRS[22]} {PIReqADRS[23]} {PIReqADRS[24]} {PIReqADRS[25]} {PIReqADRS[26]} {PIReqADRS[27]} {PIReqADRS[28]} {PIReqADRS[29]} {PIReqADRS[30]} {PIReqADRS[31]}}
edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Bottom -layer 4 -spread_type center -spacing 0.5 -pin {{PIReqDATA[0]} {PIReqDATA[1]} {PIReqDATA[2]} {PIReqDATA[3]} {PIReqDATA[4]} {PIReqDATA[5]} {PIReqDATA[6]} {PIReqDATA[7]} {PIReqDATA[8]} {PIReqDATA[9]} {PIReqDATA[10]} {PIReqDATA[11]} {PIReqDATA[12]} {PIReqDATA[13]} {PIReqDATA[14]} {PIReqDATA[15]} {PIReqDATA[16]} {PIReqDATA[17]} {PIReqDATA[18]} {PIReqDATA[19]} {PIReqDATA[20]} {PIReqDATA[21]} {PIReqDATA[22]} {PIReqDATA[23]} {PIReqDATA[24]} {PIReqDATA[25]} {PIReqDATA[26]} {PIReqDATA[27]} {PIReqDATA[28]} {PIReqDATA[29]} {PIReqDATA[30]} {PIReqDATA[31]} {PORespDATA[0]} {PORespDATA[1]} {PORespDATA[2]} {PORespDATA[3]} {PORespDATA[4]} {PORespDATA[5]} {PORespDATA[6]} {PORespDATA[7]} {PORespDATA[8]} {PORespDATA[9]} {PORespDATA[10]} {PORespDATA[11]} {PORespDATA[12]} {PORespDATA[13]} {PORespDATA[14]} {PORespDATA[15]} {PORespDATA[16]} {PORespDATA[17]} {PORespDATA[18]} {PORespDATA[19]} {PORespDATA[20]} {PORespDATA[21]} {PORespDATA[22]} {PORespDATA[23]} {PORespDATA[24]} {PORespDATA[25]} {PORespDATA[26]} {PORespDATA[27]} {PORespDATA[28]} {PORespDATA[29]} {PORespDATA[30]} {PORespDATA[31]}}
gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/2-pin.gif

#DEFINICAO DOS CONEXOES GLOBAIS DE VDD/GND
delete_global_net_connections
connect_global_net vdd -type pg_pin -pin_base_name vdd -inst_base_name *
connect_global_net vdd -type tie_hi -inst_base_name *
connect_global_net gnd -type pg_pin -pin_base_name gnd -inst_base_name *
connect_global_net gnd -type tie_lo -inst_base_name *

#CRIACAO DOS POWER RINGS E POWER STRIPS E ROTEAMENTO DE VDD/GND
eval_legacy {addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer AP -type core_rings -jog_distance 2.5 -threshold 2.5 -nets {gnd vdd} -follow core -stacked_via_bottom_layer M1 -layer {bottom M1 top M1 right M2 left M2} -width 1 -spacing 0.5 -offset 0.5}

#source /home/vlsi2_g05/VLSI2/pif2wb/src/gui.color.tcl
gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/3-ring.gif

eval_legacy {addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit M1 -max_same_layer_jog_length 6 -padcore_ring_bottom_layer_limit M1 -number_of_sets 1 -skip_via_on_pin Standardcell -stacked_via_top_layer AP -padcore_ring_top_layer_limit M1 -spacing 2 -xleft_offset 20 -xright_offset 20 -merge_stripes_value 2.5 -layer M2 -block_ring_bottom_layer_limit M1 -width 1 -area {} -nets {gnd vdd} -stacked_via_bottom_layer M1}
gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/4-stripe.gif

#ROTEAMENTO ESPECIAL
route_special -connect {block_pin pad_pin pad_ring core_pin floating_stripe} -layer_change_range { M1(1) AP(8) } -block_pin_target {nearest_target} -pad_pin_port_connect {all_port one_geom} -pad_pin_target {nearest_target} -core_pin_target {first_after_row_end} -floating_stripe_target {block_ring pad_ring ring stripe ring_pin block_pin followpin} -allow_jogging 1 -crossover_via_layer_range { M1(1) AP(8) } -nets {vdd gnd} -allow_layer_change 1 -block_pin use_lef -target_via_layer_range { M1(1) AP(8) }
gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/5-route.gif

#SALVAMENTO DAS ESPECIFICACOES DE FLOOR/POWER PLANNING
write_floorplan /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/PIF2WB.fp
write_io_file -locations -template /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/PIF2WB.save.io
gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/6-io_file.gif

#ADICAO DAS CONEXOES DOS BULKS
add_well_taps -cell HS65_GS_FILLERNPWPFP3 -cell_interval 8 -prefix WELLTAP
gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/7-welltap.gif

report_timing -early > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/pre_place_early.rpt
report_timing -late > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/pre_place_late.rpt
time_design -pre_place -ideal_clock -path_report -drv_report -slack_report -num_paths 50 -report_prefix PIF2WB_prePlace -report_dir /home/vlsi2_g05/VLSI2/pif2wb/src/timingReports

#COLOCACAO DA STANDARD CELL
place_design

#RESTAURACAO DAS CORES NA INTERFACE GRAFICA
source /home/vlsi2_g05/VLSI2/pif2wb/src/gui.color.tcl
gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/8-placement.gif

report_timing -early > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/place_early.rpt
report_timing -late > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/place_late.rpt
time_design -pre_place -ideal_clock -path_report -drv_report -slack_report -num_paths 50 -report_prefix PIF2WB_Place -report_dir /home/vlsi2_g05/VLSI2/pif2wb/src/timingReports

#OTIMIZAÇÃO DO PLACEMENT
place_opt_design
gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/9-placement_opt.gif

report_timing -early > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/place_opt_early.rpt
report_timing -late > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/place_opt_late.rpt
time_design -pre_place -ideal_clock -path_report -drv_report -slack_report -num_paths 50 -report_prefix PIF2WB_PlaceOpt -report_dir /home/vlsi2_g05/VLSI2/pif2wb/src/timingReports

#ANALISE DE TIMING
report_timing -early > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/pre_cts_early.rpt
report_timing -late > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/pre_cts_late.rpt
time_design -pre_cts -ideal_clock -path_report -drv_report -slack_report -num_paths 50 -report_prefix PIF2WB_preCTS -report_dir /home/vlsi2_g05/VLSI2/pif2wb/src/timingReports

#OTIMIZACAO PRE-CTS
opt_design -pre_cts

gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/10-pre_cts.gif

report_timing -early > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/pre_cts_opt_early.rpt
report_timing -late > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/pre_cts_opt_late.rpt
time_design -pre_cts -ideal_clock -path_report -drv_report -slack_report -num_paths 50 -report_prefix PIF2WB_preCTSOpt -report_dir /home/vlsi2_g05/VLSI2/pif2wb/src/timingReports

#HABILITACAO DA ENGINE LEGADO CTS
eval_legacy {set_ccopt_property buffer_cells {HS65_GS_BFX2 HS65_GS_BFX22 HS65_GS_BFX4 HS65_GS_BFX40 HS65_GS_BFX7}}
eval_legacy {set_ccopt_property inverter_cells {HS65_GS_IVX13 HS65_GS_IVX31 HS65_GS_IVX4 HS65_GS_IVX49 HS65_GS_BFX7}}
eval_legacy {set_ccopt_property use_inverters true}
eval_legacy {create_ccopt_clock_tree_spec -filename PIF2WB.pos_physical/ccopt.spec}
ccopt_design

gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/11-cts_opt.gif

report_timing -early > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/post_cts_early.rpt
report_timing -late > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/post_cts_late.rpt
time_design -post_cts -ideal_clock -path_report -drv_report -slack_report -num_paths 50 -report_prefix PIF2WB_postCTS -report_dir /home/vlsi2_g05/VLSI2/pif2wb/src/timingReports

#OTIMIZACAO POST-CTS
set_db timing_analysis_type ocv
set_db opt_fix_fanout_load true
opt_design -post_cts -drv

gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/12-post_cts.gif

report_timing -early > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/post_cts_opt_early.rpt
report_timing -late > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/post_cts_opt_late.rpt
time_design -post_cts -ideal_clock -path_report -drv_report -slack_report -num_paths 50 -report_prefix PIF2WB_postCTSOpt -report_dir /home/vlsi2_g05/VLSI2/pif2wb/src/timingReports

#OTIMIZACAO POST-ROUTE
route_design -global_detail -wire_opt

report_timing -early > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/post_route_early.rpt
report_timing -late > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/post_route_late.rpt
time_design -post_route -ideal_clock -path_report -drv_report -slack_report -num_paths 50 -report_prefix PIF2WB_postRoute -report_dir /home/vlsi2_g05/VLSI2/pif2wb/src/timingReports

set_db timing_analysis_type ocv
set_db opt_fix_fanout_load true
opt_design -post_route -drv

gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/13-post_route.gif

report_timing -early > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/post_route_opt_early.rpt
report_timing -late > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/post_route_opt_late.rpt
time_design -post_route -ideal_clock -path_report -drv_report -slack_report -num_paths 50 -report_prefix PIF2WB_postRouteOpt -report_dir /home/vlsi2_g05/VLSI2/pif2wb/src/timingReports

#ADICAO DOS FILLERS
add_fillers -base_cells {HS65_GS_FILLERSNPWPFP4 HS65_GS_FILLERSNPWPFP3 HS65_GS_FILLERPFP4 HS65_GS_FILLERPFP3 HS65_GS_FILLERPFP2 HS65_GS_FILLERPFP1 HS65_GS_FILLERPFOP9 HS65_GS_FILLERPFOP8 HS65_GS_FILLERPFOP64 HS65_GS_FILLERPFOP32 HS65_GS_FILLERPFOP16 HS65_GS_FILLERPFOP12 HS65_GS_FILLERNPWPFP8 HS65_GS_FILLERNPWPFP64 HS65_GS_FILLERNPWPFP4 HS65_GS_FILLERNPWPFP32 HS65_GS_FILLERNPWPFP3 HS65_GS_FILLERNPWPFP16} -prefix FILLER -check_drc

gui_fit
write_to_gif /home/vlsi2_g05/VLSI2/pif2wb/src/14-filler.gif

#VERIFICACAO DRC E DESIGN
check_drc -out_file /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/drc.rpt
check_design -all -no_html -out_file /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/design.rpt

#REPORTES
report_area -out_file /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/area.rpt
report_power -out_file /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/power.rpt
report_timing -early > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/timing_early.rpt
report_timing -late > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/timing_late.rpt
eval_legacy {reportCapViolation} > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/cap.rpt
eval_legacy {reportTranViolation} > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/tran.rpt
eval_legacy {reportFanoutViolation} > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/fanout.rpt
eval_legacy {reportLengthViolation} > /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/length.rpt

#SALVAMENTO DO NETLIST, DEF E SDF
write_netlist /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/PIF2WB.v
write_def -floorplan -netlist -routing /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/PIF2WB.def
write_sdf -sort_delay_values /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_physical/PIF2WB.sdf

exit

