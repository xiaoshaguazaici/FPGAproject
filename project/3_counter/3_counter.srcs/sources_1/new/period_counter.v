//用period翻转测试
//另一个always判断会慢一个周期由于前一个是非阻塞赋值（应阻塞赋值）
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
//方式1
//        else if(qd == M-1)
//            qd <= 0;            
//        else    
//            qd <= qd+1;
//方式2
        else if(qd < M-1)
            qd = qd+1;
        else 
            qd = 0;
        //另一个if
        //由于判断是基于qd的阻塞赋值，所以不用减1
        if (qd < M/2)
            out <= 1;
        else 
            out <= 0;    
    end
    assign cnt = qd;
    assign cout = (qd == M-1)?1:0;
endmodule