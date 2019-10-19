#/bin/bash

#git reset HEAD^ --soft

#module load modelsim
#vsim&
vcom -cover scebx *_lib.vhd
vcom -cover scebx *.vhd
vsim -coverage -novopt work.i8051_tsb
coverage report -file report.txt -byfile -assert -directive -cvg -codeAll
vcd file i8051.vcd
vcd add -r /\*
run 100 ms
vcd checkpoint

#echo "END CMD.SH"
