**** Altos spice deck for characterization release 15.1.0.503
***            pin  opin_dir  related  related_dir  timing_type  table_type  when
*** Info_arc:  -  -  -  -  combinational  leakage_power  (!A * Z)
** NET-MAP BEGIN for inv_0
** NET-MAP END

* begin of instance section for inv_0
MXM0.m1_0 Z A gnd! gnd! inv:XM0:nsvtgp:m1:nsvtgp L=6e-08 W=2e-07 AS=4.34e-14 AD=4.34e-14 PS=6.34e-07 PD=6.34e-07 NRS=0 NRD=0 NF=1 SCA=0 SCB=0 SCC=0 m=1 
MXM1.m1_0 Z A vdd! vdd! inv:XM1:psvtgp:m1:psvtgp L=6e-08 W=4e-07 AS=8.64e-14 AD=8.64e-14 PS=8.32e-07 PD=8.32e-07 NRS=0 NRD=0 NF=1 SCA=0 SCB=0 SCC=0 m=1 
*RC for wire 0
*RC for wire A
C0_0 gnd! A 1.25955e-16
C1_0 vdd! A 6.85438e-17
C2_0 Z A 9.12318e-17
*RC for wire GND
*RC for wire gnd!
C3_0 gnd! vdd! 4.40919e-17
C4_0 gnd! Z 8.15517e-17
*RC for wire VDD
*RC for wire vdd!
C5_0 vdd! Z 7.45438e-17
*RC for wire VSS
*RC for wire Z

* end of instance section for inv_0
Vgnd! gnd! 0 0
Vvdd! vdd! 0 1

