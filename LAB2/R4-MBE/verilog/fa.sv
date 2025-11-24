module fa (
	  input logic a,
	  input logic b,
    input logic cin,
    output logic sum,
    output logic cout
);

    logic tmp;

    assign tmp = a ^ b;
    assign sum = cin ^ tmp;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule