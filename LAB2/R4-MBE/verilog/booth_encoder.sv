module booth_encoder (
  input logic signed [7:0] a,
  input logic [2:0] be_in,
  output logic s,
  output logic signed [8:0] p
);


  assign s = be_in[2];
  
  
  always_comb begin
    unique case (be_in)
      3'b000, 3'b111: p = 9'b0;
      3'b001, 3'b010: p = {1'b0, a};  // concatenation -> '0' & a
      3'b011 : p = {a, 1'b0};         // a << 1 (LSB = 0)
      3'b100 : p = ~{a, 1'b0};        // a_n << 1 (LSB = 1)
      3'b101, 3'b110: p = ~{1'b0, a}; // '1' & a_n
      default : p = 9'b0;
    endcase
  end


endmodule