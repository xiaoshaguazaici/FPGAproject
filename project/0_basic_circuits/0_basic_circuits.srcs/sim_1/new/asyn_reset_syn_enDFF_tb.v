`timescale 1ns / 1ns

module asyn_reset_syn_enDFF_tb ();
reg clk;
reg reset_n;
reg en;
reg d;
wire q;
chapter4_asyn_rst_syn_enDFF asyn_rst_syn_enDFF(
    .clk(clk),
    .reset_n(reset_n),
    .en(en),
    .d(d),
    .q(q)

);

initial clk = 1;
always #10 clk = !clk;
initial begin
reset_n = 0;

#201
reset_n = 1;
d = 1;
#200;
d = 0;
#200;
d = 1;
#200;
en =1;
#100
d = 1;
#200;
d = 0;
#200;
d = 1;
#200;
end 
endmodule
