module chapter3_full_adder (
    input A,B,Cin,
    output Sum,Cout
);   
    assign Sum =A^B^Cin; 
    assign Cout =A&B+B&Cin+A&Cin;
endmodule