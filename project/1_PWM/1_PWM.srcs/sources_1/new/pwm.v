/*
注意：
1.分频时钟 不要用成clk；
2.reset 初始值要考虑使用上升沿用1，下降沿用0；
3.判断值的使用 是+1 -1(计数器)还是；小于（电平翻转）<duty
*/

module pwm#(
   parameter N = 10,//10分频 
   parameter M = 100,//100重装值
   parameter duty = 30//占空比
)
(
    input clk,
    input reset_n,
    input en,
    output out,
    output [25:0]now_cnt
    );
//---------------------------------获得分频时钟
reg[25:0] ck_psc;//分频器计数器
//parameter N = 10-1;//10分频
reg psc_clk;//分频后时钟
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        ck_psc<=0;
    else if(!en)
        ck_psc<=0;
        //非en一定要清零不然后面的可能会开始计数初始值不是0
    else if(en)begin
        if(ck_psc==N-1)
            ck_psc<=0;
        else
            ck_psc<=ck_psc+1;
    end

end

always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        psc_clk = 1;
        //注意初始时钟设置
    else if(en)begin
        if(ck_psc<N/2)//0 1
            psc_clk = 1;
        else
            psc_clk = 0;
    end


end
//---------------------------------计数器用于arr重装载和比较
reg[25:0] cnt;//分频器计数器
//parameter M = 100-1;//100重装值
//parameter duty = 30-1;//占空比
reg pwm;//分频后时钟
always @(posedge psc_clk or negedge reset_n) begin
    if(!reset_n)
        cnt<=0;
    else if(!en)
        cnt<=0;
    else if(en)begin
        if(cnt==M-1)
            cnt<=0;
        else
            cnt<=cnt+1;
            //由于这里第一次上升沿会先加1所以第一个方波是少一个周期的
            //如果是上升沿有效，那么需要分频时钟一开始是0
    end
end

always @(posedge psc_clk or negedge reset_n) begin
    if(!reset_n)
        pwm <= 0;
    else if(en)begin
        if(cnt<duty)//0 1
            pwm <= 1;
        else
            pwm <= 0;
    end
end
assign out = pwm;
assign now_cnt = cnt;


endmodule
