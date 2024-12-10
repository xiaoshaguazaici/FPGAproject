module uart_tx(
    input clk,
    input reset_n,
    input [7:0]tx_data,
    input tx_en,
    output reg tx_busy,
    output reg tx_done,
    output reg txd
    );

//参数设置
parameter baund = 115200;
parameter clk_50Mhz = 50_000_000;
localparam baund_cnt_max = clk_50Mhz/baund; 

//1采集使能上升沿
reg[2:0]en_pcs;
wire en_use;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        en_pcs <= 3'd0;
    else
        en_pcs <= {en_pcs[1:0],tx_en};
end

assign en_use = en_pcs[2] && (~en_pcs[1]) && (~tx_busy);


//2发送使能状态判断,在这个时候进行数据缓存
reg[18:0] baund_cnt;
reg[3:0] data_cnt;

reg [7:0]tx_tem_data;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)begin
        tx_busy <= 0;
        tx_tem_data <= 8'd0;
    end
    else if(en_use)begin
        tx_busy <= 1;
        tx_tem_data <= tx_data;
    end
    else if((data_cnt ==4'd9) && (baund_cnt == baund_cnt_max-baund_cnt_max/16-1'b1))begin//希望他提前发结束
        tx_busy <= 0;
        tx_tem_data <= 8'd0;
    end
    else begin
        tx_busy <= tx_busy;
        tx_tem_data <= tx_tem_data;
    end
end

//3波特率开始计数


always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        baund_cnt <= 19'd0;
    else if(tx_busy)begin
        if(baund_cnt == baund_cnt_max - 1'b1)
            baund_cnt <= 19'd0;
        else 
            baund_cnt <= baund_cnt + 1'b1;
    end
    else
        baund_cnt <= 19'd0;

end

//4数据计数器

always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        data_cnt <= 4'd0;
    else if(tx_busy)begin
        if(baund_cnt == baund_cnt_max -1'b1 )
            data_cnt <= data_cnt + 1'b1;
        else 
            data_cnt <= data_cnt;
    end
    else
        data_cnt <= 4'd0;

end

//5数据发送

always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        txd <= 1;//注意常1
    else if(tx_busy)
        case (data_cnt)

            4'd0:txd <= 1'b0;
            4'd1:txd <= tx_tem_data[0];
            4'd2:txd <= tx_tem_data[1];
            4'd3:txd <= tx_tem_data[2];
            4'd4:txd <= tx_tem_data[3];
            4'd5:txd <= tx_tem_data[4];
            4'd6:txd <= tx_tem_data[5];
            4'd7:txd <= tx_tem_data[6];
            4'd8:txd <= tx_tem_data[7];
            4'd9:txd <= 1'b1;
            default: txd <= 1;//注意常1;
        endcase
    else
        txd <= 1;

    
end

//6结束发送标志位

always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        tx_done <= 1'b0;
    else if((data_cnt ==4'd9) && (baund_cnt == baund_cnt_max-baund_cnt_max/16-1'b1))
        tx_done <= 1'b1;
    else
        tx_done <= 1'b0;

end


endmodule
