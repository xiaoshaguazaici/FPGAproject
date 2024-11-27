module pwm(
    input clk,
    input reset_n,
    input en,
    output out
    );
//---------------------------------��÷�Ƶʱ��
reg[25:0] ck_psc;//��Ƶ��������
parameter N = 10-1;//10��Ƶ
reg psc_clk;//��Ƶ��ʱ��
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
//---------------------------------����������arr��װ�غͱȽ�
reg[25:0] cnt;//��Ƶ��������
parameter M = 100-1;//100��װֵ
parameter duty = 30-1;
reg pwm;//��Ƶ��ʱ��
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
