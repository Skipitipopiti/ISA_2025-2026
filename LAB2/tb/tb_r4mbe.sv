`timescale 1ps/1ps

module tb_r4mbe;

    logic [7:0]  x_tb;
    logic [7:0]  a_tb;
    logic [15:0] y_tb;

    logic [15:0] expected;
    int err_count = 0;

    // DUT
    r4mbe uut(
        .x(x_tb),
        .a(a_tb),
        .y(y_tb)
    );

    initial begin

        // 1) Test con a fisso = 5
        a_tb = 8'd5;

        for (int x = 0; x < 256; x++) begin
            x_tb = x;
            #20;
            expected = x_tb * a_tb;
            if (y_tb !== expected) begin
                $display("ERR (a fisso) x=%0d a=%0d  y=%0d expected=%0d",
                         x_tb, a_tb, y_tb, expected);
                err_count++;
            end
        end

        // Test con x fisso = 5
        x_tb = 8'd5;

        for (int a = 0; a < 256; a++) begin
            a_tb = a;
            #20;
            expected = x_tb * a_tb;
            if (y_tb !== expected) begin
                $display("ERR (x fisso) x=%0d a=%0d  y=%0d expected=%0d",
                         x_tb, a_tb, y_tb, expected);
                err_count++;
            end
        end

        // Esito finale
        if (err_count == 0)
            $display("Test cleared with no errors");
        else
            $display("test cleared with %0d errors", err_count);

        $stop;
    end

endmodule
