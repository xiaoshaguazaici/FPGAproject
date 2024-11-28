`timescale 1ns / 1ns

module basicDFF_tb();
reg clk;
reg d;
wire q;
chapter4_basicDFF basicDFF(
    .clk(clk),
    .d(d),
    .q(q)

);

initial clk = 1;
always #10 clk = !clk;
initial begin
#21
d = 0;
#200;
d = 1;
#200;
d = 0;
#200;
end 
endmodule
