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

        // loop da 128 a 255
        for (int i = 128; i <= 255; i++) begin
            x_val = i[7:0];
            a_val = i[7:0];   // stessa sequenza per A
            x_tb = x_val;
            a_tb = a_val;
            #100;  // attendi 100 ns tra i test
        end

        $stop;
    end

    /*
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

		// test vector 5
		x_tb = 8'b00000001; // 1
		a_tb = 8'b11111111; //255
		#100;
		
		// test vector 6
		x_tb = 8'b10101010; // 170
		a_tb = 8'b01010101; // 85
		#100;

		// test vector 7
		x_tb = 8'b11111111; // 255
		a_tb = 8'b11111111; // 255
		#100;

		// test vector 8
		x_tb = 8'b00001111; // 15
		a_tb = 8'b00110011; // 51
		#100;

		// test vector 9
		x_tb = 8'b10011001; // 153
		a_tb = 8'b00001111; // 15
		#100;

        $stop; // ferma la simulazione
    end
    */

endmodule











