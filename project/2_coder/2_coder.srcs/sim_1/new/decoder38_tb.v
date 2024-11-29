`timescale 1ns / 1ns

module decoder38_tb();
reg reset_n;
reg [2:0]in;
wire [7:0]out;

decoder38 encoder(
    .reset_n(reset_n),
    .in(in),
    .out(out)
);

initial begin
reset_n = 0;
#21;
reset_n = 1;
#20
in = 3'd0;#200;
in = 3'd1;#200;
in = 3'd2;#200;
in = 3'd3;#200;

in = 3'd4;#200;
in = 3'd5;#200;
in = 3'd6;#200;
in = 3'd7;#200;
$stop;
end
endmodule

