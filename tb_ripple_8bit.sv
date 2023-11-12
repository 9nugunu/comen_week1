'timescale 1ns / 1ps

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

    # 
    initial begin
        $$display("**** Starting Test ****");
        a = 0; b = 0; cin = 0;
        passed_tests =0; failed_tests = 0;
        #5
        a = 8'b00000001;
        b = 8'b00000001;
        cin = 0;
        #5

        a = 8'b00000010;
        b = 8'b00000011;
        #5;

        for (int i = 0; i < 10; i = i + 1) begin
            a = test_a[i];
            b = test_b[i];
            cin = test_cin[i];
            #5;

            if (sum == (a+b+cin) && cout == (a+b+cin) >> 8) begin
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




