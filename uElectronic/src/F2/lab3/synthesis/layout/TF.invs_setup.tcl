#####################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution on 06/21/2017 18:07:52
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
source layout/TF.flowkit_settings.tcl

source layout/TF.invs_init.tcl

# Reading metrics file
######################
read_metric -id current layout/TF.metrics.json 



# Mode Setup
###########################################################
source layout/TF.mode
eval_enc { set edi_pe::pegConsiderMacroLayersUnblocked 1 }
