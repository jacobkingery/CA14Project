module halfAndHalfBringup(clk, sw, gpioBank1, gpioBank2);
  input clk;
  input[7:0] sw;
  output[3:0] gpioBank1, gpioBank2;

  reg reset, en;
  initial reset = 0;
  initial en = 1;


  // Square
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

  // Noise
  wire nsqG, nposG, nnegG;
  wire[7:0] qG;
  lfsr noiseG (clk, reset, nposG, qG);
  squareWave #(392*8) nG4 (clk, nsqG);
  edgeDetector ED_G (clk, nsqG, nposG, nnegG);
  assign gpioBank2[0] = qG[0] & sw[3];

  wire nsqA, nposA, nnegA;
  wire[7:0] qA;
  lfsr noiseA (clk, reset, nposA, qA);
  squareWave #(440*8) nA4 (clk, nsqA);
  edgeDetector ED_A (clk, nsqA, nposA, nnegA);
  assign gpioBank2[1] = qA[0] & sw[2];

  wire nsqB, nposB, nnegB;
  wire[7:0] qB;
  lfsr noiseB (clk, reset, nposB, qB);
  squareWave #(494*8) nB4 (clk, nsqB);
  edgeDetector ED_B (clk, nsqB, nposB, nnegB);
  assign gpioBank2[2] = qB[0] & sw[1];

  wire nsqC, nposC, nnegC;
  wire[7:0] qC;
  lfsr noiseC (clk, reset, nposC, qC);
  squareWave #(523*8) nC4 (clk, nsqC);
  edgeDetector ED_C (clk, nsqC, nposC, nnegC);
  assign gpioBank2[3] = qC[0] & sw[0];

endmodule
