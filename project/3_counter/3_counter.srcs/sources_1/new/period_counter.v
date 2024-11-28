//��period��ת����
//��һ��always�жϻ���һ����������ǰһ���Ƿ�������ֵ��Ӧ������ֵ��
module period_counter#(
    parameter N = 4,
    parameter M = 10
)
(
    input clk,
    input reset_n,
    output [N-1:0]cnt,
    output cout,
    output reg out
    );
    reg [N-1:0]qd;
      
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            qd = 0;
            out <= 0;
        end
//��ʽ1
//        else if(qd == M-1)
//            qd <= 0;            
//        else    
//            qd <= qd+1;
//��ʽ2
        else if(qd < M-1)
            qd = qd+1;
        else 
            qd = 0;
        //��һ��if
        //�����ж��ǻ���qd��������ֵ�����Բ��ü�1
        if (qd < M/2)
            out <= 1;
        else 
            out <= 0;    
    end
    assign cnt = qd;
    assign cout = (qd == M-1)?1:0;
endmodule