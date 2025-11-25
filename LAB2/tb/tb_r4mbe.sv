'timescale 1ns/1ps

module tb_r4mbe;

    logic [7:0]  x_tb;
    logic [7:0]  a_tb;
    logic [15:0] y_tb;

    r4mbe uut(
        .x(x_tb),
        .a(a_tb),
        .y(y_tb)
    );

    initial begin
        logic [7:0] base142 = 8'd142; // 10001110
        logic [7:0] base143 = 8'd143; // 10001111
        logic [7:0] modified;
        logic [15:0] expected;
        logic [7:0] A = 8'd3;

        // -----------------------------------------
        //   TEST PER 142
        // -----------------------------------------
        $display("\n--- TEST 142 ---");

        for (int b = 0; b < 8; b++) begin
            modified = base142 ^ (8'b1 << b);   // NOT del bit b
            x_tb = modified;
            a_tb = A;
            #50;

            expected = modified * A;

            if (y_tb !== expected)
                $display("Mismatch (bit %0d nottato): x=%b (%0d), expected=%0d, actual=%0d",
                         b, modified, modified, expected, y_tb);
            else
                $display("OK (bit %0d nottato): x=%b (%0d)", b, modified, modified);
        end


        // -----------------------------------------
        //   TEST PER 143
        // -----------------------------------------
        $display("\n--- TEST 143 ---");

        for (int b = 0; b < 8; b++) begin
            modified = base143 ^ (8'b1 << b);   // NOT del bit b
            x_tb = modified;
            a_tb = A;
            #50;

            expected = modified * A;

            if (y_tb !== expected)
                $display("Mismatch (bit %0d nottato): x=%b (%0d), expected=%0d, actual=%0d",
                        b, modified, modified, expected, y_tb);
            else
                $display("OK (bit %0d nottato): x=%b (%0d)", b, modified, modified);
        end

        $display("\nTest completo.\n");
        $stop;
    end

endmodule

