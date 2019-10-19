import os
import subprocess

while True:
	choice = raw_input("modelsim [m-M], genus [g-G], innovus [i-I], parser[p-P], exit [x-X]: ")
	if choice in ["p","P"]:
		subprocess.call(r"./exec.sh",cwd=r"./parser/")
	elif choice in ["m","M"]:
		os.system("module load modelsim;vsim -do rtl_compile.do")
		os.system("rm -rf modelsim.* work/ transcript *.vcd *.txt *~")
	elif choice in ["g","G"]:
		#os.system("module load genus;genus -no_gui -batch -abort_on_error -files pre_mmmc.tcl")
		os.system("module load genus;genus -no_gui -abort_on_error")
		os.system("rm -rf genus.* fv/ *~;mv final.rpt PIF2WB.pos_rtl")
	elif choice in ["i","I"]:
		#os.system("module load innovus;innovus -no_gui -batch -abort_on_error -files physical.tcl")
		os.system("module load innovus;innovus -common_ui -abort_on_error")
		os.system("rm -rf .cadence innovus.* *~ snapshot_img_floorplan.gif;mv -t PIF2WB.pos_physical timingReports *.gif")
	elif choice in ["x","X"]:
		print("Exiting...")
		break
	else:
		print("Please, enter a valid option...")

"""
    [-execute list_of_Tcl_commands]
    [-files in_file_list]
"""
