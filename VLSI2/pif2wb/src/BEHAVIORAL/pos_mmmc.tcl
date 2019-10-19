elaborate $top_module
read_physical -lef $lef
init_design

foreach analysis $analysis_list {
   foreach effort $efforts {
        set_analysis_view -setup $analysis

        ## Sintetizar para portas lógicas genéricas (NAND, NOR, NOT, ETC...)
        set_db syn_generic_effort $effort
        syn_generic

        ## Sintetizar para portas lógicas da biblioteca previamente definida
        set_db syn_map_effort $effort
        syn_map

        ## Salvar os resultados
        ## Consumo de energia
        report power > ${project_path}/${top_module}.pos_rtl/report_power.rpt

        ## Slack time (janela de clock)
        report timing > ${project_path}/${top_module}.pos_rtl/report_timing.rpt

        ## Área utilizada pelo design sintetizado
        report area > ${project_path}/${top_module}.pos_rtl/report_area.rpt

        report gates > ${project_path}/${top_module}.pos_rtl/report_gates.rpt

        ## VHDL mapeado para as células da biblioteca
        write_hdl -mapped $top_module > ${project_path}/${top_module}.pos_rtl/${top_module}.post_rtl.v

        ## Arquivo SDF (Standard Delay Format), utilizado para síntese física
        write_sdf -design $top_module > ${project_path}/${top_module}.pos_rtl/timing_post_rtl.sdf

        ## Arquivo de Constraints pós síntese lógica
        write_sdc -view $analysis > ${project_path}/${top_module}.pos_rtl/contraints_post_rtl.sdc

        ## Salvar diversos arquivos utilizados na síntese física, incluíndo Constraints e o arquivo de Configuração.
        write_snapshot -innovus -outdir $project_path -tag ${top_module}.pos_rtl
	#write_snapshot -innovus -outdir $project_path -tag ${top_module}.pos_rtl
    }
}

exit
