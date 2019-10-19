#####################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 16.10-p006_1
#   on 11/28/2017 01:05:01
#
# This file can only be run in Genus Common UI mode.
#
#####################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 16.10-p006_1


# Remove Existing Design
###########################################################
if {[::legacy::find -design design:PIF2WB] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  delete_obj design:PIF2WB
}


# Source INIT Setup file
########################################################
source /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl/PIF2WB.genus_init.tcl
read_metric -id current /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl/PIF2WB.metrics.json

source /home/vlsi2_g05/VLSI2/pif2wb/src/PIF2WB.pos_rtl/PIF2WB.g.gz
puts "\n** Restoration Completed **\n"


# Data Integrity Check
###########################################################
# program version
if {"[string_representation [::legacy::get_attribute program_version /]]" != "16.10-p006_1"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden program_version: 16.10-p006_1  current program_version: [string_representation [::legacy::get_attribute program_version /]]"
}
# license
if {"[string_representation [::legacy::get_attribute startup_license /]]" != "Genus_Synthesis"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden license: Genus_Synthesis  current license: [string_representation [::legacy::get_attribute startup_license /]]"
}
# slack
set _slk_ [::legacy::get_attribute slack design:PIF2WB]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "3488.3"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack: 3488.3,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
if {"[string_representation [::legacy::get_attribute slack_by_mode design:PIF2WB]]" != "{{mode:PIF2WB/view_NOMINAL 3488.3}}"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack_by_mode: {{mode:PIF2WB/view_NOMINAL 3488.3}}  current slack_by_mode: [string_representation [::legacy::get_attribute slack_by_mode design:PIF2WB]]"
}
# tns
set _tns_ [::legacy::get_attribute tns design:PIF2WB]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "0"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden tns: 0,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [::legacy::get_attribute cell_area design:PIF2WB]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "1411"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden cell area: 1411,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [::legacy::get_attribute net_area design:PIF2WB]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "712"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden net area: 712,  current net area: $_net_area_"
}
unset _net_area_
