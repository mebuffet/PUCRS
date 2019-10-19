#####################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution on 09/06/2016 16:51:33
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
source layout/anel.flowkit_settings.tcl

source layout/anel.invs_init.tcl
update_constraint_mode -name default_emulate_constraint_mode -sdc_files {layout/anel.default_emulate_constraint_mode.sdc layout/anel.loopbreaker.sdc}

# Reading metrics file
######################
read_metric -id current layout/anel.metrics.json 



# Mode Setup
###########################################################
source layout/anel.mode
