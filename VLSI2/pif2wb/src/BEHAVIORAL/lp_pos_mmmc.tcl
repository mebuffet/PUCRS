## LOWPOWER
set_db lp_insert_discrete_clock_gating_logic true
set_db lp_insert_clock_gating true

elaborate $top_module
init_design

## Sintetizar para portas lógicas genéricas (NAND, NOR, NOT, ETC...)
set_db syn_generic_effort $lp_effort
syn_generic

## Sintetizar para portas lógicas da biblioteca previamente definida
set_db syn_map_effort $lp_effort
syn_map

## Salvar os resultados
## Consumo de energia
report power > genus/logic/${lp_analysis}_LOWPOWER/$lp_effort/report_power.txt

## Slack time (janela de clock)
report timing > genus/logic/${lp_analysis}_LOWPOWER/$lp_effort/report_timing.txt

## Área utilizada pelo design sintetizado
report area > genus/logic/${lp_analysis}_LOWPOWER/$lp_effort/report_area.txt

report gates > genus/logic/${lp_analysis}_LOWPOWER/$lp_effort/report_gates.txt

report clock_gating > genus/logic/${lp_analysis}_LOWPOWER/$lp_effort/report_clock_gating.txt

## VHDL mapeado para as células da biblioteca
write_hdl -mapped $top_module > genus/logic/${lp_analysis}_LOWPOWER/$lp_effort/${top_module}.post_rtl.v

## Arquivo SDF (Standard Delay Format), utilizado para síntese física
write_sdf -design $top_module > genus/logic/${lp_analysis}_LOWPOWER/$lp_effort/timing_post_rtl.sdf

## Arquivo de Constraints pós síntese lógica
write_sdc -view $lp_analysis > genus/logic/${lp_analysis}_LOWPOWER/$lp_effort/contraints_post_rtl.sdc

## Salvar diversos arquivos utilizados na síntese física, incluíndo Constraints e o arquivo de Configuração.
write_snapshot -innovus -outdir genus/snapshot/${lp_analysis}_LOWPOWER/$lp_effort/$top_module -tag ${top_module}.pos_rtl

#exit
