`timescale 1ns / 1ns

module key_filter_tb();
reg clk;
reg reset_n;
reg in;
wire out;
wire press_flag;
wire reset_flag;
key_filter key(
    .clk(clk),
    .reset_n(reset_n),
    .in(in),
    .out(out),
    .press_flag(press_flag),
    .reset_flag(reset_flag)
);
initial clk = 1;
always #10 clk = !clk;
initial begin
    reset_n = 0;
    in = 1;
    #20000;
    reset_n = 1;
    press_thing(14);
    $stop;   
end


reg[31:0]rand;

task press_thing;
    input[3:0]seed;
    begin
        in = 1;
        #20000000;//ÎÈ¶¨ 
        repeat(5)begin
            rand = {$random(seed)} %10000000;//¶¶¶¯
            #rand in=!in;
        end
        in = 0;
        #40000000;
        repeat(5)begin
            rand = {$random(seed)} %10000000;//¶¶¶¯
            #rand in=!in;
        end
        in = 1;
        #40000000;        
    end
endtask
endmodule
