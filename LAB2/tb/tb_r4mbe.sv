`timescale 1ns/1ps

module tb_r4mbe;

    logic [7:0]  x_tb;
    logic [7:0]  a_tb;
    logic [15:0] y_tb;

    r4mbe uut (
        .x(x_tb),
        .a(a_tb),
        .y(y_tb)
    );

    initial begin
        logic [7:0] x_val;
        logic [7:0] a_val = 8'd3;       // fisso A=3
        logic [4:0] prefix = 5'b10001;  // prefisso fisso
        logic [15:0] expected;

        // loop su tutti i 3 LSB: 000..111
        for (int lsb = 3'b000; lsb <= 3'b111; lsb++) begin
            x_val = {prefix, lsb}; // combina prefisso (5 bit) + LSB (3 bit)
            x_tb = x_val;
            a_tb = a_val;
            #100;

            expected = x_val * a_val;

            if (y_tb !== expected) begin
                $display("Mismatch: x=%0d (%b), a=%0d, expected=%0d, actual=%0d",
                         x_val, x_val, a_val, expected, y_tb);
            end else begin
                $display("Pass: x=%0d (%b), a=%0d, y=%0d",
                         x_val, x_val, a_val, y_tb);
            end
        end

        $stop;
    end

endmodule















