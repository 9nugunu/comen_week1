/* 신호등 데이터타입 */
typedef enum logic [1:0] {
	GREEN,
	YELLOW,
	RED,
	LEFT
} traffic_light;


/* DUT - 신호등 FSM */
module light_fsm (
	input clk, rst_n,
	output traffic_light north, // 북쪽 신호등 
	output traffic_light south, // 남쪽 신호등
	output traffic_light east,  // 동쪽 신호등
	output traffic_light west,  // 서쪽 신호등
);

	/* Todo */

endmodule



/* Testbench */
module testbench();

	logic clk;
	logic rst_n;

	traffic_light north, south, east, west; 

	light_fsm dut(
		 .clk(clk)
		,.rst_n(rst_n)
		,.north(north)
		,.south(south)
		,.east(east)
		,.west(west)
	);

	/* Todo */

	
endmodule