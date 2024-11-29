/*
普通计数器，简单的计数，超位清零
周期是2**N(形成一个环形)
只能使用要进位的数字1111，如果是不进位就用不了1001
所有有了模m计数器
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
