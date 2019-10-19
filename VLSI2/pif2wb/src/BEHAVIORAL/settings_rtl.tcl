set project_path "/home/vlsi2_g05/VLSI2/pif2wb/src"
set library_path "/soft64/design-kits/stm/65nm-cmos065_536"
set library "${library_path}/CORE65GPSVT_5.1/libs/CORE65GPSVT_nom_1.00V_25C.lib"
set lef "${library_path}/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef ${library_path}/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef ${library_path}/CORE65GPSVT_5.1/CADENCE/LEF/CORE65GPSVT_soc.lef"
set cap_table "${library_path}/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.captable"
#set efforts {express high}
#set analysis_list {view_WORST view_NOMINAL view_BEST}
set analysis_list {view_NOMINAL}
set efforts {high}
set home .
set root /
set top_module PIF2WB
set mmmc "${project_path}/mmmc.tcl"
set pre_sdc "${project_path}/constraints_pre_rtl.sdc"
set op_conditions nom_1.00V_25C
set file_list {pif2wb.vhd counter.vhd addr_dec.vhd sel_reg.vhd tran_reg.vhd}
set lp_effort high
set lp_analysis view_NOMINAL
