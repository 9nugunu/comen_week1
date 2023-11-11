'timescale 1ns / 1ps

module tb_8bit_ripple;

    reg [7:0] a, b;
    reg cin;
    wire [7:0] sum;
    wire cout;

    initial begin
        a = 0; b = 0; cin = 0;
        
        #5
        a = 8'b00000001;
        b = 8'b00000001;
        cin = 0;
        #5

        a = 8'b00000010;
        b = 8'b00000011;
        #5;
        
        $finish;
    end
endmodule




