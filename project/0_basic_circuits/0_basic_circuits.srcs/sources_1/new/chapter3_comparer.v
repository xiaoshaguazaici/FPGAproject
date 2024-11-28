module chapter3_comparer #(
    parameter N = 8
)(
    input [N-1:0]in0,in1,
    output reg gt,eq,lt
);
always @*begin
    //每一次电平切换都是赋予0初始值
    gt = 0;
    eq = 0;
    lt = 0;
    //使用三if还是一个if else结构  （待论证）我觉得三if合适表示并行逻辑
    if(in0 > in1)
        gt = 1;
    if(in0 == in1)
        eq = 1;
    if(in0 < in1)
        lt = 1;
end
endmodule