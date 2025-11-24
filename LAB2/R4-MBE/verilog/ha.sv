module ha{
    input logic a,
    input logic b,
    output logic sum,
    output logic co
};

    assign sim = a ^ b;
    assign co = a & b;
endmodule