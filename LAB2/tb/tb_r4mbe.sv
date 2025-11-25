`timescale 1ns/1ps

module tb_r4mbe;

    logic [7:0]  x_tb;
    logic [7:0]  a_tb;
    logic [15:0] y_tb;

    // DUT
    r4mbe uut(
        .x(x_tb),
        .a(a_tb),
        .y(y_tb)
    );

    initial begin
        logic [7:0] a_val = 8'd3;
        logic [15:0] expected;


        // ------- combinazioni 1000xxx0 -------
        x_tb = 8'b10000000; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10000010; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10000100; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10000110; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10001000; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10001010; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10001100; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10001110; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);


        // ------- combinazioni 1000xxx1 -------
        x_tb = 8'b10000001; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10000011; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10000101; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10000111; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10001001; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10001011; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10001101; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);
        x_tb = 8'b10001111; a_tb = a_val; #50; expected = x_tb * a_tb; if (y_tb !== expected) $display("ERR %b", x_tb);


        $display("Test completato");
        $stop;
    end

endmodule
