`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2023 01:48:20 PM
// Design Name: 
// Module Name: tb_mmcm
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


module tb_mmcm();

    localparam PERIOD_NS = 83.33;

    wire       clk_out1;
    wire       clk_out2;
    wire       locked;

    reg        reset;
    reg        clk_in1;

    test_mmcm dut (
        .clk_out1(clk_out1),
        .clk_out2(clk_out2),
        // Status and control signals
        .reset(reset),
        .locked(locked),
        // Clock in ports
        .clk_in1(clk_in1)
  );

initial begin
    reset = 1;

    #100
    reset = 0;

end

always begin
    #(PERIOD_NS/2)
    clk_in1 = ~clk_in1;
end
endmodule
