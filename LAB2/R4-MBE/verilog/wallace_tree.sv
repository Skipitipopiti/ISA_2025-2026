module wallace_tree (
    input logic signed [8:0] p0,
    input logic signed [8:0] p1,
    input logic signed [8:0] p2,
    input logic signed [8:0] p3,
    input logic signed [7:0] p4,

    input logic [4:0] s,

    output logic [15:0] sum   // unsigned 16 bit
);


    // signals
    logic s_l0 [11:0];  // layer 1 first operand (first row)
    logic c_l0 [11:0];  // l1 second oprd
    logic f_l0 [11:0];  // l1 third oprd

    logic s_l1 [15:0];   // l1 sum output and l2 first oprd
    logic c_l1 [13:0];   // l1 cout and l2 second oprd
    logic f_l1 [9:0];    // l2 third oprd

    logic s_l2 [15:0];   // l2 sum ouput and l3 first oprd
    logic c_l2 [13:0];   // l2 cout and l3 second oprd
    logic f_l2 [6:0];    // l3 third oprd
    
    logic s_l3 [16:0];   // l3 sum output and final first oprd
    logic c_l3 [13:0];   // l3 cout and final second oprd

    logic s_l4 [2:0]; // padding for final result
    logic signed [14:0] s_add; // final result MSBs from beh adder
    
    // layer 0
    // operands building
    assign s_l0 = {~s[0], s[0], s[0], p0};
    assign c_l0 = {1'b1, ~s[1], p1, s[1]};
    assign f_l0 = {1'b1, ~s[2], p2, s[2]};
    
    // processing
    ha ha0_l0 (
        .a    (s_l0[0]),
        .b    (c_l0[0]),
        .sum  (s_l1[0]),
        .cout (c_l1[0])
    );

    assign s_l1(1) = s_l0(1); // direct connection

    fa fa0_l0 ( // parto sempre da 0 per comodità
        .a    (s_l0[2]),
        .b    (c_l0[1]),
        .cin  (f_l0[0]),
        .sum  (s_l1[2]),
        .cout (c_l1[1])
    );

    ha ha1_l0(
        .a    (s_l0[3]),
        .b    (c_l0[2]),
        .sum  (s_l1[3]),
        .cout (c_l1[2])
    );

    genvar i;
    generate
        for (i = 0; i < 8; i=i+1) begin : fa_1to8_l0
            fa fa_g_l0 (
                .a   (s_l0[i+4]),
                .b   (c_l0[i+3]),
                .cin (f_l0[i+1]),
                .sum (s_l1[i+4]),
                .cout(c_l1[i+3])
            );
        end
    endgenerate

    ha ha2_l0 (
        .a    (c_l0[11]),
        .b    (f_l0[9]),
        .sum  (s_l1[12]),
        .cout (c_l1[11])
    );

    assign s_l1[13] = f_l0[10]; // direct connection
    assign s_l1[14] = f_l0[11]; // direct connection
    assign s_l1[15] = ~s[3];    // padding

    assign c_l1[12] = p3[8];  // padding
    assign c_l1[13] = p4[7];  // padding


    // layer 1

    // operands building
    // s_l1 end c_l1 come ready from previous layer
    assign f_l1 = {p4[6], p3[7:0], s[3]}; // third oprd build

    // processing
    assign s_l2[0] = s_l1[0];  // direct connection

    ha ha0_l1 (
        .a    (s_l1[1]),
        .b    (c_l1[0]),
        .sum  (s_l2[1]),
        .cout (c_l2[0])
    );

    assign s_l2[2] = s_l1[2];  // direct connection

    ha ha1_l1 (
        .a    (s_l1[3]),
        .b    (c_l1[1]),
        .sum  (s_l2[3]),
        .cout (c_l2[1])
    );

    fa fa0_l1 (
        .a    (s_l1[4]),
        .b    (c_l1[2]),
        .cin  (f_l1[0]),
        .sum  (s_l2[4]),
        .cout (c_l2[2])
    );

    ha ha2_l1 (
        .a    (s_l1[5]),
        .b    (c_l1[3]),
        .sum  (s_l2[5]),
        .cout (c_l2[3])
    );
    
    generate
        for (i = 0; i < 9; i=i+1) begin : fa_1to9_l1
            fa fa_g_l1 (
                .a    (s_l1[i+6]),
                .b    (c_l1[i+4]),
                .cin  (f_l1[i+1]),
                .sum  (s_l2[i+6]),
                .cout (c_l2[i+4])
            );
        end
    endgenerate

    ha ha3_l1 (
        .a    (s_l1[15]),
        .b    (c_l1[13]),
        .sum  (s_l2[15]),
        .cout (c_l2[13])
    );

    // layer 2
    // operands building
    // s_l2 end c_l2 come ready from previous layer
    assign f_l2 = {p4[5:0], s[4]}; // third oprd build
    
    // processing
    assign s_l3[0] = s_l2[0];  // direct connection
    assign s_l3[1] = s_l2[1];  // direct connection

    ha ha0_l2 (
        .a    (s_l2[2]),
        .b    (c_l2[0]),
        .sum  (s_l3[2]),
        .cout (c_l3[0])
    );

    assign s_l3[3] = s_l2[3];  // direct connection
    assign c_l3[1] = 1'b0;      // to prepare for last addition

    generate
        for (i = 0; i < 2; i=i+1) begin : ha_1to2_l2
            ha ha_g_l2 (
                .a    (s_l2[i+4]),
                .b    (c_l2[i+1]),
                .sum  (s_l3[i+4]),
                .cout (c_l3[i+2])
            );
        end
    endgenerate

    fa fa0_l2 (
        .a    (s_l2[6]),
        .b    (c_l2[3]),
        .cin  (f_l2[0]),
        .sum  (s_l3[6]),
        .cout (c_l3[4])
    );

    ha ha3_l2 (
        .a    (s_l2[7]),
        .b    (c_l2[4]),
        .sum  (s_l3[7]),
        .cout (c_l3[5])
    );

    generate
        for (i = 0; i < 6; i=i+1) begin : fa_1to6_l2
            fa fa_g_l2 (
                .a    (s_l2[i+8]),
                .b    (c_l2[i+5]),
                .cin  (f_l2[i+1]),
                .sum  (s_l3[i+8]),
                .cout (c_l3[i+6])
            );
        end
    endgenerate

    generate
        for (i=0; i<2; i=i+1) begin : ha_4to5_l2
            ha ha_g_l2 (
                .a    (s_l2[i+14]),
                .b    (c_l2[i+11]),
                .sum  (s_l3[i+14]),
                .cout (c_l3[i+12])
            );
        end
    endgenerate

    assign s_l3[16] = c_l2[13];    // padding

    // layer 3
    // operands building
    // s_l3 end c_l3 come ready from previous layer

    // processing, last adderx14
    assign s_l4[0] = s_l3[0];  // direct connection
    assign s_l4[1] = s_l3[1];  // direct connection
    assign s_l4[2] = s_l3[2];  // direct connection
    assign s_add = s_l3[16:3] + c_l3;

    // final result allignment
    assign sum = unsigned'{s_add[12:0], s_l4}; // vengono scartati due bit dalla somma dei segni

endmodule
