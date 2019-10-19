#####################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution on 11/28/2017 01:05:01
#
# This file can only be run in Innovus Common UI mode.
#
#####################################################################


# User Specified CPU usage for Innovus
######################################
set_multi_cpu_usage -local_cpu 8


# Design Import
###########################################################
## Reading FlowKit settings file
source /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl/PIF2WB.flowkit_settings.tcl

source /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl/PIF2WB.invs_init.tcl

# Reading metrics file
######################
read_metric -id current /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl/PIF2WB.metrics.json 



# Mode Setup
###########################################################
source /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl/PIF2WB.mode
eval_enc { set edi_pe::pegConsiderMacroLayersUnblocked 1 }
