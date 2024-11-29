//用period翻转测试
//另一个always判断会慢一个周期由于前一个是非阻塞赋值（应阻塞赋值）
//但是一般慢一个周期不影响，而且阻塞赋值会有问题，一般时序里面只会使用非阻塞
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
            qd <= 0;

        end
//方式1
//        else if(qd == M-1)
//            qd <= 0;            
//        else    
//            qd <= qd+1;
//方式2
        else if(qd < M-1)
            qd <= qd+1;
        else 
            qd <= 0;


    end

    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)
            out <= 0;
        else if (qd < M/2)
            out <= 1;
        else 
            out <= 0;    
    end
    assign cnt = qd;
    assign cout = (qd == M-1)?1:0;
endmodule