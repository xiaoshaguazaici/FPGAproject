module LSM_level#(
    parameter setcnt = 1_000,//10 000 000
    parameter outset = 8'b1010_1010

)
(
    input clk,
    input reset_n,
    output reg out
    );
//时间计数器
    reg [25:0]cnt;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)
            cnt = 0;
        else if(cnt == setcnt-1)
            cnt = 0;
        else
            cnt=cnt+1;
    end
//状态计数器8个状态
reg [2:0]status;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)
            status=0;
        //注意在判断周期尾数是0
        else if(cnt == 0)
            status = status+1;
    end
//控制output状态输出寄存器
    always @(posedge clk or negedge reset_n)begin
        if(!reset_n)
            out<=0;
        else begin
            case (status)
                3'd0:out <= outset[0];
                3'd1:out <= outset[1];
                3'd2:out <= outset[2];
                3'd3:out <= outset[3];

                3'd4:out <= outset[4];
                3'd5:out <= outset[5];
                3'd6:out <= outset[6];
                3'd7:out <= outset[7];
                default:out <= outset[0]; 
            endcase 
        end      
    end
        
        

endmodule
