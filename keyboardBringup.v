module keyboardBringup(clk, sw, btn, gpioBank1, gpioBank2, gpioBank3);
  input clk;
  input[7:0] sw;
  input[3:0] btn;
  output[3:0] gpioBank1, gpioBank2, gpioBank3;

  reg reset, en;
  initial reset = 0;
  initial en = 1;

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
  squareWave #(523) C5 (clk, outC);
  assign gpioBank1[3] = outC & sw[4];

  wire outD;
  squareWave #(587) D5 (clk, outD);
  assign gpioBank2[0] = outD & sw[3];

  wire outE;
  squareWave #(659) E5 (clk, outE);
  assign gpioBank2[1] = outE & sw[2];

  wire outFs;
  squareWave #(740) Fs5 (clk, outFs);
  assign gpioBank2[2] = outFs & sw[1];

  wire outGG;
  squareWave #(784) G5 (clk, outGG);
  assign gpioBank2[3] = outGG & sw[0];

  // Noise
  wire nsqG, nposG, nnegG;
  wire[7:0] qG;
  lfsr noiseG (clk, reset, nposG, qG);
  squareWave #(440) nG4 (clk, nsqG);
  edgeDetector ED_G (clk, nsqG, nposG, nnegG);
  assign gpioBank3[0] = qG[0] & btn[3];

  wire nsqA, nposA, nnegA;
  wire[7:0] qA;
  lfsr noiseA (clk, reset, nposA, qA);
  squareWave #(659) nA4 (clk, nsqA);
  edgeDetector ED_A (clk, nsqA, nposA, nnegA);
  assign gpioBank3[1] = qA[0] & btn[2];

  wire nsqB, nposB, nnegB;
  wire[7:0] qB;
  lfsr noiseB (clk, reset, nposB, qB);
  squareWave #(880) nB4 (clk, nsqB);
  edgeDetector ED_B (clk, nsqB, nposB, nnegB);
  assign gpioBank3[2] = qB[0] & btn[1];

  wire nsqC, nposC, nnegC;
  wire[7:0] qC;
  lfsr noiseC (clk, reset, nposC, qC);
  squareWave #(659*2) nC4 (clk, nsqC);
  edgeDetector ED_C (clk, nsqC, nposC, nnegC);
  assign gpioBank3[3] = qC[0] & btn[0];

endmodule
