`timescale 1ns / 1ps

module i2c_io(
    input a,
    input en,
    output b,
);

assign b = en ? a : 1'bz;

always_ff @(posedge clk or negedge rst_n)
// reg data;

// assign data = 1'b1;
// assign data = 1'b0;
// assign data = 1'bx; # x = don't care
// assign data = 1'bz; # such as Tristate buffer

endmodule