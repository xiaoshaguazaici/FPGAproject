`timescale 1ns / 1ns
module encoder83_tb();
reg reset_n;
reg [7:0]in;
wire [2:0]out;

encoder83 encoder(
    .reset_n(reset_n),
    .in(in),
    .out(out)
);

initial begin
reset_n = 0;
#21;
reset_n = 1;
#20
in = 8'b0000_0001;#200;
in = 8'b0000_0010;#200;
in = 8'b0000_0100;#200;
in = 8'b0000_1000;#200;

in = 8'b0001_0000;#200;
in = 8'b0010_0000;#200;
in = 8'b0100_0000;#200;
in = 8'b1000_0000;#200;
$stop;
end
endmodule
