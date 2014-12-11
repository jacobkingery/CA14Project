// lfsr module from http://stackoverflow.com/questions/757151/random-number-generation-on-spartan-3e
module lfsr(clk, reset, en, q);
  input clk, reset, en;
  output reg[7:0] q; 
  initial  q = 8'd1;

  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 8'd1; // can be anything except zero
    else if (en)
      q <= {q[6:0], q[7] ^ q[5] ^ q[4] ^ q[3]}; // polynomial for maximal LFSR
  end
endmodule

// module testNoiseWave;
//   reg clk;
//   initial clk = 0;
//   always #10 clk=~clk;

//   reg reset, en;
//   initial reset = 0;
//   initial en = 1;

//   wire[7:0] q;
//   lfsr noise (clk, reset, en, q);

//   wire sqG, outG;
//   squareWave #(392) G4 (clk, sqG);
//   assign outG = sqG ^ q[0];

//   wire sqA, outA;
//   squareWave #(440) A4 (clk, sqA);
//   assign outA = sqA ^ q[0];

//   wire sqB, outB;
//   squareWave #(494) B4 (clk, sqB);
//   assign outB = sqB ^ q[0];

//   wire sqC, outC;
//   squareWave #(523) C4 (clk, sqC);
//   assign outC = sqC ^ q[0];

// endmodule

module NoiseWaveBringup(clk, sw, gpioBank1);
  input clk;
  input[7:0] sw;
  output[3:0] gpioBank1;

  reg reset, en;
  initial reset = 0;
  initial en = 1;
  wire[7:0] q;
  lfsr noise (clk, reset, en, q);

  wire outG;
  squareWave #(392) G4 (clk, outG);
  assign gpioBank1[0] = (outG ^ q[0]) & sw[7] ;

  wire outA;
  squareWave #(440) A4 (clk, outA);
  assign gpioBank1[1] = (outA ^ q[0]) & sw[6] ;

  wire outB;
  squareWave #(494) B4 (clk, outB);
  assign gpioBank1[2] = (outB ^ q[0]) & sw[5];

  wire outC;
  squareWave #(523) C4 (clk, outC);
  assign gpioBank1[3] = (outC ^ q[0]) & sw[4];


endmodule