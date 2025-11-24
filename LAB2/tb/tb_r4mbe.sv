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

    // processo di stimolo
    initial begin
        // test vector 1
        x_tb = 8'b00011010; // 26
        a_tb = 8'b00000101; // 5
        #100;

        // test vector 2
        x_tb = 8'b11100100; // 228
        a_tb = 8'b00000011; // 3
        #100;

        // test vector 3
        x_tb = 8'b01111111; // 127
        a_tb = 8'b01111111; // 127
        #100;

        // test vector 4
        x_tb = 8'b10000000; // 128
        a_tb = 8'b10000000; // 128
        #100;

        $stop; // ferma la simulazione
    end

endmodule