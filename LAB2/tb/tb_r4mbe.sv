`timescale 1ns/1ps

module tb_r4mbe;

    // segnali del testbench
    logic [7:0]  x_tb;
    logic [7:0]  a_tb;
    logic [15:0] y_tb;

    // istanza del DUT
    r4mbe uut (
        .x(x_tb),
        .a(a_tb),
        .y(y_tb)
    );

    initial begin
        logic [7:0] x_val, a_val;
        logic [15:0] expected;

        // loop da 128 a 255
        for (int i = 128; i <= 255; i++) begin
            x_val = i[7:0];
            a_val = i[7:0];   // stessa sequenza per A
            x_tb = x_val;
            a_tb = a_val;

            #100;  // attendi 100 ns per la propagazione

            // calcolo prodotto atteso
            expected = x_val * a_val;

            // controllo
            if (y_tb !== expected) begin
                $display("Mismatch: x=%0d, a=%0d, expected=%0d, actual=%0d",
                         x_val, a_val, expected, y_tb);
            end
        end

        $display("Test completo!");
        $stop;
    end

endmodule












