/*
关于case输入状态要写全，这样才可以没有锁存器
扩展到if else if else(可以赋予初值)
*/
module encoder83(
    input [7:0]in,
    input reset_n,
    output reg[2:0]out
    );
    always @* begin
        if(!reset_n)
            out = 3'b0;
        else begin
        case (in)
            8'b0000_0001:out = 3'd0;
            8'b0000_0010:out = 3'd1;
            8'b0000_0100:out = 3'd2;
            8'b0000_1000:out = 3'd3;
            8'b0001_0000:out = 3'd4;
            8'b0010_0000:out = 3'd5;
            8'b0100_0000:out = 3'd6; 
            8'b1000_0000:out = 3'd7;            
            default:out = 3'b0; 
        endcase
        end
        
    end


endmodule
