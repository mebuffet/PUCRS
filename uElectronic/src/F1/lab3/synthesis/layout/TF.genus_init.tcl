#####################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 11/30/2016 18:19:23
#
#####################################################################


read_mmmc layout/TF.mmmc.tcl

read_physical -lef {/soft64/design-kits/stm/65nm-cmos065_536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef /home/micro2/lab3/synthesis/../Complex_f2.lef /home/micro2/lab3/synthesis/../inv.lef /soft64/design-kits/stm/65nm-cmos065_537/CORE65GPSVT/5.2/LEF/CORE65GPSVT.lef /soft64/design-kits/stm/65nm-cmos065_536/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef}

read_netlist layout/TF.v

init_design -skip_sdc_read
