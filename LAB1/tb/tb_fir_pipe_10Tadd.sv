//`timescale 1ns

module tb_fir_pipe_10Tadd ();

   logic CLK_i;
   logic RST_n_i;
   logic [8:0] DIN_i;
   logic VIN_i;
   logic [8:0] b0_i;
   logic [8:0] b1_i;
   logic [8:0] b2_i;
   logic [8:0] b3_i;
   logic [8:0] b4_i;
   logic [8:0] b5_i;
   logic [8:0] b6_i;
   logic [8:0] b7_i;
   logic [8:0] b8_i;
   logic [8:0] b9_i;
   logic [8:0] b10_i;
   
   logic [8:0] DOUT_i;
   logic VOUT_i;
   logic END_SIM_i;

   clk_gen CG(
  .END_SIM(END_SIM_i), 
       .CLK(CLK_i),
     .RST_n(RST_n_i));

   data_maker SM(
  .CLK(CLK_i),
  .RST_n(RST_n_i),
  .VOUT(VIN_i),
  .DOUT(DIN_i),
  .b0(b0_i),
  .b1(b1_i),
  .b2(b2_i),
  .b3(b3_i),
  .b4(b4_i),
  .b5(b5_i),
  .b6(b6_i),
  .b7(b7_i),
  .b8(b8_i),
  .b9(b9_i),
  .b10(b10_i),
  .END_SIM(END_SIM_i));

   filter_core_pipe_10Tadd UUT(
   .clk(CLK_i),
   .RST_n(RST_n_i),
   .DIN(DIN_i),
   .VIN(VIN_i),
   .b0(b0_i),
   .b1(b1_i),
   .b2(b2_i),
   .b3(b3_i),
   .b4(b4_i),
   .b5(b5_i),
   .b6(b6_i),
   .b7(b7_i),
   .b8(b8_i),
   .b9(b9_i),
   .b10(b10_i),
   .a0(),
   .a1(),
   .a2(),
   .a3(),
   .a4(),
   .a5(),
   .a6(),
   .a7(),
   .a8(),
   .a9(),
   .a10(),
   .DOUT(DOUT_i),
   .VOUT(VOUT_i));

   data_sink DS(
  .CLK(CLK_i),
  .RST_n(RST_n_i),
  .VIN(VOUT_i),
  .DIN(DOUT_i));   

endmodule