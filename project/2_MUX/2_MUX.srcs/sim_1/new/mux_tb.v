`timescale 1ns / 1ps
module mux_tb();
reg reset_n;
reg [7:0]in;
reg [2:0]sel;
wire out;
mux8 mux8(
    .reset_n(reset_n),
    .in(in),
    .sel(sel),
    .out(out)
);

initial in = 8'b10101010;
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
