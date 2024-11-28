/*
��ͨ���������򵥵ļ�������λ����
������2**N(�γ�һ������)
ֻ��ʹ��Ҫ��λ������1111������ǲ���λ���ò���1001
��������ģm������
*/
module basic_counter#(
    parameter N = 3
)
(
    input clk,
    input reset_n,
    output [N-1:0]cnt,
    output cout
    );
    reg [N-1:0]qd;
      
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)
            qd <= 0;
        else    
            qd <= qd+1;
    end
    assign cnt = qd;
    assign cout = (qd == 2**N-1)?1:0;
endmodule
