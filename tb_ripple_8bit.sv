`timescale 1ns / 1ps

module tb_8bit_ripple;

    reg [7:0] a, b;
    reg cin;
    wire [7:0] sum;
    wire cout;

    ripple_carry dut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    integer passed_tests = 0;
    integer failed_tests = 0;

    reg [7:0] test_a[9:0];
    reg [7:0] test_b[9:0];
    reg test_cin[9:0];

    initial begin
        $display("**** Starting Test ****");
        test_a = {8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8, 8'd9, 8'd10};
        test_b = {8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8, 8'd9, 8'd10};
        test_cin = {1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1};

        for (int i = 0; i < 10; i = i + 1) begin
            a = test_a[i];
            b = test_b[i];
            cin = test_cin[i];
            #5;

            if (sum == (a+b+cin)) begin
                $display("Test %d successed: a = %d, b = %d, cin = %b, sum = %d, cout = %b", i, a, b, cin, sum, cout);
                passed_tests = passed_tests + 1;
            end else begin
                $display("Test %d failed: a = %d, b = %d, cin = %b, sum = %d, cout = %b", i, a, b, cin, sum, cout);
                failed_tests = failed_tests + 1;
            end
        end

        $display("Total tests: %d, passed: %d, failed: %d", (passed_tests + failed_tests), passed_tests, failed_tests);

        $finish;
    end
endmodule




