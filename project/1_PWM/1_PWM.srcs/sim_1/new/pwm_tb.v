`timescale 1ns / 1ns

module pwm_tb();
reg clk;
reg reset_n;
reg en;
wire out;
wire [25:0]now_cnt;
pwm pwm1(
.clk(clk),
.reset_n(reset_n),
.en(en),
.out(out),
.now_cnt(now_cnt)

);
initial clk = 1;
always #10 clk = !clk;
initial begin
reset_n = 0;
en = 0;
#201;
reset_n = 1;
#80000;
#201;
en = 1;
#80000;
$stop;
end

endmodule
