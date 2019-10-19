vlib work
vmap work work
vcom -cover scebx tran_reg.vhd sel_reg.vhd addr_dec.vhd counter.vhd pif2wb.vhd top_tb.vhd tb_pif2wb.vhd
vsim -coverage work.test_bridge
vcd file pif2wb.vcd
vcd add -r /\*
run 10 ms
coverage report -file pif2wb_report.txt -byfile -assert -directive -cvg -codeAll
vcd checkpoint
exit -force
