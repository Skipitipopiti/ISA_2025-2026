// SystemVerilog translation of the provided VHDL `booth_encoder`
// Module name: booth_encoder
// Notes:
// - `a` is signed [7:0]
// - `be_in` is a 3-bit control vector
// - `s` outputs the sign bit (be_in[2])
// - `p` is 9-bit signed result built by concatenations / shifts


module booth_encoder (
input logic signed [7:0] a,
input logic [2:0] be_in,
output logic s,
output logic signed [8:0] p
);


// bitwise not of `a` (equivalent to VHDL `not(a)`).
// Keep as signed; bitwise inversion is well-defined here.


// sign bit output (msb of be_in in the VHDL version)
assign s = be_in[2];


// combinational logic implementing the VHDL case statement
always_comb begin
unique case (be_in)
3'b000, 3'b111: p = 9'b0;
3'b001, 3'b010: p = {1'b0, a}; // concatenation -> '0' & a
3'b011 : p = {a, 1'b0}; // a << 1 (LSB = 0)
3'b100 : p = ~{a, 1'b0}; // a_n << 1 (LSB = 1)
3'b101, 3'b110: p = ~{1'b0, a}; // '1' & a_n
default : p = 9'b0;
endcase
end


endmodule