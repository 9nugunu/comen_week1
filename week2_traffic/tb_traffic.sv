module testbench();

    logic clk;
    logic rst_n;

    traffic_light north, south, east, west; 


	reg NS_g, NS_y, NS_r, NS_lt;
	reg SN_g, SN_y, SN_r, SN_lt;

	reg EW_g, EW_y, EW_r, EW_lt;
	reg WE_g, WE_y, WE_r, WE_lt;

    traffic_light dut(
        .clk(clk),
        .rst_n(rst_n),
		.north(north),
		.south(south),
		.east(east),
		.west(west)
    );

    initial begin
        clk = 0;
        rst_n = 1; // 먼저 리셋을 비활성화 상태로 설정

        #20
        rst_n = 0; // 리셋 활성화

        #20
        rst_n = 1; // 리셋 해제
    end

    always #5 clk = ~clk; // 5ns 마다 클록 토글

    // // 출력 모니터링
    // always @ (posedge clk) begin
    //     $display("Time: %t, North: %0d, South: %0d, East: %0d, West: %0d", $time, north, south, east, west);
    // end
    
endmodule
