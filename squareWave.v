module squareWave (clk, out);
  parameter desiredFreq = 440;
  parameter clkFreq = 50000000;
  // To get desired frequency out, we need to divide the clock
  // frequency.  However, because we will not always be dividing
  // by a power of 2, we can create a counter that counts up 
  // twice as fast as desired and toggle the output whenever
  // the counter reaches its maximum to get a 50% duty cycle
  // square wave at the desired frequency.
  parameter clkDivider = clkFreq/desiredFreq/2;

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


// module testSquareWave;
//     reg clk;
//     initial clk = 0;
//     always #10 clk = ~clk;

//     wire outG;
//     squareWave #(392) G4 (clk, outG);
//     wire outA;
//     squareWave #(440) A4 (clk, outA);
//     wire outB;
//     squareWave #(494) B4 (clk, outB);
//     wire outC;
//     squareWave #(523) C5 (clk, outC);
//     wire outD;
//     squareWave #(587) D5 (clk, outD);
// endmodule

module squareWaveBringup(clk, sw, gpioBank1);
  input clk;
  input[7:0] sw;
  output[3:0] gpioBank1;

  wire outG;
  squareWave #(392) G4 (clk, outG);
  assign gpioBank1[0] = outG & sw[7];

  wire outA;
  squareWave #(440) A4 (clk, outA);
  assign gpioBank1[1] = outA & sw[6];

  wire outB;
  squareWave #(494) B4 (clk, outB);
  assign gpioBank1[2] = outB & sw[5];

  wire outC;
  squareWave #(523) C4 (clk, outC);
  assign gpioBank1[3] = outC & sw[4];

endmodule