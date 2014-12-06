module freqDiv (clk, out);
parameter clkDivider = 50000000/440/2;

input clk;
output reg out;
initial out = 0;

// Oversizing because why not
reg[31:0] counter;
initial counter = 0;

always @(posedge clk) begin
    if (counter == clkDivider-1) begin
        counter <= 0;
        out <= ~out;
    end else begin
        counter <= counter + 1;
    end
end
endmodule

module testFreqDiv;
reg clk;
initial clk = 0;
always #5 clk = ~clk;

wire out;

freqDiv DUT (clk, out);

endmodule