.model inv:XM0:nsvtgp:m1:nsvtgp.1 nmos level=54 version=4.5 a0=5.4774000e+00 a1=-2.3530000e-01
+  a2=5.7572000e-01 acde=1.2049000e-01 acnqsmod=0 agidl=7.4346000e-05 ags=1.0732000e+00
+  aigbacc=4.1529000e-03 aigbinv=1.2458000e-02 aigc=1.2887000e-02 aigsd=9.0628000e-03 alpha0=4.7880000e-13
+  alpha1=-1.3274000e-06 at=5.6636000e-04 b0=-2.8346000e-08 b1=0.0000000e+00 beta0=4.6585000e+00
+  bgidl=1.3543000e+10 bigbacc=-1.7922000e-01 bigbinv=2.1300000e-03 bigc=3.6307000e-03 bigsd=3.7291000e-04
+  binunit=1 bvd=1.0000000e+01 bvs=1.0000000e+01 capmod=2 cdsc=4.3000000e+00
+  cdscb=1.0000000e+00 cdscd=1.5000000e-01 cf=1.3938625e-10 cgbo=1.0273147e-10 cgdl=8.1666667e-11
+  cgdo=1.0000000e-13 cgidl=5.0000000e-01 cgsl=8.1666667e-11 cgso=1.0000000e-13 cigbacc=-4.7164000e+00
+  cigbinv=3.4579000e-01 cigc=1.4840000e-01 cigsd=-4.1180000e-02 cit=0.0000000e+00 cjd=1.3154000e-03
+  cjs=1.3154000e-03 cjswd=2.6290000e-11 cjswgd=2.4124850e-10 cjswgs=2.4124850e-10 cjsws=2.6290000e-11
+  ckappad=2.3472000e+00 ckappas=2.3472000e+00 clc=0.0000000e+00 cle=1.0000000e+00 delta=3.3000000e-02
+  diomod=1 dlc=9.5000000e-09 dlcig=6.0891000e-11 dmcg=0.0000000e+00 dmcgt=0.0000000e+00
+  dmci=0.0000000e+00 dmdg=0.0000000e+00 drout=3.4922000e+02 dsub=8.0000000e-01 dvt0=9.0000000e+03
+  dvt0w=3.8547000e-06 dvt1=1.0500000e+00 dvt1w=3.9461000e+03 dvt2=7.0000000e-02 dvt2w=-2.0000000e-01
+  dvtp0=0.0000000e+00 dvtp1=0.0000000e+00 dwb=3.5632000e-09 dwc=-1.3000000e-08 dwg=2.4258000e-09
+  dwj=-1.2837000e-08 ef=1.0000000e+00 egidl=-1.4512000e+00 eigbinv=1.5337000e-03 em=0.0000000e+00
+  epsrox=3.9000000e+00 eta0=1.0000000e-05 etab=-1.1000000e+01 eu=1.8025000e+00 fnoimod=1
+  fprout=8.7013000e+02 gbmin=1.0000000e-12 geomod=0 igbmod=1 igcmod=1
+  ijthdfwd=1.0000000e-01 ijthdrev=1.0000000e-01 ijthsfwd=1.0000000e-01 ijthsrev=1.0000000e-01 jsd=3.3261000e-07
+  jss=3.3261000e-07 jswd=1.1200000e-13 jswgd=2.7698000e-14 jswgs=2.7698000e-14 jsws=1.1200000e-13
+  jtsd=1.0010000e-18 jtss=1.0010000e-18 jtsswd=3.2373000e-11 jtsswgd=1.3649000e-08 jtsswgs=1.3649000e-08
+  jtssws=3.2373000e-11 k1=3.4329136e-01 k2=-7.6523696e-02 k2we=3.4993106e-03 k3=4.4202702e+00
+  k3b=-2.1739130e-01 keta=2.0000000e-02 kt1=-1.0644000e-01 kt1l=2.0181000e-09 kt2=-1.5319000e-02
+  ku0we=-3.8789631e-03 kvth0we=1.4781124e-03 lags=2.0000000e-01 laigsd=-2.5469000e-05 lbeta0=-4.4007000e-01
+  lbigbacc=-9.0000000e-03 leta0=3.4000000e+00 lint=-3.1000000e-08 lintnoi=-2.0000000e-08 lk2=0.0000000e+00
+  lk2we=0.0000000e+00 lk3=0.0000000e+00 lk3b=0.0000000e+00 lketa=-3.0000000e-03 lkt2=-6.0000000e-03
+  lku0we=0.0000000e+00 lkvth0we=0.0000000e+00 ll=0.0000000e+00 llc=0.0000000e+00 lln=1.0000000e+00
+  llpe0=0.0000000e+00 lmax=1.8000000e-07 lmin=6.0000000e-08 lminv=1.0000000e-02 lnfactor=0.0000000e+00
+  lnoff=5.0000000e-02 lpe0=4.6608696e-08 lpeb=0.0000000e+00 lrdsw=0.0000000e+00 lua=-4.4822000e-18
+  lvoffcv=-2.0373000e-03 lvsat=0.0000000e+00 lw=0.0000000e+00 lwc=0.0000000e+00 lwl=0.0000000e+00
+  lwlc=0.0000000e+00 lwn=1.0000000e+00 minv=-3.5986000e-01 mjd=3.1051000e-01 mjs=3.1051000e-01
+  mjswd=3.0000000e-01 mjswgd=9.8000000e-01 mjswgs=9.8000000e-01 mjsws=3.0000000e-01 mobmod=2
+  moin=6.0874224e+00 ndep=8.9277000e+17 nfactor=2.0948561e+00 ngate=5.4944000e+20 ngcon=1.0000000e+00
+  nigbacc=2.2094000e+00 nigbinv=1.7608000e+01 nigc=2.3889000e+00 njd=1.0580000e+00 njs=1.0580000e+00
+  njts=1.5481000e+01 njtssw=5.0365000e+01 njtsswg=7.4784000e+00 noff=2.2028000e+00 noia=6.0000000e+42
+  noib=0.0000000e+00 noic=0.0000000e+00 nsd=1.0000000e+20 ntnoi=3.3823529e+00 ntox=2.2500000e+01
+  pbd=8.7960000e-01 pbs=8.7960000e-01 pbswd=2.0000000e+00 pbswgd=9.3913000e-01 pbswgs=9.3913000e-01
+  pbsws=2.0000000e+00 pclm=2.8388000e-01 pdiblc1=1.0809000e-18 pdiblc2=1.0010000e-18 pdiblcb=0.0000000e+00
+  pdits=3.3116000e+00 pditsd=3.5769000e-02 pditsl=2.5131000e+08 permod=0 phin=1.7968000e-01
+  pigcd=4.6158000e+00 poxedge=9.9802000e-01 prdsw=0.0000000e+00 prt=0.0000000e+00 prwb=0.0000000e+00
+  prwg=0.0000000e+00 pscbe1=8.0000000e+18 pscbe2=1.0000000e-15 pua=8.3147000e-20 pvag=8.3884000e-02
+  pvoff=3.0000000e-04 rbdb=5.0000000e+01 rbodymod=0 rbpb=5.0000000e+01 rbpd=5.0000000e+01
+  rbps=1.5000000e+01 rbsb=5.0000000e+01 rdsmod=0 rdsw=1.8705233e+02 rdswmin=0.0000000e+00
+  rgatemod=0 rsh=1.2000000e+01 rshg=4.8761042e+02 scref=1.0000000e-06 tcj=7.6192000e-04
+  tcjsw=1.3466000e-04 tcjswg=1.4712000e-03 tempmod=1 tnjts=1.0000000e-02 tnjtssw=0.0000000e+00
+  tnjtsswg=1.4135000e+00 tnoimod=0 tnom=2.5000000e+01 toxe=1.8800000e-09 toxm=1.8800000e-09
+  toxp=1.8800000e-09 toxref=1.8800000e-09 tpb=1.6195000e-03 tpbsw=3.1539000e-03 tpbswg=1.0000000e-03
+  trnqsmod=0 u0=8.9018411e+02 ua=5.8010000e-17 ua1=-3.4747000e-15 uc=-8.3017000e-18
+  uc1=9.9900000e-16 ud=0.0000000e+00 up=0.0000000e+00 ute=-1.3424000e+00 voff=-1.3605000e-01
+  voffcv=-8.5024000e-02 voffl=-6.0000000e-09 vsat=2.4222920e+05 vth0=2.6761191e-01 vtsd=2.0000000e+01
+  vtss=2.0000000e+01 vtsswd=1.9082000e+01 vtsswgd=1.3870000e+00 vtsswgs=1.3870000e+00 vtssws=1.9082000e+01
+  w0=1.0000000e-09 wcdsc=-1.0000000e+00 wcdscb=-4.0000000e-01 web=-3.5000000e+02 wec=-3.0000000e+03
+  weta0=-2.0000000e+00 wetab=4.0000000e-01 wint=-6.0000000e-09 wk2we=0.0000000e+00 wku0we=0.0000000e+00
+  wkvth0we=0.0000000e+00 wl=0.0000000e+00 wlc=0.0000000e+00 wln=1.0000000e+00 wmax=1.0000000e-03
+  wmin=1.2000000e-07 wpemod=1.0000000e+00 wr=1.0000000e+00 wvsat=0.0000000e+00 ww=0.0000000e+00
+  wwc=0.0000000e+00 wwl=0.0000000e+00 wwlc=0.0000000e+00 wwn=1.0000000e+00 xgl=0.0000000e+00
+  xgw=0.0000000e+00 xj=5.0000000e-08 xjbvd=1.0000000e+00 xjbvs=1.0000000e+00 xl=-7.0000000e-09
+  xpart=0.0000000e+00 xrcrg1=1.2000000e+01 xrcrg2=1.0000000e+00 xtid=0.0000000e+00 xtis=0.0000000e+00
+  xtsd=1.0000000e-02 xtss=1.0000000e-02 xtsswd=4.8622000e-01 xtsswgd=2.1785000e-01 xtsswgs=2.1785000e-01
+  xtssws=4.8622000e-01 xw=0.0000000e+00

