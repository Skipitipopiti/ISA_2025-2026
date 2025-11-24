// testa codifica one-hot di x con A fisso a 3

`timescale 1ns/1ps

module tb_r4mbe;

    logic [7:0]  x_tb;
    logic [7:0]  a_tb;
    logic [15:0] y_tb;

    // DUT
    r4mbe uut (
        .x(x_tb),
        .a(a_tb),
        .y(y_tb)
    );

    initial begin
        logic [7:0] x_val;
        logic [7:0] a_val = 8'd3;     // A fisso = 3
        logic [15:0] expected;

        $display("\n--- Test singolo bit di x con A=3 ---\n");

        // test dei singoli bit: x = 1 << i
        for (int i = 0; i < 8; i++) begin
            x_val = (8'b00000001 << i);

            x_tb = x_val;
            a_tb = a_val;

            #50;  // tempo di propagazione

            expected = x_val * a_val;

            if (y_tb !== expected) begin
                $display("Mismatch: x=%0d (%b), a=%0d, expected=%0d, actual=%0d",
                         x_val, x_val, a_val, expected, y_tb);
            end else begin
                $display("Pass: x=%0d (%b), y=%0d",
                         x_val, x_val, y_tb);
            end
        end

        $display("\nTest completato!\n");
        $stop;
    end

endmodule

















