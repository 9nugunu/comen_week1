module tb_i2c_io();

reg a, en;
wire b;
pullup(b);

i2c_io dut(
	.a(a),
	.en(en),
	.b(b)
);


initial begin
	a = 0;
	en = 1;

	#10 a = 1;
	#10 a = 0;
	#10 en = 0;
end


endmodule