/*
ע�⣺
1.��Ƶʱ�� ��Ҫ�ó�clk��
2.reset ��ʼֵҪ����ʹ����������1���½�����0��
3.�ж�ֵ��ʹ�� ��+1 -1(������)���ǣ�С�ڣ���ƽ��ת��<duty
*/

module pwm#(
   parameter N = 10,//10��Ƶ 
   parameter M = 100,//100��װֵ
   parameter duty = 30//ռ�ձ�
)
(
    input clk,
    input reset_n,
    input en,
    output out,
    output [25:0]now_cnt
    );
//---------------------------------��÷�Ƶʱ��
reg[25:0] ck_psc;//��Ƶ��������
//parameter N = 10-1;//10��Ƶ
reg psc_clk;//��Ƶ��ʱ��
always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        ck_psc<=0;
    else if(!en)
        ck_psc<=0;
        //��enһ��Ҫ���㲻Ȼ����Ŀ��ܻῪʼ������ʼֵ����0
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
        //ע���ʼʱ������
    else if(en)begin
        if(ck_psc<N/2)//0 1
            psc_clk = 1;
        else
            psc_clk = 0;
    end


end
//---------------------------------����������arr��װ�غͱȽ�
reg[25:0] cnt;//��Ƶ��������
//parameter M = 100-1;//100��װֵ
//parameter duty = 30-1;//ռ�ձ�
reg pwm;//��Ƶ��ʱ��
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
            //���������һ�������ػ��ȼ�1���Ե�һ����������һ�����ڵ�
            //�������������Ч����ô��Ҫ��Ƶʱ��һ��ʼ��0
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
