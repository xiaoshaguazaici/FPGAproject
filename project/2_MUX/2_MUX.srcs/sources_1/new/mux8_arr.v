module mux8_arr(
    input reset_n,
    input [7:0]in0,
    input [7:0]in1,
    input [7:0]in2,    
    input [7:0]in3,
    input [7:0]in4,
    input [7:0]in5,
    input [7:0]in6,
    input [7:0]in7,

    input [2:0]sel,
    output reg [7:0]out
    );
    always @(*) begin
        if(!reset_n)
            out<=0;
        else
            case (sel)
                3'd0:out<=in0;
                3'd1:out<=in1;
                3'd2:out<=in2;
                3'd3:out<=in3;
                3'd4:out<=in4;
                3'd5:out<=in5;
                3'd6:out<=in6;
                3'd7:out<=in7;
                default:out<=0;
            endcase
    end
endmodule