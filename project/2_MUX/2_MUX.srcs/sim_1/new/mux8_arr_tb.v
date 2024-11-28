`timescale 1ns / 1ns

module mux8_arr_tb();
reg reset_n;
reg [7:0]in0;
reg [7:0]in1;
reg [7:0]in2;
reg [7:0]in3;
reg [7:0]in4;
reg [7:0]in5;
reg [7:0]in6;
reg [7:0]in7;
reg [2:0]sel;
wire [7:0]out;
mux8_arr mux8_arr(

    .reset_n(reset_n),

    .in0(in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),  
    .in4(in4),
    .in5(in5),
    .in6(in6),  
    .in7(in7),    

    .sel(sel),
    .out(out)
);

initial in0 = 8'b0000_0001;
initial in1 = 8'b0000_0010;
initial in2 = 8'b0000_0100;
initial in3 = 8'b0000_1000;
initial in4 = 8'b0001_0000;
initial in5 = 8'b0010_0000;
initial in6 = 8'b0100_0000;
initial in7 = 8'b1000_0000;

initial begin
reset_n = 0;
#200;
reset_n =1;
#201;
sel = 3'd0;#200;
sel = 3'd1;#200;
sel = 3'd2;#200;
sel = 3'd3;#200;
sel = 3'd4;#200;
sel = 3'd5;#200;
sel = 3'd6;#200;
sel = 3'd7;#200;
end
endmodule

