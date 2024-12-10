module uart_rx(
    input clk,
    input reset_n,
    input rxd,
    output reg [7:0]rx_data,
    output reg rx_done//很重要是后面接受的判断标志
);
//参数设置
parameter baund = 115200;
parameter clk_50Mhz = 50_000_000;
localparam baund_cnt_max = clk_50Mhz/baund; 


//只要有 <=别嫌弃麻烦，要用reset_n
//1先对数据进行采集下降沿（常高，低电平开始）三级同步采沿
reg[2:0]rx_pcs;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        rx_pcs <= 3'b0;
    else
        rx_pcs <={rx_pcs[1:0],rxd};
end

//1.1数据使用【会慢一个时钟】
reg rxd_use;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        rxd_use <= 1'b0;
    else
        rxd_use <= rx_pcs[2];
    
end


//2定义开始接受和结束接受的标志位
wire start_en;
reg rx_flag;
assign start_en = rx_pcs[2] && (~rx_pcs[1]) &&(~rx_flag);

//3波特率需要计数器开始计数标志(需要计数)

//需要写前面
reg [18:0]baund_cnt;
reg [3:0]data_cnt;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        rx_flag <= 1'b0;
    else if(start_en)
        rx_flag <=1'b1;
//    else if(rxd_done)//////////////////////////问题
    else if((data_cnt ==4'd9) && (baund_cnt == baund_cnt_max/2+baund_cnt_max/4-1'b1))//可以是3/4
        rx_flag <= 1'b0;
    else 
        rx_flag <=rx_flag;
end

//4波特率计数器
//reg [18:0]baund_cnt;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        baund_cnt <= 19'd0;
    else if(rx_flag) begin
        if(baund_cnt == baund_cnt_max-1'b1)
            baund_cnt <= 19'd0;
        else
            baund_cnt <=baund_cnt + 1'b1;
    end
    else 
        baund_cnt <= 19'd0;//注意清零

end

//5开始接受数据到缓存区
//reg [3:0]data_cnt;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        data_cnt <= 4'd0;
    else if(rx_flag)begin
        if(baund_cnt == baund_cnt_max-1)
            data_cnt <= data_cnt + 1'b1;
        else
            data_cnt <= data_cnt;
    end
    else 
        data_cnt <= 4'd0;

    end
    


//6缓存区发送数据以及标志位

reg [7:0]rx_tem_data;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        rx_tem_data <= 8'd0;
    else if(rx_flag)begin
        if(baund_cnt == baund_cnt_max/2 -1'b1)begin
            case(data_cnt)
            4'd1:rx_tem_data[0] <= rxd_use;
            4'd2:rx_tem_data[1] <= rxd_use;
            4'd3:rx_tem_data[2] <= rxd_use;       
            4'd4:rx_tem_data[3] <= rxd_use;       
            4'd5:rx_tem_data[4] <= rxd_use;       
            4'd6:rx_tem_data[5] <= rxd_use;       
            4'd7:rx_tem_data[6] <= rxd_use;       
            4'd8:rx_tem_data[7] <= rxd_use;       
            default:;
            endcase
        end
        else
            rx_tem_data <=rx_tem_data;
    end
    else 
        rx_tem_data <= 8'd0;
    
end

//数据接受结束标志位和数据发送
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)begin
        rx_done <= 1'b0;
        rx_data <= 8'd0;
    end
    else if(data_cnt == 4'd9 && baund_cnt ==baund_cnt_max/2+baund_cnt_max/4 -1'b1)begin
        rx_done <= 1'b1;//出现一个周期
        rx_data <=rx_tem_data;
    end
    else begin
        rx_done <= 1'b0;
        //re_data数据维持
        rx_data <=rx_data;
    end
end

endmodule