.model inv:XM1:psvtgp:m1:psvtgp.1 pmos level=54 version=4.5 a0=3.9999000e+00 a1=4.4999000e-01
+  a2=8.1979000e-01 acde=1.0000000e-01 acnqsmod=0 agidl=5.7016000e-03 ags=1.0730000e+00
+  aigbacc=1.4106000e-02 aigbinv=1.3111000e-02 aigc=8.2077000e-03 aigsd=6.8013000e-03 alpha0=3.6287000e-14
+  alpha1=-4.2296000e-07 at=8.0000000e-04 b0=0.0000000e+00 b1=0.0000000e+00 beta0=2.7545000e+00
+  bgidl=2.8015000e+10 bigbacc=1.1156000e-02 bigbinv=9.2342000e-04 bigc=1.2116000e-03 bigsd=5.6564000e-04
+  binunit=1 bvd=1.0000000e+01 bvs=1.0000000e+01 capmod=2 cdsc=5.0000000e-01
+  cdscb=2.8791000e-08 cdscd=1.8357000e-01 cf=1.1428181e-10 cgbo=1.2721500e-10 cgdl=1.1697842e-10
+  cgdo=1.0000000e-13 cgidl=5.0000000e-01 cgsl=1.1697842e-10 cgso=1.0000000e-13 cigbacc=3.0828000e-01
+  cigbinv=1.1239000e-05 cigc=6.2310000e-05 cigsd=8.2018000e-02 cit=0.0000000e+00 cjd=1.2507000e-03
+  cjs=1.2507000e-03 cjswd=3.5311000e-11 cjswgd=2.3243552e-10 cjswgs=2.3243552e-10 cjsws=3.5311000e-11
+  ckappad=3.6518000e-01 ckappas=3.3860000e-01 clc=0.0000000e+00 cle=1.0000000e+00 delta=2.2000000e-02
+  diomod=1 dlc=1.4500000e-08 dlcig=7.0556000e-09 dmcg=0.0000000e+00 dmcgt=0.0000000e+00
+  dmci=0.0000000e+00 dmdg=0.0000000e+00 drout=3.3132000e+00 dsub=2.7226000e-01 dvt0=6.9000000e+02
+  dvt0w=1.5000000e-01 dvt1=2.2350000e+00 dvt1w=2.9873000e+05 dvt2=1.4000000e-01 dvt2w=2.5000000e-01
+  dvtp0=0.0000000e+00 dvtp1=0.0000000e+00 dwb=-5.0000000e-09 dwc=-2.0000000e-08 dwg=-2.0244000e-09
+  dwj=-7.1359000e-09 ef=1.0000000e+00 egidl=-3.9124000e+00 eigbinv=9.1381000e-01 em=0.0000000e+00
+  epsrox=3.9000000e+00 eta0=3.5000000e-02 etab=-2.0000000e-02 eu=1.3705000e+00 fnoimod=1
+  fprout=8.1672000e-04 gbmin=1.0000000e-12 geomod=0 igbmod=1 igcmod=1
+  ijthdfwd=1.0000000e-01 ijthdrev=1.0000000e-01 ijthsfwd=1.0000000e-01 ijthsrev=1.0000000e-01 jsd=4.8411000e-08
+  jss=4.8411000e-08 jswd=1.0584000e-14 jswgd=2.9576000e-15 jswgs=2.9576000e-15 jsws=1.0584000e-14
+  jtsd=1.0447000e-06 jtss=1.0447000e-06 jtsswd=4.0818000e-11 jtsswgd=1.8250000e-09 jtsswgs=1.8250000e-09
+  jtssws=4.0818000e-11 k1=2.8086890e-01 k2=-6.1544545e-02 k2we=2.3365353e-03 k3=2.6552993e+01
+  k3b=7.0000000e+00 keta=2.2362000e-02 kt1=-1.4580000e-01 kt1l=-1.8000000e-09 kt2=-3.3822000e-02
+  ku0we=-1.2561345e-02 kvth0we=-3.3054994e-03 la0=-3.5396000e-02 lags=3.0679000e-01 laigsd=1.5000000e-05
+  lbigc=2.4297000e-05 ldelta=1.0000000e-03 lint=6.0000000e-09 lk2=0.0000000e+00 lk2we=0.0000000e+00
+  lk3=0.0000000e+00 lketa=-3.5913134e-03 lkt2=-2.0000000e-03 lku0we=0.0000000e+00 lkvth0we=0.0000000e+00
+  ll=0.0000000e+00 llc=-7.0000000e-17 lln=1.0000000e+00 lmax=1.8000000e-07 lmin=6.0000000e-08
+  lminv=-3.6629000e-03 lnfactor=0.0000000e+00 lnoff=1.0000000e-02 lpclm=-1.2020000e-03 lpditsd=4.1704000e-05
+  lpe0=2.4200000e-08 lpeb=0.0000000e+00 lua=5.1412000e-15 lute=3.2462000e-03 lvoffcv=-3.0000000e-04
+  lw=0.0000000e+00 lwc=0.0000000e+00 lwl=0.0000000e+00 lwlc=0.0000000e+00 lwn=1.0000000e+00
+  minv=-3.6139000e-01 mjd=3.0853000e-01 mjs=3.0853000e-01 mjswd=3.0000000e-01 mjswgd=9.8000000e-01
+  mjswgs=9.8000000e-01 mjsws=3.0000000e-01 mobmod=2 moin=5.7317465e+00 ndep=6.9446000e+17
+  nfactor=3.8885691e+00 ngate=5.2228000e+20 ngcon=1.0000000e+00 nigbacc=8.7487000e+00 nigbinv=1.9619000e+00
+  nigc=2.5958000e+00 njd=9.8000000e-01 njs=9.8000000e-01 njts=2.1166000e+01 njtssw=6.9475000e+01
+  njtsswg=8.4258000e+00 noff=2.2095000e+00 noia=5.0000000e+42 noib=0.0000000e+00 noic=5.0000000e+09
+  nsd=1.0000000e+20 ntnoi=1.5000000e+00 ntox=2.5700000e+01 pbd=7.2319000e-01 pbs=7.2319000e-01
+  pbswd=3.9779000e+00 pbswgd=5.9683000e-01 pbswgs=5.9683000e-01 pbsws=3.9779000e+00 pclm=5.0000000e+01
+  pdiblc1=1.0009000e-18 pdiblc2=1.0000000e-18 pdiblcb=-5.0000000e-01 pdits=2.5487000e-01 pditsd=1.0626000e+00
+  pditsl=3.8645000e+01 permod=0 phin=1.8000000e-01 pigcd=4.0228000e+00 pk3=0.0000000e+00
+  poxedge=9.8899000e-01 prdsw=0.0000000e+00 prt=0.0000000e+00 prwb=0.0000000e+00 prwg=0.0000000e+00
+  pscbe1=1.0000000e+18 pscbe2=1.0000000e-18 pvag=2.2392000e+02 pvoff=1.9688000e-04 pvoffcv=1.0961000e-04
+  pvsat=0.0000000e+00 rbdb=5.0000000e+01 rbodymod=0 rbpb=5.0000000e+01 rbpd=5.0000000e+01
+  rbps=1.5000000e+01 rbsb=5.0000000e+01 rdsmod=0 rdsw=3.6711554e+02 rdswmin=0.0000000e+00
+  rgatemod=0 rsh=1.5000000e+01 rshg=1.6474387e+02 scref=1.0000000e-06 tcj=8.7845000e-04
+  tcjsw=7.8546000e-05 tcjswg=2.3755000e-03 tempmod=1 tnjts=1.0000000e-02 tnjtssw=0.0000000e+00
+  tnjtsswg=0.0000000e+00 tnoimod=0 tnom=2.5000000e+01 toxe=1.8700000e-09 toxm=1.8700000e-09
+  toxp=1.8700000e-09 toxref=1.8700000e-09 tpb=1.6188000e-03 tpbsw=7.9620000e-05 tpbswg=1.0000000e-03
+  trnqsmod=0 u0=1.3887030e+02 ua=7.5723000e-13 ua1=-4.1289000e-04 uc=-1.2500000e-13
+  uc1=-7.7095000e-04 ud=0.0000000e+00 up=0.0000000e+00 ute=-1.1592000e+00 voff=-1.2896000e-01
+  voffcv=-8.8000000e-02 voffl=-3.6460000e-09 vsat=1.3744433e+05 vth0=-2.3730147e-01 vtsd=2.0270000e+00
+  vtss=2.0270000e+00 vtsswd=5.2230000e+01 vtsswgd=1.7054000e+00 vtsswgs=1.7054000e+00 vtssws=5.2230000e+01
+  w0=2.4962000e-07 waigsd=1.3000000e-04 wcdsc=-1.7000000e-01 wcdscb=-1.1998000e-01 web=-4.5000000e+02
+  wec=-3.0000000e+03 weta0=-2.2613000e-03 wetab=1.0000000e-02 wint=-2.1607000e-08 wk2we=0.0000000e+00
+  wku0we=0.0000000e+00 wkvth0we=0.0000000e+00 wl=0.0000000e+00 wlc=0.0000000e+00 wln=1.0000000e+00
+  wmax=1.0000000e-03 wmin=1.2000000e-07 wpclm=-2.0000000e+00 wpemod=1.0000000e+00 wr=1.0000000e+00
+  wua=1.2586000e-14 ww=0.0000000e+00 wwc=0.0000000e+00 wwl=0.0000000e+00 wwlc=0.0000000e+00
+  wwn=1.0000000e+00 xgl=0.0000000e+00 xgw=0.0000000e+00 xj=5.0000000e-08 xjbvd=1.0000000e+00
+  xjbvs=1.0000000e+00 xl=-4.0000000e-09 xpart=0.0000000e+00 xrcrg1=1.2000000e+01 xrcrg2=1.0000000e+00
+  xtid=0.0000000e+00 xtis=0.0000000e+00 xtsd=7.6583000e-01 xtss=7.6583000e-01 xtsswd=6.0297000e-01
+  xtsswgd=8.4132000e-02 xtsswgs=8.4132000e-02 xtssws=6.0297000e-01 xw=0.0000000e+00

* end of model section

.meas tran AltosLeakage000 FIND i(Vvdd!) AT=0
.meas tran AltosLeakage001 FIND i(Vgnd!) AT=0
.meas tran AltosLeakage002 FIND i(VA) AT=0

.temp 25
VA A 0  pwl(
+ 0 0.000)

.param Z_cap=1.0000000e-20
C6_0 Z 0 Z_cap

.nodeset v(Z) 1



.option accurate nomod numdgt=6 measdgt=6 ingold=2 measout=0 gmindc=1e-14 gmin=1e-14 pivtol=1e-15
.tran 1.00e-12 1e-12 

.end

* end of sim.sp
