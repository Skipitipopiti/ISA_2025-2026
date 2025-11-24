module fa (
	input logic a;
	input logic b;
    input logic cin;
    output logic sum;
    output logic cout;
);

logic tmp;

always_comb begin
    tmp = a ^ b;
    sum = cin ^ tmp;
    cout = (a & b) | (cin & (a ^ b));
end