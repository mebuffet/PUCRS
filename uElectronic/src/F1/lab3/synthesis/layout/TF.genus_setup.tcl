#####################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 16.10-p006_1
#   on 11/30/2016 18:19:23
#
# This file can only be run in Genus Common UI mode.
#
#####################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 16.10-p006_1


# Remove Existing Design
###########################################################
if {[::legacy::find -design design:TF] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  delete_obj design:TF
}


# Source INIT Setup file
########################################################
source layout/TF.genus_init.tcl
read_metric -id current layout/TF.metrics.json

source layout/TF.g
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
set _slk_ [::legacy::get_attribute slack design:TF]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "inf"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack: inf,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
# tns
set _tns_ [::legacy::get_attribute tns design:TF]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "0"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden tns: 0,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [::legacy::get_attribute cell_area design:TF]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "14"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden cell area: 14,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [::legacy::get_attribute net_area design:TF]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "14"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden net area: 14,  current net area: $_net_area_"
}
unset _net_area_
