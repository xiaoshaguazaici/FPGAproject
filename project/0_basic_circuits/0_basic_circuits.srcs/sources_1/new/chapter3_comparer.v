module chapter3_comparer #(
    parameter N = 8
)(
    input [N-1:0]in0,in1,
    output reg gt,eq,lt
);
always @*begin
    //ÿһ�ε�ƽ�л����Ǹ���0��ʼֵ
    gt = 0;
    eq = 0;
    lt = 0;
    //ʹ����if����һ��if else�ṹ  ������֤���Ҿ�����if���ʱ�ʾ�����߼�
    if(in0 > in1)
        gt = 1;
    if(in0 == in1)
        eq = 1;
    if(in0 < in1)
        lt = 1;
end
endmodule