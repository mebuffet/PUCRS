
// Generated by Cadence Genus(TM) Synthesis Solution GENUS15.20 - 15.20-p004_1
// Generated on: Sep  6 2016 16:51:33

// Verification Directory fv/anel 

module anel(reset, ring_o);
  input reset;
  output ring_o;
  wire reset;
  wire ring_o;
  wire [12:0] ring;
  wire n_2;
  HS65_GS_NAND2X2 nx(.A (reset), .B (n_2), .Z (ring[0]));
  inv \inv_instance[1].inv_i (.A (ring[0]), .Z (ring[1]));
  inv \inv_instance[2].inv_i (.A (ring[1]), .Z (ring[2]));
  inv \inv_instance[3].inv_i (.A (ring[2]), .Z (ring[3]));
  inv \inv_instance[4].inv_i (.A (ring[3]), .Z (ring[4]));
  inv \inv_instance[5].inv_i (.A (ring[4]), .Z (ring[5]));
  inv \inv_instance[6].inv_i (.A (ring[5]), .Z (ring[6]));
  inv \inv_instance[7].inv_i (.A (ring[6]), .Z (ring[7]));
  inv \inv_instance[8].inv_i (.A (ring[7]), .Z (ring[8]));
  inv \inv_instance[9].inv_i (.A (ring[8]), .Z (ring[9]));
  inv \inv_instance[10].inv_i (.A (ring[9]), .Z (ring[10]));
  inv \inv_instance[11].inv_i (.A (ring[10]), .Z (ring[11]));
  inv \inv_instance[12].inv_i (.A (ring[11]), .Z (ring_o));
  HS65_GS_BFX2 cdn_loop_breaker(.A (ring_o), .Z (n_2));
endmodule

