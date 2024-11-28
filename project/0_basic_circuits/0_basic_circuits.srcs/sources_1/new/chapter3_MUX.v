module  chapter3_MUX(
    input in1,in2,in3,in4,
    input s0,s1,
    output reg out
);
always@*
begin
    case ({s1,s0})
        2'd0:out = in1;
        2'd1:out = in2;
        2'd2:out = in3;
        2'd3:out = in4;
        default: out = in1;
    endcase
end
    
endmodule