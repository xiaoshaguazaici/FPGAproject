`timescale 1ns / 1ns

module uart_loop_tb();

reg clk;
reg reset_n;
reg rxd;
wire txd;

uart_loop#(
    .CLK(50_000_000),
    .BAUND(115200)
)
uart
(
    .clk(clk),
    .reset_n(reset_n),
    .loop_rxd(rxd),
    .loop_txd(txd)
);

initial clk = 1;
always #10 clk =!clk;
initial begin
    reset_n =0;
    #200;
    reset_n =1;
    rxd = 1'b1;
    #201;
    rxd <= 1'b0;   //起始位
    #8680
    rxd <= 1'b1;   //D0
    #8680
    rxd <= 1'b0;   //D1
    #8680
    rxd <= 1'b1;   //D2
    #8680
    rxd <= 1'b0;   //D3
    #8680
    rxd <= 1'b1;   //D4
    #8680
    rxd <= 1'b0;   //D5
    #8680
    rxd <= 1'b1;   //D6
    #8680
    rxd <= 1'b0;   //D7 
    #8680
    rxd <= 1'b1;   //停止位
    #8680
    rxd <= 1'b1;   //空闲状态
#1000000



    rxd <= 1'b0;   //起始位
    #8680
    rxd <= 1'b1;   //D0
    #8680
    rxd <= 1'b1;   //D1
    #8680
    rxd <= 1'b1;   //D2
    #8680
    rxd <= 1'b1;   //D3
    #8680
    rxd <= 1'b1;   //D4
    #8680
    rxd <= 1'b0;   //D5
    #8680
    rxd <= 1'b1;   //D6
    #8680
    rxd <= 1'b0;   //D7 
    #8680
    rxd <= 1'b1;   //停止位
    #8680
    rxd <= 1'b1;   //空闲状态
#1000000
$stop;
end

endmodule
