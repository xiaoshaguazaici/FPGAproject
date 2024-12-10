module uart_loop#(
    parameter CLK = 50_000_000,
    parameter BAUND = 19200
)
(
    input clk,
    input reset_n,
    input loop_rxd,
    output loop_txd
    );
wire [7:0]rx_data;
wire rx_done;
//重要输出口
reg loop_done;
reg loop_busy;

uart_rx
#(
    .baund(BAUND),
    .clk_50Mhz(CLK)

) 
uart_rx
(
.clk(clk),
.reset_n(reset_n),
.rxd(loop_rxd),
.rx_data(rx_data),
.rx_done(rx_done)//很重要是后面接受的判断标志
);


uart_tx
#(
    .baund(BAUND),
    .clk_50Mhz(CLK)

)
uart_tx
(
    .clk(clk),
    .reset_n(reset_n),
    .tx_data(rx_data),
    .tx_en(rx_done),
    .tx_busy(),
    .tx_done(),
    .txd(loop_txd)
);


endmodule