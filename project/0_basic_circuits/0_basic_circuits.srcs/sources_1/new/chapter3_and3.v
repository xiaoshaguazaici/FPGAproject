module chapter3_and3(
    input a,b,c,
    output reg y
);   
always @* begin 
    //用y做临时变量了
    y=a;
    y=a&b;
    y=y&c;
    
end
endmodule

/*

module chapter3_and3(
    input  a,b,c,
    output  Y
); 
assign y =a&b&c;//方法1
endmodule
*/

