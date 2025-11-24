module r4mbe(
    input logic [7:0] x,
    input logic [7:0] a,
    output logic [15:0] y
);

typedef  logic [2:0] uint3_t;
typedef  logic [8:0] uint9_t;
uint3_t be_in[5];
uint9_t p_be[5];
logic s_be[4:0];
assign be_in[4] = {2'b00,x[7]};
assign be_in[0] = {x[1], x[0], 1'b0};

genvar i;
generate 
    for(i=1; i<4; i=i+1) begin : gen_be
        assign be_in[i] = x[2*i+1 -: 3];
    end
endgenerate


generate 
    for(i=0; i<5; i=i+1) begin : be_g_inst
        be_inst booth_encoder(
            .a (signed'(a)),
            .be_in (be_in[i]),
            .s (s_be[i]),
            .p (p_be[i])
        );
    end
endgenerate

wt_inst wallace_tree(
    .p0 (p_be[0]),
    .p1 (p_be[1]),
    .p2 (p_be[2]),
    .p3 (p_be[3]),
    .p4 (signed'(p_be[4][7:0])),
    .s  (s_be[4:0]),
    .y  (y)
);
endmodule