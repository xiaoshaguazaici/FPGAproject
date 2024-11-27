module pwm(
    input clk,
    input reset_n,
    input en,
    output out
    );
//---------------------------------获得分频时钟
reg[25:0] ck_psc;//分频器计数器
parameter N = 10-1;//10分频
reg psc_clk;//分频后时钟
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        ck_psc<=0;
    else if(ck_psc==N)
        ck_psc<=0;
    else
        ck_psc<=ck_psc+1;
end

always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        psc_clk = 0;
    else if(ck_psc<(N>>1))//0 1
        psc_clk = 1;
    else
        psc_clk = 0;
end
//---------------------------------计数器用于arr重装载和比较
reg[25:0] cnt;//分频器计数器
parameter M = 100-1;//100重装值
parameter duty = 30-1;
reg pwm;//分频后时钟
always @(posedge psc_clk or negedge reset_n) begin
    if(!reset_n)
        cnt<=0;
    else if(cnt==M)
        cnt<=0;
    else
        cnt<=cnt+1;
end

always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        pwm = 0;
    else if(cnt<duty)//0 1
        pwm = 1;
    else
        pwm = 0;
end
assign out = pwm;


endmodule
