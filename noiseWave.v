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
//   always #1 clk=~clk;

//   reg reset, en;
//   initial reset = 0;
//   initial en = 1;

//   wire sqG, outG, posG, negG;
//   wire[7:0] qG;
//   lfsr noiseG (clk, reset, posG, qG);
//   squareWave #(392) G4 (clk, sqG);
//   edgeDetector ED_G (clk, sqG, posG, negG);
//   assign outG = qG[0];

//   wire sqA, outA, posA, negA;
//   wire[7:0] qA;
//   lfsr noiseA (clk, reset, posA, qA);
//   squareWave #(440) A4 (clk, sqA);
//   edgeDetector ED_A (clk, sqA, posA, negA);
//   assign outA = qA[0];

//   wire sqB, outB, posB, negB;
//   wire[7:0] qB;
//   lfsr noiseB (clk, reset, posB, qB);
//   squareWave #(494) B4 (clk, sqB);
//   edgeDetector ED_B (clk, sqB, posB, negB);
//   assign outB = qB[0];

//   wire sqC, outC, posC, negC;
//   wire[7:0] qC;
//   lfsr noiseC (clk, reset, posC, qC);
//   squareWave #(523) C4 (clk, sqC);
//   edgeDetector ED_C (clk, sqC, posC, negC);
//   assign outC = qC[0];

// endmodule

module NoiseWaveBringup(clk, sw, gpioBank1);
  input clk;
  input[7:0] sw;
  output[3:0] gpioBank1;

  reg reset, en;
  initial reset = 0;
  initial en = 1;

  wire sqG, posG, negG;
  wire[7:0] qG;
  lfsr noiseG (clk, reset, posG, qG);
  squareWave #(392*8) G4 (clk, sqG);
  edgeDetector ED_G (clk, sqG, posG, negG);
  assign gpioBank1[0] = qG[0] & sw[7];

  wire sqA, posA, negA;
  wire[7:0] qA;
  lfsr noiseA (clk, reset, posA, qA);
  squareWave #(440*8) A4 (clk, sqA);
  edgeDetector ED_A (clk, sqA, posA, negA);
  assign gpioBank1[1] = qA[0] & sw[6];

  wire sqB, posB, negB;
  wire[7:0] qB;
  lfsr noiseB (clk, reset, posB, qB);
  squareWave #(494*8) B4 (clk, sqB);
  edgeDetector ED_B (clk, sqB, posB, negB);
  assign gpioBank1[2] = qB[0] & sw[5];

  wire sqC, posC, negC;
  wire[7:0] qC;
  lfsr noiseC (clk, reset, posC, qC);
  squareWave #(523*8) C4 (clk, sqC);
  edgeDetector ED_C (clk, sqC, posC, negC);
  assign gpioBank1[3] = qC[0] & sw[4];


endmodule