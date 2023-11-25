`timescale 1ns / 1ps

module traffic_light():

	localparam S_RST = 2'b000;
	localparam S1 = 2'b0001;
	localparam S2 = 2'b0010;
	localparam S3 = 2'b0011;
	localparam S4 = 2'b0100;
	localparam S5 = 2'b0101;
	localparam S6 = 2'b0110;
	localparam S7 = 2'b0111;
	localparam S8 = 2'b1000;

	reg rst_n;
	reg clk;
	reg [1:0] state, next_state;

	reg car_g, car_r, car_y;
	reg walk_g, walk_r;

	reg [7:0] timer;

	initial begin
		clk = 0;

		state = S_RST;

		timer = 0

		car_g = 1;
		car_r = 1;
		car_y = 1;
		walk_g = 0;
		walk_r = 1;

		ret_n = 1;
	end

	always begin
		#5
		clk = ~clk;
	end
