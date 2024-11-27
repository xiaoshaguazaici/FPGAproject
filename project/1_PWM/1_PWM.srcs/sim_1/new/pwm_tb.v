`timescale 1ns / 1ns

module pwm_tb();
reg clk;
reg reset_n;
reg en;
wire out;
pwm pwm1(
.clk(clk),
.reset_n(reset_n),
.en(en),
.out(out)
);
initial clk = 1;
always #10 clk = !clk;
initial begin
reset_n = 0;
en = 1;
#201;
reset_n = 1;
#800000;
$stop;
end

endmodule
