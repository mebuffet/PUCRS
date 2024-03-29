
// Generated by Cadence Genus(TM) Synthesis Solution 16.10-p006_1
// Generated on: Nov 28 2017 01:05:00

// Verification Directory fv/PIF2WB 

module PIF2WB(CLK, RST, PIReqVALID, PIReqCNTL, PIReqADRS, PIReqDATA,
     PIReqDataBE, POReqRDY, PORespVALID, PORespCNTL, PORespDATA,
     PIRespRDY, ACK_I, DAT_I, ERR_I, ADR_O, DAT_O, CYC_O, SEL_O, STB_O,
     WE_O, BTE_O, CTI_O);
  input CLK, RST, PIReqVALID, PIRespRDY, ACK_I, ERR_I;
  input [7:0] PIReqCNTL;
  input [31:0] PIReqADRS, PIReqDATA, DAT_I;
  input [3:0] PIReqDataBE;
  output POReqRDY, PORespVALID, CYC_O, STB_O, WE_O;
  output [7:0] PORespCNTL;
  output [31:0] PORespDATA, ADR_O, DAT_O;
  output [3:0] SEL_O;
  output [1:0] BTE_O;
  output [2:0] CTI_O;
  wire CLK, RST, PIReqVALID, PIRespRDY, ACK_I, ERR_I;
  wire [7:0] PIReqCNTL;
  wire [31:0] PIReqADRS, PIReqDATA, DAT_I;
  wire [3:0] PIReqDataBE;
  wire POReqRDY, PORespVALID, CYC_O, STB_O, WE_O;
  wire [7:0] PORespCNTL;
  wire [31:0] PORespDATA, ADR_O, DAT_O;
  wire [3:0] SEL_O;
  wire [1:0] BTE_O;
  wire [2:0] CTI_O;
  wire [2:0] state;
  wire [3:0] TOT_TRANSFER_I;
  wire [31:0] Counter_Burst_Transfer_plus_69_28;
  wire Counter_Burst_Transfer_add_69_28_n_635,
       Counter_Burst_Transfer_add_69_28_n_637,
       Counter_Burst_Transfer_add_69_28_n_639,
       Counter_Burst_Transfer_add_69_28_n_641,
       Counter_Burst_Transfer_add_69_28_n_643,
       Counter_Burst_Transfer_add_69_28_n_645,
       Counter_Burst_Transfer_add_69_28_n_647,
       Counter_Burst_Transfer_add_69_28_n_649;
  wire Counter_Burst_Transfer_add_69_28_n_651,
       Counter_Burst_Transfer_add_69_28_n_653,
       Counter_Burst_Transfer_add_69_28_n_655,
       Counter_Burst_Transfer_add_69_28_n_657,
       Counter_Burst_Transfer_add_69_28_n_659,
       Counter_Burst_Transfer_add_69_28_n_661,
       Counter_Burst_Transfer_add_69_28_n_663,
       Counter_Burst_Transfer_add_69_28_n_665;
  wire Counter_Burst_Transfer_add_69_28_n_667,
       Counter_Burst_Transfer_add_69_28_n_669,
       Counter_Burst_Transfer_add_69_28_n_671,
       Counter_Burst_Transfer_add_69_28_n_673,
       Counter_Burst_Transfer_add_69_28_n_675,
       Counter_Burst_Transfer_add_69_28_n_677,
       Counter_Burst_Transfer_add_69_28_n_679,
       Counter_Burst_Transfer_add_69_28_n_681;
  wire Counter_Burst_Transfer_add_69_28_n_683,
       Counter_Burst_Transfer_add_69_28_n_685,
       Counter_Burst_Transfer_add_69_28_n_687,
       Counter_Burst_Transfer_add_69_28_n_689,
       Counter_Burst_Transfer_n_421, \N_TRANSFER[0] , \N_TRANSFER[1] ,
       \N_TRANSFER[2] ;
  wire \N_TRANSFER[3] , \TOT_TRANSFER_O[0] , \TOT_TRANSFER_O[1] ,
       \TOT_TRANSFER_O[2] , \TOT_TRANSFER_O[3] , n_0, n_1, n_2;
  wire n_3, n_4, n_5, n_6, n_7, n_8, n_9, n_10;
  wire n_11, n_12, n_13, n_14, n_15, n_16, n_17, n_18;
  wire n_19, n_20, n_21, n_22, n_23, n_24, n_25, n_26;
  wire n_27, n_28, n_29, n_30, n_31, n_32, n_33, n_34;
  wire n_35, n_36, n_37, n_38, n_39, n_40, n_41, n_42;
  wire n_43, n_44, n_45, n_46, n_47, n_48, n_49, n_50;
  wire n_51, n_52, n_53, n_54, n_55, n_56, n_57, n_58;
  wire n_59, n_60, n_61, n_62, n_63, n_64, n_65, n_66;
  wire n_67, n_68, n_69, n_70, n_71, n_72, n_73, n_74;
  wire n_75, n_76, n_77, n_78, n_79, n_80, n_81, n_82;
  wire n_83, n_84, n_85, n_86, n_87, n_88, n_89, n_90;
  wire n_91, n_92, n_93, n_94, n_95, n_96, n_97, n_135;
  wire n_136, n_169, n_170, n_171, n_172, n_315;
  assign CTI_O[0] = CTI_O[2];
  assign BTE_O[0] = 1'b0;
  assign BTE_O[1] = 1'b0;
  assign PORespCNTL[1] = ERR_I;
  assign PORespCNTL[2] = ERR_I;
  assign PORespCNTL[3] = 1'b0;
  assign PORespCNTL[4] = 1'b0;
  assign PORespCNTL[5] = 1'b0;
  assign PORespCNTL[6] = 1'b0;
  assign PORespCNTL[7] = 1'b0;
  assign PORespVALID = ACK_I;
  assign POReqRDY = 1'b1;
  HS65_GS_IVX2 g939(.A (RST), .Z (n_97));
  HS65_GS_NAND2AX4 g1397(.A (CTI_O[2]), .B (n_92), .Z (PORespCNTL[0]));
  HS65_GS_BTHX10 g205(.A (PIReqDATA[22]), .E (n_78), .Z (DAT_O[22]));
  HS65_GS_BTHX10 g206(.A (PIReqDATA[21]), .E (n_96), .Z (DAT_O[21]));
  HS65_GS_BTHX10 g207(.A (PIReqDATA[20]), .E (n_78), .Z (DAT_O[20]));
  HS65_GS_BTHX10 g208(.A (PIReqDATA[19]), .E (n_78), .Z (DAT_O[19]));
  HS65_GS_BTHX10 g209(.A (PIReqDATA[18]), .E (n_96), .Z (DAT_O[18]));
  HS65_GS_BTHX10 g210(.A (PIReqDATA[17]), .E (n_78), .Z (DAT_O[17]));
  HS65_GS_BTHX10 g211(.A (PIReqDATA[16]), .E (n_96), .Z (DAT_O[16]));
  HS65_GS_BTHX10 g212(.A (PIReqDATA[15]), .E (n_96), .Z (DAT_O[15]));
  HS65_GS_BTHX10 g190(.A (PIReqDATA[14]), .E (n_96), .Z (DAT_O[14]));
  HS65_GS_BTHX10 g191(.A (PIReqDATA[13]), .E (n_78), .Z (DAT_O[13]));
  HS65_GS_BTHX10 g193(.A (PIReqDATA[12]), .E (n_78), .Z (DAT_O[12]));
  HS65_GS_BTHX10 g194(.A (PIReqDATA[11]), .E (n_78), .Z (DAT_O[11]));
  HS65_GS_BTHX10 g195(.A (PIReqDATA[10]), .E (n_96), .Z (DAT_O[10]));
  HS65_GS_BTHX10 g196(.A (PIReqDATA[9]), .E (n_78), .Z (DAT_O[9]));
  HS65_GS_BTHX10 g197(.A (PIReqDATA[8]), .E (n_78), .Z (DAT_O[8]));
  HS65_GS_BTHX10 g213(.A (PIReqDATA[7]), .E (n_96), .Z (DAT_O[7]));
  HS65_GS_BTHX10 g199(.A (PIReqDATA[6]), .E (n_78), .Z (DAT_O[6]));
  HS65_GS_BTHX10 g181(.A (PIReqDATA[28]), .E (n_78), .Z (DAT_O[28]));
  HS65_GS_BTHX10 g201(.A (PIReqDATA[4]), .E (n_96), .Z (DAT_O[4]));
  HS65_GS_BTHX10 g202(.A (PIReqDATA[3]), .E (n_96), .Z (DAT_O[3]));
  HS65_GS_BTHX10 g214(.A (PIReqDATA[2]), .E (n_96), .Z (DAT_O[2]));
  HS65_GS_BTHX10 g215(.A (PIReqDATA[1]), .E (n_96), .Z (DAT_O[1]));
  HS65_GS_BTHX10 g216(.A (PIReqDATA[0]), .E (n_96), .Z (DAT_O[0]));
  HS65_GS_BTHX10 g203(.A (PIReqDATA[31]), .E (n_78), .Z (DAT_O[31]));
  HS65_GS_BTHX10 g176(.A (PIReqDATA[30]), .E (n_96), .Z (DAT_O[30]));
  HS65_GS_BTHX10 g179(.A (PIReqDATA[29]), .E (n_78), .Z (DAT_O[29]));
  HS65_GS_BTHX10 g200(.A (PIReqDATA[5]), .E (n_78), .Z (DAT_O[5]));
  HS65_GS_BTHX10 g182(.A (PIReqDATA[27]), .E (n_96), .Z (DAT_O[27]));
  HS65_GS_BTHX10 g187(.A (PIReqDATA[26]), .E (n_96), .Z (DAT_O[26]));
  HS65_GS_BTHX10 g188(.A (PIReqDATA[25]), .E (n_78), .Z (DAT_O[25]));
  HS65_GS_BTHX10 g189(.A (PIReqDATA[24]), .E (n_96), .Z (DAT_O[24]));
  HS65_GS_BTHX10 g204(.A (PIReqDATA[23]), .E (n_78), .Z (DAT_O[23]));
  HS65_GS_MUX21I1X3 g1398(.D0 (n_172), .D1 (n_315), .S0 (n_91), .Z
       (CYC_O));
  HS65_GS_MUX21X4 g1399(.D0 (n_90), .D1 (n_315), .S0 (n_136), .Z
       (WE_O));
  HS65_GS_NOR2X2 g1400(.A (n_95), .B (n_315), .Z (CTI_O[2]));
  HS65_GS_AND3ABCX9 g1401(.A (n_169), .B (n_172), .C (n_93), .Z (n_96));
  HS65_GS_NOR3X1 g1402(.A (n_135), .B (n_136), .C (n_93), .Z (n_95));
  HS65_GS_BTHX10 g230(.A (DAT_I[20]), .E (n_80), .Z (PORespDATA[20]));
  HS65_GS_BTHX10 g229(.A (DAT_I[21]), .E (n_94), .Z (PORespDATA[21]));
  HS65_GS_BTHX10 g231(.A (DAT_I[19]), .E (n_80), .Z (PORespDATA[19]));
  HS65_GS_BTHX10 g232(.A (DAT_I[18]), .E (n_80), .Z (PORespDATA[18]));
  HS65_GS_BTHX10 g233(.A (DAT_I[17]), .E (n_94), .Z (PORespDATA[17]));
  HS65_GS_BTHX10 g234(.A (DAT_I[16]), .E (n_80), .Z (PORespDATA[16]));
  HS65_GS_BTHX10 g235(.A (DAT_I[15]), .E (n_94), .Z (PORespDATA[15]));
  HS65_GS_BTHX10 g236(.A (DAT_I[14]), .E (n_94), .Z (PORespDATA[14]));
  HS65_GS_BTHX10 g217(.A (DAT_I[31]), .E (n_94), .Z (PORespDATA[31]));
  HS65_GS_BTHX10 g237(.A (DAT_I[13]), .E (n_80), .Z (PORespDATA[13]));
  HS65_GS_BTHX10 g238(.A (DAT_I[12]), .E (n_80), .Z (PORespDATA[12]));
  HS65_GS_BTHX10 g239(.A (DAT_I[11]), .E (n_80), .Z (PORespDATA[11]));
  HS65_GS_BTHX10 g240(.A (DAT_I[10]), .E (n_94), .Z (PORespDATA[10]));
  HS65_GS_BTHX10 g220(.A (DAT_I[30]), .E (n_80), .Z (PORespDATA[30]));
  HS65_GS_BTHX10 g242(.A (DAT_I[8]), .E (n_80), .Z (PORespDATA[8]));
  HS65_GS_BTHX10 g241(.A (DAT_I[9]), .E (n_94), .Z (PORespDATA[9]));
  HS65_GS_BTHX10 g243(.A (DAT_I[7]), .E (n_80), .Z (PORespDATA[7]));
  HS65_GS_BTHX10 g244(.A (DAT_I[6]), .E (n_80), .Z (PORespDATA[6]));
  HS65_GS_BTHX10 g245(.A (DAT_I[5]), .E (n_94), .Z (PORespDATA[5]));
  HS65_GS_BTHX10 g246(.A (DAT_I[4]), .E (n_94), .Z (PORespDATA[4]));
  HS65_GS_BTHX10 g247(.A (DAT_I[3]), .E (n_94), .Z (PORespDATA[3]));
  HS65_GS_BTHX10 g248(.A (DAT_I[2]), .E (n_94), .Z (PORespDATA[2]));
  HS65_GS_BTHX10 g221(.A (DAT_I[29]), .E (n_94), .Z (PORespDATA[29]));
  HS65_GS_BTHX10 g249(.A (DAT_I[1]), .E (n_80), .Z (PORespDATA[1]));
  HS65_GS_BTHX10 g250(.A (DAT_I[0]), .E (n_94), .Z (PORespDATA[0]));
  HS65_GS_BTHX10 g222(.A (DAT_I[28]), .E (n_80), .Z (PORespDATA[28]));
  HS65_GS_BTHX10 g224(.A (DAT_I[26]), .E (n_80), .Z (PORespDATA[26]));
  HS65_GS_BTHX10 g223(.A (DAT_I[27]), .E (n_94), .Z (PORespDATA[27]));
  HS65_GS_BTHX10 g225(.A (DAT_I[25]), .E (n_94), .Z (PORespDATA[25]));
  HS65_GS_BTHX10 g226(.A (DAT_I[24]), .E (n_80), .Z (PORespDATA[24]));
  HS65_GS_BTHX10 g227(.A (DAT_I[23]), .E (n_94), .Z (PORespDATA[23]));
  HS65_GS_BTHX10 g228(.A (DAT_I[22]), .E (n_80), .Z (PORespDATA[22]));
  HS65_GS_NOR2AX3 g1403(.A (n_92), .B (n_172), .Z (CTI_O[1]));
  HS65_GS_NAND4ABX6 g1404(.A (n_85), .B (n_87), .C (n_86), .D (n_84),
       .Z (n_315));
  HS65_GS_AND2ABX9 g1405(.A (n_88), .B (n_172), .Z (STB_O));
  HS65_GS_NOR2X13 g1406(.A (n_90), .B (n_172), .Z (n_94));
  HS65_GS_OR2X4 g1407(.A (n_171), .B (n_170), .Z (n_93));
  HS65_GS_AOI21X2 g1408(.A (state[1]), .B (state[0]), .C (n_169), .Z
       (n_92));
  HS65_GS_AOI21X2 g1409(.A (n_136), .B (n_171), .C (n_89), .Z (n_91));
  HS65_GS_IVX7 g1410(.A (Counter_Burst_Transfer_n_421), .Z (n_89));
  HS65_GS_BFX27 g1411(.A (n_88), .Z (Counter_Burst_Transfer_n_421));
  HS65_GS_NOR2X2 g1412(.A (n_83), .B (n_82), .Z (n_90));
  HS65_GS_AND2X4 g1413(.A (n_83), .B (state[1]), .Z (n_170));
  HS65_GS_NOR2AX3 g1414(.A (state[2]), .B (n_81), .Z (n_88));
  HS65_GS_NOR2AX3 g1415(.A (n_82), .B (state[2]), .Z (n_169));
  HS65_GS_NOR2AX3 g1416(.A (n_81), .B (state[2]), .Z (n_172));
  HS65_GSS_XOR2X6 g1417(.A (\TOT_TRANSFER_O[0] ), .B (\N_TRANSFER[0] ),
       .Z (n_87));
  HS65_GSS_XNOR2X6 g1418(.A (\N_TRANSFER[2] ), .B (\TOT_TRANSFER_O[2]
       ), .Z (n_86));
  HS65_GSS_XOR2X6 g1419(.A (\TOT_TRANSFER_O[1] ), .B (\N_TRANSFER[1] ),
       .Z (n_85));
  HS65_GSS_XNOR2X6 g1420(.A (\N_TRANSFER[3] ), .B (\TOT_TRANSFER_O[3]
       ), .Z (n_84));
  HS65_GS_AND2X4 g1421(.A (n_81), .B (state[2]), .Z (n_135));
  HS65_GS_NOR2X6 g1422(.A (state[0]), .B (state[2]), .Z (n_83));
  HS65_GS_NOR2AX3 g1423(.A (state[0]), .B (state[1]), .Z (n_82));
  HS65_GS_NOR2X6 g1424(.A (state[0]), .B (state[1]), .Z (n_81));
  HS65_GS_AND2X4 g1425(.A (state[2]), .B (state[0]), .Z (n_171));
  HS65_GS_AND2X4 g1426(.A (state[2]), .B (state[1]), .Z (n_136));
  HS65_GS_IVX9 drc_bufs1432(.A (n_79), .Z (n_80));
  HS65_GS_IVX9 drc_bufs1433(.A (n_94), .Z (n_79));
  HS65_GS_IVX9 drc_bufs1439(.A (n_77), .Z (n_78));
  HS65_GS_IVX9 drc_bufs1440(.A (n_96), .Z (n_77));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[0] (.RN (n_97),
       .CP (CLK), .D (n_53), .Q (ADR_O[0]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[1] (.RN (n_97),
       .CP (CLK), .D (n_54), .Q (ADR_O[1]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[2] (.RN (n_97),
       .CP (CLK), .D (n_48), .Q (ADR_O[2]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[3] (.RN (n_97),
       .CP (CLK), .D (n_45), .Q (ADR_O[3]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[4] (.RN (n_97),
       .CP (CLK), .D (n_41), .Q (ADR_O[4]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[5] (.RN (n_97),
       .CP (CLK), .D (n_37), .Q (ADR_O[5]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[6] (.RN (n_97),
       .CP (CLK), .D (n_38), .Q (ADR_O[6]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[7] (.RN (n_97),
       .CP (CLK), .D (n_36), .Q (ADR_O[7]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[8] (.RN (n_97),
       .CP (CLK), .D (n_35), .Q (ADR_O[8]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[9] (.RN (n_97),
       .CP (CLK), .D (n_34), .Q (ADR_O[9]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[10] (.RN (n_97),
       .CP (CLK), .D (n_33), .Q (ADR_O[10]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[11] (.RN (n_97),
       .CP (CLK), .D (n_31), .Q (ADR_O[11]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[12] (.RN (n_97),
       .CP (CLK), .D (n_30), .Q (ADR_O[12]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[13] (.RN (n_97),
       .CP (CLK), .D (n_29), .Q (ADR_O[13]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[14] (.RN (n_97),
       .CP (CLK), .D (n_28), .Q (ADR_O[14]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[15] (.RN (n_97),
       .CP (CLK), .D (n_27), .Q (ADR_O[15]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[16] (.RN (n_97),
       .CP (CLK), .D (n_26), .Q (ADR_O[16]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[17] (.RN (n_97),
       .CP (CLK), .D (n_25), .Q (ADR_O[17]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[18] (.RN (n_97),
       .CP (CLK), .D (n_24), .Q (ADR_O[18]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[19] (.RN (n_97),
       .CP (CLK), .D (n_23), .Q (ADR_O[19]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[20] (.RN (n_97),
       .CP (CLK), .D (n_32), .Q (ADR_O[20]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[21] (.RN (n_97),
       .CP (CLK), .D (n_52), .Q (ADR_O[21]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[22] (.RN (n_97),
       .CP (CLK), .D (n_51), .Q (ADR_O[22]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[23] (.RN (n_97),
       .CP (CLK), .D (n_50), .Q (ADR_O[23]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[24] (.RN (n_97),
       .CP (CLK), .D (n_49), .Q (ADR_O[24]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[25] (.RN (n_97),
       .CP (CLK), .D (n_47), .Q (ADR_O[25]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[26] (.RN (n_97),
       .CP (CLK), .D (n_46), .Q (ADR_O[26]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[27] (.RN (n_97),
       .CP (CLK), .D (n_44), .Q (ADR_O[27]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[28] (.RN (n_97),
       .CP (CLK), .D (n_56), .Q (ADR_O[28]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[29] (.RN (n_97),
       .CP (CLK), .D (n_55), .Q (ADR_O[29]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[30] (.RN (n_97),
       .CP (CLK), .D (n_40), .Q (ADR_O[30]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_ADR_REG_reg[31] (.RN (n_97),
       .CP (CLK), .D (n_39), .Q (ADR_O[31]));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_N_reg[0] (.RN (n_97), .CP
       (CLK), .D (n_43), .Q (\N_TRANSFER[0] ));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_N_reg[1] (.RN (n_97), .CP
       (CLK), .D (n_66), .Q (\N_TRANSFER[1] ));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_N_reg[2] (.RN (n_97), .CP
       (CLK), .D (n_74), .Q (\N_TRANSFER[2] ));
  HS65_GS_DFPRQX9 \Counter_Burst_Transfer_N_reg[3] (.RN (n_97), .CP
       (CLK), .D (n_76), .Q (\N_TRANSFER[3] ));
  HS65_GS_LDHQX9 \TOT_TRANSFER_I_reg[1] (.G (n_172), .D (n_18), .Q
       (TOT_TRANSFER_I[1]));
  HS65_GS_LDHQX9 \TOT_TRANSFER_I_reg[2] (.G (n_172), .D (PIReqCNTL[2]),
       .Q (TOT_TRANSFER_I[2]));
  HS65_GS_LDHQX9 \TOT_TRANSFER_I_reg[3] (.G (n_172), .D (n_8), .Q
       (TOT_TRANSFER_I[3]));
  HS65_GS_SDFPRQX9 \reg0_temp_reg[0] (.RN (n_97), .CP (CLK), .D
       (SEL_O[0]), .TI (PIReqDataBE[0]), .TE (n_172), .Q (SEL_O[0]));
  HS65_GS_SDFPRQX9 \reg0_temp_reg[1] (.RN (n_97), .CP (CLK), .D
       (SEL_O[1]), .TI (PIReqDataBE[1]), .TE (n_172), .Q (SEL_O[1]));
  HS65_GS_SDFPRQX9 \reg0_temp_reg[2] (.RN (n_97), .CP (CLK), .D
       (SEL_O[2]), .TI (PIReqDataBE[2]), .TE (n_172), .Q (SEL_O[2]));
  HS65_GS_SDFPRQX9 \reg0_temp_reg[3] (.RN (n_97), .CP (CLK), .D
       (SEL_O[3]), .TI (PIReqDataBE[3]), .TE (n_172), .Q (SEL_O[3]));
  HS65_GS_DFPRQX9 \reg1_temp_reg[0] (.RN (n_97), .CP (CLK), .D (n_16),
       .Q (\TOT_TRANSFER_O[0] ));
  HS65_GS_SDFPRQX9 \reg1_temp_reg[1] (.RN (n_97), .CP (CLK), .D
       (\TOT_TRANSFER_O[1] ), .TI (TOT_TRANSFER_I[1]), .TE (n_172), .Q
       (\TOT_TRANSFER_O[1] ));
  HS65_GS_SDFPRQX9 \reg1_temp_reg[2] (.RN (n_97), .CP (CLK), .D
       (\TOT_TRANSFER_O[2] ), .TI (TOT_TRANSFER_I[2]), .TE (n_172), .Q
       (\TOT_TRANSFER_O[2] ));
  HS65_GS_SDFPRQX9 \reg1_temp_reg[3] (.RN (n_97), .CP (CLK), .D
       (\TOT_TRANSFER_O[3] ), .TI (TOT_TRANSFER_I[3]), .TE (n_172), .Q
       (\TOT_TRANSFER_O[3] ));
  HS65_GSS_DFPRQX18 \state_reg[0] (.RN (n_97), .CP (CLK), .D (n_69), .Q
       (state[0]));
  HS65_GSS_DFPRQX18 \state_reg[1] (.RN (n_97), .CP (CLK), .D (n_72), .Q
       (state[1]));
  HS65_GSS_DFPRQX18 \state_reg[2] (.RN (n_97), .CP (CLK), .D (n_73), .Q
       (state[2]));
  HS65_GS_NOR2X6 g2329(.A (n_172), .B (n_75), .Z (n_76));
  HS65_GS_MUXI21X2 g2331(.D0 (\N_TRANSFER[3] ), .D1 (n_70), .S0 (n_2),
       .Z (n_75));
  HS65_GS_NOR2X6 g2334(.A (n_172), .B (n_71), .Z (n_74));
  HS65_GS_NAND4ABX3 g2335(.A (n_135), .B (n_42), .C (n_22), .D (n_63),
       .Z (n_73));
  HS65_GS_NAND3X5 g2336(.A (n_60), .B (n_22), .C (n_64), .Z (n_72));
  HS65_GS_MUXI21X2 g2338(.D0 (\N_TRANSFER[2] ), .D1 (n_68), .S0 (n_3),
       .Z (n_71));
  HS65_GSS_XOR2X6 g2339(.A (\N_TRANSFER[3] ), .B (n_67), .Z (n_70));
  HS65_GS_NAND2X7 g2341(.A (n_60), .B (n_65), .Z (n_69));
  HS65_GS_HA1X4 g2342(.A0 (\N_TRANSFER[2] ), .B0 (n_57), .CO (n_67),
       .S0 (n_68));
  HS65_GS_NOR2X6 g2343(.A (n_172), .B (n_61), .Z (n_66));
  HS65_GS_AOI212X4 g2344(.A (n_7), .B (n_59), .C (n_11), .D (n_169), .E
       (n_42), .Z (n_65));
  HS65_GS_AOI312X4 g2345(.A (n_6), .B (n_19), .C (n_315), .D (n_11), .E
       (n_170), .F (n_62), .Z (n_64));
  HS65_GS_AOI32X5 g2346(.A (PIReqCNTL[7]), .B (PIReqCNTL[4]), .C
       (n_59), .D (n_9), .E (n_12), .Z (n_63));
  HS65_GS_AO22X9 g2349(.A (n_20), .B (n_59), .C (n_10), .D (n_135), .Z
       (n_62));
  HS65_GS_MUXI21X2 g2350(.D0 (\N_TRANSFER[1] ), .D1 (n_58), .S0 (n_2),
       .Z (n_61));
  HS65_GS_HA1X4 g2385(.A0 (\N_TRANSFER[1] ), .B0 (\N_TRANSFER[0] ), .CO
       (n_57), .S0 (n_58));
  HS65_GS_AO222X4 g2386(.A (n_0), .B (ADR_O[28]), .C (n_3), .D
       (Counter_Burst_Transfer_plus_69_28[28]), .E (PIReqADRS[28]), .F
       (n_172), .Z (n_56));
  HS65_GS_AO222X4 g2387(.A (n_1), .B (ADR_O[29]), .C (n_2), .D
       (Counter_Burst_Transfer_plus_69_28[29]), .E (PIReqADRS[29]), .F
       (n_172), .Z (n_55));
  HS65_GS_AO22X9 g2388(.A (ADR_O[1]), .B (n_15), .C (PIReqADRS[1]), .D
       (n_172), .Z (n_54));
  HS65_GS_AO22X9 g2389(.A (ADR_O[0]), .B (n_15), .C (PIReqADRS[0]), .D
       (n_172), .Z (n_53));
  HS65_GS_AO222X4 g2390(.A (n_1), .B (ADR_O[21]), .C (n_2), .D
       (Counter_Burst_Transfer_plus_69_28[21]), .E (PIReqADRS[21]), .F
       (n_172), .Z (n_52));
  HS65_GS_AO222X4 g2391(.A (n_1), .B (ADR_O[22]), .C (PIReqADRS[22]),
       .D (n_172), .E (n_2), .F
       (Counter_Burst_Transfer_plus_69_28[22]), .Z (n_51));
  HS65_GS_AO222X4 g2392(.A (n_0), .B (ADR_O[23]), .C (n_2), .D
       (Counter_Burst_Transfer_plus_69_28[23]), .E (PIReqADRS[23]), .F
       (n_172), .Z (n_50));
  HS65_GS_AO222X4 g2393(.A (n_0), .B (ADR_O[24]), .C (PIReqADRS[24]),
       .D (n_172), .E (n_2), .F
       (Counter_Burst_Transfer_plus_69_28[24]), .Z (n_49));
  HS65_GS_AO212X4 g2394(.A (ADR_O[2]), .B (n_0), .C (PIReqADRS[2]), .D
       (n_172), .E (n_17), .Z (n_48));
  HS65_GS_AO222X4 g2395(.A (n_0), .B (ADR_O[25]), .C (n_3), .D
       (Counter_Burst_Transfer_plus_69_28[25]), .E (PIReqADRS[25]), .F
       (n_172), .Z (n_47));
  HS65_GS_AO222X4 g2396(.A (n_0), .B (ADR_O[26]), .C (PIReqADRS[26]),
       .D (n_172), .E (n_3), .F
       (Counter_Burst_Transfer_plus_69_28[26]), .Z (n_46));
  HS65_GS_AO222X4 g2397(.A (n_2), .B
       (Counter_Burst_Transfer_plus_69_28[3]), .C (ADR_O[3]), .D (n_0),
       .E (PIReqADRS[3]), .F (n_172), .Z (n_45));
  HS65_GS_AO222X4 g2398(.A (n_0), .B (ADR_O[27]), .C (n_2), .D
       (Counter_Burst_Transfer_plus_69_28[27]), .E (PIReqADRS[27]), .F
       (n_172), .Z (n_44));
  HS65_GS_NOR2X6 g2399(.A (n_172), .B (n_21), .Z (n_43));
  HS65_GS_NAND4ABX3 g2402(.A (state[2]), .B (n_10), .C (state[0]), .D
       (state[1]), .Z (n_60));
  HS65_GS_NOR3AX2 g2405(.A (PIReqVALID), .B (ACK_I), .C (n_13), .Z
       (n_59));
  HS65_GS_AO222X4 g2406(.A (n_172), .B (PIReqADRS[4]), .C (ADR_O[4]),
       .D (n_1), .E (Counter_Burst_Transfer_plus_69_28[4]), .F (n_2),
       .Z (n_41));
  HS65_GS_AO222X4 g2407(.A (n_0), .B (ADR_O[30]), .C (n_2), .D
       (Counter_Burst_Transfer_plus_69_28[30]), .E (PIReqADRS[30]), .F
       (n_172), .Z (n_40));
  HS65_GS_AO212X4 g2408(.A (n_2), .B
       (Counter_Burst_Transfer_plus_69_28[31]), .C (ADR_O[31]), .D
       (n_0), .E (n_14), .Z (n_39));
  HS65_GS_AO222X4 g2409(.A (Counter_Burst_Transfer_plus_69_28[6]), .B
       (n_3), .C (ADR_O[6]), .D (n_1), .E (PIReqADRS[6]), .F (n_172),
       .Z (n_38));
  HS65_GS_AO222X4 g2410(.A (n_3), .B
       (Counter_Burst_Transfer_plus_69_28[5]), .C (ADR_O[5]), .D (n_1),
       .E (PIReqADRS[5]), .F (n_172), .Z (n_37));
  HS65_GS_AO222X4 g2411(.A (n_172), .B (PIReqADRS[7]), .C (ADR_O[7]),
       .D (n_0), .E (n_2), .F (Counter_Burst_Transfer_plus_69_28[7]),
       .Z (n_36));
  HS65_GS_AO222X4 g2412(.A (n_1), .B (ADR_O[8]), .C (n_3), .D
       (Counter_Burst_Transfer_plus_69_28[8]), .E (PIReqADRS[8]), .F
       (n_172), .Z (n_35));
  HS65_GS_AO222X4 g2413(.A (n_0), .B (ADR_O[9]), .C (n_3), .D
       (Counter_Burst_Transfer_plus_69_28[9]), .E (PIReqADRS[9]), .F
       (n_172), .Z (n_34));
  HS65_GS_AO222X4 g2414(.A (n_0), .B (ADR_O[10]), .C (n_2), .D
       (Counter_Burst_Transfer_plus_69_28[10]), .E (PIReqADRS[10]), .F
       (n_172), .Z (n_33));
  HS65_GS_AO222X4 g2415(.A (n_1), .B (ADR_O[20]), .C (n_3), .D
       (Counter_Burst_Transfer_plus_69_28[20]), .E (PIReqADRS[20]), .F
       (n_172), .Z (n_32));
  HS65_GS_AO222X4 g2416(.A (n_0), .B (ADR_O[11]), .C (n_3), .D
       (Counter_Burst_Transfer_plus_69_28[11]), .E (PIReqADRS[11]), .F
       (n_172), .Z (n_31));
  HS65_GS_AO222X4 g2417(.A (n_1), .B (ADR_O[12]), .C (PIReqADRS[12]),
       .D (n_172), .E (n_3), .F
       (Counter_Burst_Transfer_plus_69_28[12]), .Z (n_30));
  HS65_GS_AO222X4 g2418(.A (n_1), .B (ADR_O[13]), .C (PIReqADRS[13]),
       .D (n_172), .E (n_2), .F
       (Counter_Burst_Transfer_plus_69_28[13]), .Z (n_29));
  HS65_GS_AO222X4 g2419(.A (n_0), .B (ADR_O[14]), .C (PIReqADRS[14]),
       .D (n_172), .E (n_3), .F
       (Counter_Burst_Transfer_plus_69_28[14]), .Z (n_28));
  HS65_GS_AO222X4 g2420(.A (n_0), .B (ADR_O[15]), .C (n_3), .D
       (Counter_Burst_Transfer_plus_69_28[15]), .E (PIReqADRS[15]), .F
       (n_172), .Z (n_27));
  HS65_GS_AO222X4 g2421(.A (n_1), .B (ADR_O[16]), .C (n_3), .D
       (Counter_Burst_Transfer_plus_69_28[16]), .E (PIReqADRS[16]), .F
       (n_172), .Z (n_26));
  HS65_GS_AO222X4 g2422(.A (n_1), .B (ADR_O[17]), .C (n_3), .D
       (Counter_Burst_Transfer_plus_69_28[17]), .E (PIReqADRS[17]), .F
       (n_172), .Z (n_25));
  HS65_GS_AO222X4 g2423(.A (n_1), .B (ADR_O[18]), .C (n_2), .D
       (Counter_Burst_Transfer_plus_69_28[18]), .E (PIReqADRS[18]), .F
       (n_172), .Z (n_24));
  HS65_GS_AO222X4 g2424(.A (n_1), .B (ADR_O[19]), .C (n_2), .D
       (Counter_Burst_Transfer_plus_69_28[19]), .E (PIReqADRS[19]), .F
       (n_172), .Z (n_23));
  HS65_GS_AO22X9 g2425(.A (ACK_I), .B (n_19), .C (n_10), .D (n_170), .Z
       (n_42));
  HS65_GSS_XNOR2X6 g2429(.A (\N_TRANSFER[0] ), .B (n_2), .Z (n_21));
  HS65_GSS_XOR2X3 g2430(.A (PIReqCNTL[4]), .B (PIReqCNTL[7]), .Z
       (n_20));
  HS65_GS_NAND2X7 g2431(.A (ACK_I), .B (n_12), .Z (n_22));
  HS65_GS_OR2X4 g2432(.A (PIReqCNTL[2]), .B (PIReqCNTL[1]), .Z (n_18));
  HS65_GS_NOR2X6 g2433(.A (ADR_O[2]), .B (n_5), .Z (n_17));
  HS65_GS_OR2X9 g2435(.A (\TOT_TRANSFER_O[0] ), .B (n_172), .Z (n_16));
  HS65_GS_NOR2AX3 g2436(.A (n_171), .B (state[1]), .Z (n_19));
  HS65_GS_IVX7 g2437(.A (n_13), .Z (n_14));
  HS65_GS_IVX9 g2438(.A (n_11), .Z (n_10));
  HS65_GS_NAND2AX7 g2439(.A (n_315), .B (PIReqCNTL[0]), .Z (n_9));
  HS65_GS_AND2X4 g2440(.A (PIReqCNTL[1]), .B (PIReqCNTL[2]), .Z (n_8));
  HS65_GS_NAND2X7 g2441(.A (n_5), .B (n_4), .Z (n_15));
  HS65_GS_NAND2X7 g2442(.A (PIReqADRS[31]), .B (n_172), .Z (n_13));
  HS65_GS_NOR2AX3 g2443(.A (n_136), .B (state[0]), .Z (n_12));
  HS65_GS_NAND2X2 g2444(.A (ACK_I), .B (PIRespRDY), .Z (n_11));
  HS65_GS_IVX9 g2448(.A (PIReqCNTL[4]), .Z (n_7));
  HS65_GS_IVX9 g2456(.A (ACK_I), .Z (n_6));
  HS65_GS_IVX9 drc_bufs2462(.A (n_5), .Z (n_3));
  HS65_GS_IVX9 drc_bufs2463(.A (n_5), .Z (n_2));
  HS65_GS_IVX9 drc_bufs2464(.A (Counter_Burst_Transfer_n_421), .Z
       (n_5));
  HS65_GS_IVX9 drc_bufs2469(.A (n_4), .Z (n_1));
  HS65_GS_IVX9 drc_bufs2470(.A (n_4), .Z (n_0));
  HS65_GS_IVX9 drc_bufs2471(.A (STB_O), .Z (n_4));
  HS65_GSS_XOR2X6 Counter_Burst_Transfer_add_69_28_g917(.A (ADR_O[31]),
       .B (Counter_Burst_Transfer_add_69_28_n_635), .Z
       (Counter_Burst_Transfer_plus_69_28[31]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g918(.A0 (ADR_O[30]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_637), .CO
       (Counter_Burst_Transfer_add_69_28_n_635), .S0
       (Counter_Burst_Transfer_plus_69_28[30]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g919(.A0 (ADR_O[29]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_639), .CO
       (Counter_Burst_Transfer_add_69_28_n_637), .S0
       (Counter_Burst_Transfer_plus_69_28[29]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g920(.A0 (ADR_O[28]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_641), .CO
       (Counter_Burst_Transfer_add_69_28_n_639), .S0
       (Counter_Burst_Transfer_plus_69_28[28]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g921(.A0 (ADR_O[27]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_643), .CO
       (Counter_Burst_Transfer_add_69_28_n_641), .S0
       (Counter_Burst_Transfer_plus_69_28[27]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g922(.A0 (ADR_O[26]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_645), .CO
       (Counter_Burst_Transfer_add_69_28_n_643), .S0
       (Counter_Burst_Transfer_plus_69_28[26]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g923(.A0 (ADR_O[25]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_647), .CO
       (Counter_Burst_Transfer_add_69_28_n_645), .S0
       (Counter_Burst_Transfer_plus_69_28[25]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g924(.A0 (ADR_O[24]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_649), .CO
       (Counter_Burst_Transfer_add_69_28_n_647), .S0
       (Counter_Burst_Transfer_plus_69_28[24]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g925(.A0 (ADR_O[23]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_651), .CO
       (Counter_Burst_Transfer_add_69_28_n_649), .S0
       (Counter_Burst_Transfer_plus_69_28[23]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g926(.A0 (ADR_O[22]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_653), .CO
       (Counter_Burst_Transfer_add_69_28_n_651), .S0
       (Counter_Burst_Transfer_plus_69_28[22]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g927(.A0 (ADR_O[21]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_655), .CO
       (Counter_Burst_Transfer_add_69_28_n_653), .S0
       (Counter_Burst_Transfer_plus_69_28[21]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g928(.A0 (ADR_O[20]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_657), .CO
       (Counter_Burst_Transfer_add_69_28_n_655), .S0
       (Counter_Burst_Transfer_plus_69_28[20]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g929(.A0 (ADR_O[19]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_659), .CO
       (Counter_Burst_Transfer_add_69_28_n_657), .S0
       (Counter_Burst_Transfer_plus_69_28[19]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g930(.A0 (ADR_O[18]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_661), .CO
       (Counter_Burst_Transfer_add_69_28_n_659), .S0
       (Counter_Burst_Transfer_plus_69_28[18]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g931(.A0 (ADR_O[17]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_663), .CO
       (Counter_Burst_Transfer_add_69_28_n_661), .S0
       (Counter_Burst_Transfer_plus_69_28[17]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g932(.A0 (ADR_O[16]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_665), .CO
       (Counter_Burst_Transfer_add_69_28_n_663), .S0
       (Counter_Burst_Transfer_plus_69_28[16]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g933(.A0 (ADR_O[15]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_667), .CO
       (Counter_Burst_Transfer_add_69_28_n_665), .S0
       (Counter_Burst_Transfer_plus_69_28[15]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g934(.A0 (ADR_O[14]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_669), .CO
       (Counter_Burst_Transfer_add_69_28_n_667), .S0
       (Counter_Burst_Transfer_plus_69_28[14]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g935(.A0 (ADR_O[13]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_671), .CO
       (Counter_Burst_Transfer_add_69_28_n_669), .S0
       (Counter_Burst_Transfer_plus_69_28[13]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g936(.A0 (ADR_O[12]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_673), .CO
       (Counter_Burst_Transfer_add_69_28_n_671), .S0
       (Counter_Burst_Transfer_plus_69_28[12]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g937(.A0 (ADR_O[11]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_675), .CO
       (Counter_Burst_Transfer_add_69_28_n_673), .S0
       (Counter_Burst_Transfer_plus_69_28[11]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g938(.A0 (ADR_O[10]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_677), .CO
       (Counter_Burst_Transfer_add_69_28_n_675), .S0
       (Counter_Burst_Transfer_plus_69_28[10]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g939(.A0 (ADR_O[9]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_679), .CO
       (Counter_Burst_Transfer_add_69_28_n_677), .S0
       (Counter_Burst_Transfer_plus_69_28[9]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g940(.A0 (ADR_O[8]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_681), .CO
       (Counter_Burst_Transfer_add_69_28_n_679), .S0
       (Counter_Burst_Transfer_plus_69_28[8]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g941(.A0 (ADR_O[7]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_683), .CO
       (Counter_Burst_Transfer_add_69_28_n_681), .S0
       (Counter_Burst_Transfer_plus_69_28[7]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g942(.A0 (ADR_O[6]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_685), .CO
       (Counter_Burst_Transfer_add_69_28_n_683), .S0
       (Counter_Burst_Transfer_plus_69_28[6]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g943(.A0 (ADR_O[5]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_687), .CO
       (Counter_Burst_Transfer_add_69_28_n_685), .S0
       (Counter_Burst_Transfer_plus_69_28[5]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g944(.A0 (ADR_O[4]),
       .B0 (Counter_Burst_Transfer_add_69_28_n_689), .CO
       (Counter_Burst_Transfer_add_69_28_n_687), .S0
       (Counter_Burst_Transfer_plus_69_28[4]));
  HS65_GS_HA1X4 Counter_Burst_Transfer_add_69_28_g945(.A0 (ADR_O[3]),
       .B0 (ADR_O[2]), .CO (Counter_Burst_Transfer_add_69_28_n_689),
       .S0 (Counter_Burst_Transfer_plus_69_28[3]));
endmodule

