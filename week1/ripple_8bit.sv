module full_adder(
    input a,
    input b,
    inout cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

module ripple_carry(
    input [8:1] a,
    input [8:1] b,
    input cin,
    output [8:1] sum,
    output cout
);
    wire [8:1] carry;
    assign carry[1] = cin;

    genvar i;
    generate
        for (i=1; i < 8 + 1; i = i + 1) begin : full_adder_stage
            full_adder fa(a[i], b[i], carry[i], sum[i], carry[i+1]);
        end
    endgenerate

    assign cout = carry[8];
endmodule