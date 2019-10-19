#####################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 09/06/2016 16:51:33
#
#####################################################################


read_mmmc layout/anel.mmmc.tcl

read_physical -lef {/soft64/design-kits/stm/65nm-cmos065_536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef /home/micro1/lab3/synthesis/../inv.lef /soft64/design-kits/stm/65nm-cmos065_537/CORE65GPSVT/5.2/LEF/CORE65GPSVT.lef /soft64/design-kits/stm/65nm-cmos065_536/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef}

read_netlist layout/anel.v

init_design
