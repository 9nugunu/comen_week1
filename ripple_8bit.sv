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
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] sum,
    output cout
);
    wire [7:0] carry;
    assign carry[0] = cin;

    genvar i;
    generate
        for (i=0; i < 8; i = i + 1) begin : full_adder_stage
            full_adder fa(a[i], b[i], carry[i], sum[i], carry[i+1]);
        end
    endgenerate

    assign cout = carry[8];
endmodule