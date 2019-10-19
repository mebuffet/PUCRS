include settings_rtl.tcl

set_db lib_search_path $library_path
set_db script_search_path $project_path
set_db init_hdl_search_path $project_path
set_db library $library
set_db lef_library $lef
set_db cap_table_file $cap_table

read_hdl -vhdl $file_list
read_mmmc $mmmc
