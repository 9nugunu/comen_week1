`timescale 1ns / 1p

/* 23. 11. 26
기본적인 교차로 신호체계 구현
마지막 단 구현 식 Combinatiorial logic 으로 구현 하면 clk 고려를 하지 못함.
Sequential logic(FF)으로 구현하여 clk에따라 State 변경을 할 수 있게끔 구현해야함.

*/

module traffic_light();

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

	reg NS_g, NS_y, NS_r, NS_lt;
	reg SN_g, SN_y, SN_r, SN_lt;

	reg EW_g, EW_y, EW_r, EW_lt;
	reg walk_g, walk_r;

	reg [7:0] timer;

	initial begin
		clk = 0;

		state = S_RST;

		timer = 0

		NS_g = 1;
		NS_y = 1;
		NS_r = 1;
		NS_lt = 1;

		SN_g = 1;
		SN_y = 1;
		SN_r = 1;
		SN_lt = 1;

		EW_g = 1;
		EW_y = 1;
		EW_r = 1;
		EW_lt = 1;
		
		WE_g = 1;
		WE_y = 1;
		WE_r = 1;
		WE_lt = 1;


		rst_n = 1;
		#30
		rst_n = 0;
		#30
		rst_n = 1;
	end

	always begin
		#5
		clk = ~clk;
	end

	always @ (posedge clk or negedge rst_n) begin
		if (~rst_n) state <= S_RST;
		else		state <= next_state;
		
		case(state) 
			S_RST: next_state = S1;
			S1: begin
				if (timer  == 40)    
				next_state = S2;
				else
				next_state = state;
			end
			S2: begin 
				if (timer  == 5)    
				next_state = S3;
				else
				next_state = state;
			end
			S3: begin
				if (timer  == 20)    
				next_state = S4;
				else
				next_state = state;
			end

			S4: begin
				if (timer  == 5)    
				next_state = S5;
				else
				next_state = state;
			end		 	

			S5: begin
				if (timer  == 40)    
				next_state = S6;
				else
				next_state = state;
			end

			S6: begin
				if (timer  == 5)    
				next_state = S7;
				else
				next_state = state;
			end

			S8: begin
				if (timer  == 5)    
				next_state = S1;
				else
				next_state = state;
			end
			
		endcase
	end

	always @ (*) begin
		case(state)
			S_RST: next_state = S1;
			S1: next_state = S2;
			S2: next_state = S3;
			S3: next_state = S4;
			S4: next_state = S5;
			S5: next_state = S6;
			S6: next_state = S7;
			S7: next_state = S8;
		endcase
	end

		if (~rst_n) begin
			NS_g = 1;
			NS_y = 1;
			NS_r = 1;
			NS_lt = 1;

			SN_g = 1;
			SN_y = 1;
			SN_r = 1;
			SN_lt = 1;

			EW_g = 1;
			EW_y = 1;
			EW_r = 1;
			EW_lt = 1;

			WE_g = 1;
			WE_y = 1;
			WE_r = 1;
			WE_lt = 1;
		end 

       else begin
          case(next_state) 
            S_RST: begin
				NS_g = 1;
				NS_y = 0;
				NS_r = 0;
				NS_lt = 0;

				NS_g = 1;
				NS_y = 0;
				NS_r = 0;
				NS_lt = 0;

				EW_g = 1;
				EW_y = 0;
				EW_r = 1;
				EW_lt = 0;

				WE_g = 1;
				WE_y = 0;
				WE_r = 1;
				WE_lt = 0;
            end 

            S1: begin
				NS_g = 0;
				NS_y = 1;
				NS_r = 0;
				NS_lt = 0;

				NS_g = 0;
				NS_y = 1;
				NS_r = 0;
				NS_lt = 0;

				EW_g = 0;
				EW_y = 0;
				EW_r = 1;
				EW_lt = 0;

				WE_g = 0;
				WE_y = 0;
				WE_r = 1;
				WE_lt = 0;

               if (timer < 40)
                 timer <= timer +1;
              else
                  timer <= 0;
            end 

            S2: begin
				NS_g = 0;
				NS_y = 1;
				NS_r = 0;
				NS_lt = 0;

				NS_g = 0;
				NS_y = 1;
				NS_r = 0;
				NS_lt = 0;

				EW_g = 0;
				EW_y = 0;
				EW_r = 1;
				EW_lt = 0;

				WE_g = 0;
				WE_y = 0;
				WE_r = 1;
				WE_lt = 0;

               if (timer < 5)
                 timer <= timer +1;
              else
                  timer <= 0;
            end 

            S3: begin
				NS_g = 0;
				NS_y = 0;
				NS_r = 1;
				NS_lt = 0;

				NS_g = 0;
				NS_y = 0;
				NS_r = 1;
				NS_lt = 0;

				EW_g = 0;
				EW_y = 0;
				EW_r = 1;
				EW_lt = 1;

				WE_g = 0;
				WE_y = 0;
				WE_r = 1;
				WE_lt = 1;

               if (timer < 20)
                 timer <= timer +1;
              else
                  timer <= 0;
            end
			
            S4: begin
				NS_g = 0;
				NS_y = 0;
				NS_r = 0;
				NS_lt = 0;

				NS_g = 0;
				NS_y = 0;
				NS_r = 0;
				NS_lt = 0;

				EW_g = 0;
				EW_y = 1;
				EW_r = 0;
				EW_lt = 0;

				WE_g = 0;
				WE_y = 1;
				WE_r = 0;
				WE_lt = 0;

               if (timer < 5)
                 timer <= timer +1;
              else
                  timer <= 0;
            end

            S5: begin
				NS_g = 0;
				NS_y = 0;
				NS_r = 1;
				NS_lt = 0;

				NS_g = 0;
				NS_y = 0;
				NS_r = 1;
				NS_lt = 0;

				EW_g = 1;
				EW_y = 0;
				EW_r = 0;
				EW_lt = 0;

				WE_g = 1;
				WE_y = 0;
				WE_r = 0;
				WE_lt = 0;

               if (timer < 40)
                 timer <= timer +1;
              else
                  timer <= 0;
            end

            S6: begin
				NS_g = 0;
				NS_y = 0;
				NS_r = 1;
				NS_lt = 0;

				NS_g = 0;
				NS_y = 0;
				NS_r = 1;
				NS_lt = 0;

				EW_g = 0;
				EW_y = 1;
				EW_r = 0;
				EW_lt = 0;

				WE_g = 0;
				WE_y = 1;
				WE_r = 0;
				WE_lt = 0;

               if (timer < 5)
                 timer <= timer +1;
              else
                  timer <= 0;
            end

            S7: begin
				NS_g = 0;
				NS_y = 0;
				NS_r = 1;
				NS_lt = 1;

				NS_g = 0;
				NS_y = 0;
				NS_r = 1;
				NS_lt = 1;

				EW_g = 0;
				EW_y = 0;
				EW_r = 1;
				EW_lt = 0;

				WE_g = 0;
				WE_y = 0;
				WE_r = 1;
				WE_lt = 0;

               if (timer < 20)
                 timer <= timer +1;
              else
                  timer <= 0;
            end

            S8: begin
				NS_g = 0;
				NS_y = 1;
				NS_r = 0;
				NS_lt = 0;

				NS_g = 0;
				NS_y = 1;
				NS_r = 0;
				NS_lt = 0;

				EW_g = 0;
				EW_y = 0;
				EW_r = 1;
				EW_lt = 0;

				WE_g = 0;
				WE_y = 0;
				WE_r = 1;
				WE_lt = 0;

               if (timer < 5)
                 timer <= timer +1;
              else
                  timer <= 0;
            end
         endcase
	end
	
endmodule