`timescale 1ns / 1ns
module period_counter_tb();
reg reset_n;
reg clk;
wire [3:0]cnt;
wire cout;
wire out;
period_counter counter(
    .reset_n(reset_n),
    .clk(clk),
    .cnt(cnt),
    .cout(cout),
    .out(out)
);
initial clk =1;
always #10 clk = !clk;
initial begin
    reset_n = 0;
    #201;
    reset_n = 1;
    #10000;
    
end
endmodule
