`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2023 11:55:48 AM
// Design Name: 
// Module Name: half_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module half_adder(a, b, sum, carry);
    input a, b;
    output sum, carry;
    xor g1(sum, a, b);
    and g2(carry, a, b);
endmodule

module full_adder_old(a, b, cin, sum, cout);

    input a, b, cin;
    output sum, cout;
    wire s1, c1, c2;
    
    xor g1(s1, a, b);
    and g2(c1, a, b);
    and g3(c2, cin, s1);
    xor g4(sum, s1, cin);
    xor g5(cout,c1, c2);
endmodule

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
