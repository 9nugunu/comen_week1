`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2023 01:23:38 AM
// Design Name: 
// Module Name: week2_gray
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


module bin2gray
        (input [7:0] bin, //binary input
         output [7:0] G //gray code output
        );

    //xor gates.
    assign G[7] = bin[7];
    assign G[6] = bin[7] ^ bin[6];
    assign G[5] = bin[6] ^ bin[5];
    assign G[4] = bin[5] ^ bin[4];
    assign G[3] = bin[4] ^ bin[3];
    assign G[2] = bin[3] ^ bin[2];
    assign G[1] = bin[2] ^ bin[1];
    assign G[0] = bin[1] ^ bin[0];

endmodule

module gray2bin
        (input [7:0] G, //gray code output
         output [7:0] bin   //binary input
        );

    assign bin[7] = G[7];
    assign bin[6] = G[7] ^ G[6];
    assign bin[5] = G[7] ^ G[6] ^ G[5];
    assign bin[4] = G[7] ^ G[6] ^ G[5] ^ G[4];
    assign bin[3] = G[7] ^ G[6] ^ G[5] ^ G[4] ^ G[3];
    assign bin[2] = G[7] ^ G[6] ^ G[5] ^ G[4] ^ G[3] ^ G[2];
    assign bin[1] = G[7] ^ G[6] ^ G[5] ^ G[4] ^ G[3] ^ G[2] ^ G[1];
    assign bin[0] = G[7] ^ G[6] ^ G[5] ^ G[4] ^ G[3] ^ G[2] ^ G[1] ^ G[0];

endmodule

module bin2gray_generator (
    input [7:0] bin,  // Binary input
    output [7:0] gray // Gray code output
);
    assign gray[7] = bin[7];

    genvar i;
    generate
        for (i = 6; i >= 0; i = i - 1) begin : bin2gray_loop
            assign gray[i] = bin[i+1] ^ bin[i];
        end
    endgenerate
endmodule

module gray2bin_generator (
    input [7:0] gray,  // Gray code input
    output reg [7:0] bin   // Binary output
);

    integer i;
    always @ (gray) begin
        bin[7] = gray[7];
        for (i = 6; i >= 0; i = i - 1) begin : gray2bin_loop
            assign bin[i] = bin[i+1] ^ gray[i];
        end
    end
endmodule

