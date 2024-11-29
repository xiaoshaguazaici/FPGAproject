/*
������m��ʽ
cnt = M-1;
cnt < M-1;
���һ�£��������ܵ�M
*/
/*
pwm�ĳ�ֵ
�� < m
*/
module m_counter#(
    parameter N = 4,
    parameter M = 10
)
(
    input clk,
    input reset_n,
    output [N-1:0]cnt,
    output reg out,
    output cout
    );
    reg [N-1:0]qd;
      
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            qd <= 0;
            out<=0;
         end
//��ʽ1
//        else if(qd == M-1)begin
//            qd <= 0;
//            out<=!out;
//        end            
//        else    
//            qd <= qd+1;
//��ʽ2
        else if(qd < M-1)
            qd <= qd+1;
        else begin
            qd <= 0;
            out<=!out;            
        end
    end
    assign cnt = qd;
    assign cout = (qd == M-1)?1:0;
endmodule