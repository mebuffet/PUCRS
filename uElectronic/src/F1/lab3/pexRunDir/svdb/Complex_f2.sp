* SPICE NETLIST
***************************************

.SUBCKT LDDN D G S B
.ENDS
***************************************
.SUBCKT pdr25 d g s sb sub
.ENDS
***************************************
.SUBCKT pdr18 d g s sb sub
.ENDS
***************************************
.SUBCKT cfrm1m5shz a_po b_od shod shpo sub
.ENDS
***************************************
.SUBCKT cfrm1m5shznosub a_po b_od shod shpo
.ENDS
***************************************
.SUBCKT pdr25hv d g s sb sub
.ENDS
***************************************
.SUBCKT next18hvi d g s sb siso sub
.ENDS
***************************************
.SUBCKT pext18hv d g s sb sub
.ENDS
***************************************
.SUBCKT next25hvi d g s sb siso sub
.ENDS
***************************************
.SUBCKT pext25hv d g s sb sub
.ENDS
***************************************
.SUBCKT LDD D G S B
.ENDS
***************************************
.SUBCKT cpo25nw_var in out sub
.ENDS
***************************************
.SUBCKT cpo12nw_var in out sub
.ENDS
***************************************
.SUBCKT cpo18nw_var in out sub
.ENDS
***************************************
.SUBCKT cpo18nw_atto in1 in2 out1 sub
.ENDS
***************************************
.SUBCKT cpo18nw_diff_var in1 in2 out1 sub
.ENDS
***************************************
.SUBCKT cpo12nw_diff_var in1 in2 out1 sub
.ENDS
***************************************
.SUBCKT cpo25pw_var in nwell out sub
.ENDS
***************************************
.SUBCKT cpo18pw_var in nwell out sub
.ENDS
***************************************
.SUBCKT dnsvtlp_var in out sub
.ENDS
***************************************
.SUBCKT inddif_lanw_7m4x0y2z in mp out sub
.ENDS
***************************************
.SUBCKT inddif_nw_7m4x0y2z in mp out sub
.ENDS
***************************************
.SUBCKT indsym_lanw_7m4x0y2z in out sub
.ENDS
***************************************
.SUBCKT indsym_nw_7m4x0y2z in out sub
.ENDS
***************************************
.SUBCKT ind_stdnw_7m4x0y2z in out sub
.ENDS
***************************************
.SUBCKT ind_lonw_7m4x0y2z in out sub
.ENDS
***************************************
.SUBCKT inddif_lonw_7m4x0y2z in mp out sub
.ENDS
***************************************
.SUBCKT inddif_lomf_7m4x0y2z in mp out sub
.ENDS
***************************************
.SUBCKT inddif_mf_7m4x0y2z in mp out sub
.ENDS
***************************************
.SUBCKT ind_lomf_7m4x0y2z in out sub
.ENDS
***************************************
.SUBCKT indsym_mf_7m4x0y2z in out sub
.ENDS
***************************************
.SUBCKT cfrstack_rf_7m4x0y2z minus plus psub
.ENDS
***************************************
.SUBCKT cfrstack_rf_7m4x0y2z_sh minus plus psub shap
.ENDS
***************************************
.SUBCKT cfrstack_rf_7m4x0y2z_2p minus plus
.ENDS
***************************************
.SUBCKT box8 box8p1 box8p2 box8p3 box8p4 box8p5 box8p6 box8p7 box8sub
.ENDS
***************************************
.SUBCKT box7 box7p1 box7p2 box7p3 box7p4 box7p5 box7p6 box7sub
.ENDS
***************************************
.SUBCKT box6 box6p1 box6p2 box6p3 box6p4 box6p5 box6sub
.ENDS
***************************************
.SUBCKT box5 box5p1 box5p2 box5p3 box5p4 box5sub
.ENDS
***************************************
.SUBCKT box4 box4p1 box4p2 box4p3 box4sub
.ENDS
***************************************
.SUBCKT box3 box3p1 box3p2 box3sub
.ENDS
***************************************
.SUBCKT Complex_f2 A B C D S gnd! vdd!
** N=26 EP=7 IP=0 FDC=9
M0 vdd! A S vdd! PSVTGP L=0.06 W=0.4 $X=376 $Y=-1215 $D=94
M1 S B vdd! vdd! PSVTGP L=0.06 W=0.4 $X=796 $Y=-1215 $D=94
M2 26 C S vdd! PSVTGP L=0.06 W=0.4 $X=1216 $Y=-1215 $D=94
M3 vdd! D 26 vdd! PSVTGP L=0.06 W=0.4 $X=1636 $Y=-1215 $D=94
M4 25 A S gnd! NSVTGP L=0.06 W=0.2 $X=377 $Y=-2185 $D=29
M5 7 B 25 gnd! NSVTGP L=0.06 W=0.2 $X=797 $Y=-2185 $D=29
M6 gnd! C 7 gnd! NSVTGP L=0.06 W=0.2 $X=1217 $Y=-2185 $D=29
M7 7 D gnd! gnd! NSVTGP L=0.06 W=0.2 $X=1637 $Y=-2185 $D=29
D8 gnd! vdd! DNWPS $X=-150 $Y=-1500 $D=19
.ENDS
***************************************
