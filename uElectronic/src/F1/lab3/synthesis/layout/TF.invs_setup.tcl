#####################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution on 11/30/2016 18:19:23
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
