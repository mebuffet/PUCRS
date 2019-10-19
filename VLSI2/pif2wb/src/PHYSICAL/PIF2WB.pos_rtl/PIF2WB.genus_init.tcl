#####################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 11/28/2017 01:05:01
#
#####################################################################


read_mmmc /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl/PIF2WB.mmmc.tcl

read_physical -lef {/soft64/design-kits/stm/65nm-cmos065_536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef /soft64/design-kits/stm/65nm-cmos065_536/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/CADENCE/LEF/CORE65GPSVT_soc.lef}

read_netlist /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl/PIF2WB.v.gz

init_design -skip_sdc_read
