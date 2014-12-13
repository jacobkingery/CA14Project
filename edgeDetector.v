module edgeDetector(clk, in, pos, neg);
input clk, in;
output reg pos, neg;

reg buffer;
always @(posedge clk) begin
  buffer <= in;
  if (!(in == buffer)) begin
    if (in) begin
      pos <= 1;
      neg <= 0;
    end else begin
      neg <= 1;
      pos <= 0;
    end
  end else begin
    pos <= 0;
    neg <= 0;
  end
end
endmodule

module testEdgeDetector;
  reg clk;
  initial clk = 0;
  always #10 clk=~clk;

  reg in;
  initial in = 0;

  wire pos,neg;
  edgeDetector ED (clk, in, pos, neg);

  initial begin
    #40
    in=1;
    #100;
    in=0;
    #25
    in=1;
    #30
    in=0;
  end
endmodule
