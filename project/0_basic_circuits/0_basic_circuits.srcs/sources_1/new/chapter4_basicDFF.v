//¡¶»ýÄ¾¡·P84

module chapter4_basicDFF(
    input clk,
    input d,
    output reg q
    );
    always @(posedge clk) begin
        q<=d;
    end
endmodule
