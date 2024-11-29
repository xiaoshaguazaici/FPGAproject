`timescale 1ns / 1ns
module LSM_level_tb();
reg reset_n;
reg clk;
wire out;
LSM_level level(
    .reset_n(reset_n),
    .clk(clk),
    .out(out)
);

initial clk = 1;
always #10 clk = !clk;
initial begin
reset_n = 0;
#201;
reset_n = 1;
#200000;
    

end
endmodule
