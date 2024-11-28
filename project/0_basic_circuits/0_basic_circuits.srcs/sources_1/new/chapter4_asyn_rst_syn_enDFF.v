//¡¶»ý¡·P87
module chapter4_asyn_rst_syn_enDFF(
    input clk,
    input reset_n,
    input en,
    input d,
    output reg q
    );
    always @(posedge clk or negedge reset_n) begin
    if(!reset_n)
        q<=0;
    else if(en)
        q<=d;

    end
endmodule
