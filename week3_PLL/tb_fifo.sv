`timescale 1ns / 1ps


/**********************************
	  Dual Port FIFO Testbench
***********************************/

module tb_fifo();

logic wclk;
logic rclk;
logic rst;

wire full;
logic wr_en;
logic [17:0] din;

logic empty, rd_en;
logic [17:0] dout;
logic valid;



fifo_dual fifo_dual_inst(
	// 쓰기 신호
	 .full	(full)
	,.din 	(din)
	,.wr_en (wr_en)

	// 읽기 신호
	,.empty (empty)
	,.dout 	(dout)
	,.rd_en (rd_en)
	,.valid (valid)

	,.rst 	 (rst)

	,.wr_clk (wclk)	// 쓰기 클럭
	,.rd_clk (rclk)	// 읽기 클럭
);


assign rd_en = ~empty;

initial begin
	wclk = 0;
	rclk = 0;
	rst = 0;
	wr_en = 0;
	//rd_en = 0;

	#20
	rst = 1;

	#100
	rst = 0;

	#100
	wr_en = 1;
	//rd_en = 1;
end


// 쓰기클럭은 50Mhz
always begin
	#5	wclk = ~wclk;
end


// 읽기 클럭은 100Mhz
always begin
	#10 rclk = ~rclk;
end



always_ff @(posedge wclk or negedge rst) begin
	if (rst) 
		din <= 0;
	else if (wr_en)
		din <= din + 1;
end



endmodule