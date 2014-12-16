module noiseTestBringup(clk, sw, btn, gpioBank1, gpioBank2);
  input clk;
  input[7:0] sw;
  input[3:0] btn;
  output[3:0] gpioBank1, gpioBank2;

  reg reset, en;
  initial reset = 0;
  initial en = 1;

  assign gpioBank1 = sw[7:4];

  // Noise
  wire nsqG, nposG, nnegG;
  wire[7:0] qG;
  lfsr noiseG (clk, reset, nposG, qG);
  squareWave #(440) nG4 (clk, nsqG);
  edgeDetector ED_G (clk, nsqG, nposG, nnegG);
  assign gpioBank2[0] = qG[0] & btn[3];

  wire nsqA, nposA, nnegA;
  wire[7:0] qA;
  lfsr noiseA (clk, reset, nposA, qA);
  squareWave #(659) nA4 (clk, nsqA);
  edgeDetector ED_A (clk, nsqA, nposA, nnegA);
  assign gpioBank2[1] = qA[0] & btn[2];

  wire nsqB, nposB, nnegB;
  wire[7:0] qB;
  lfsr noiseB (clk, reset, nposB, qB);
  squareWave #(880) nB4 (clk, nsqB);
  edgeDetector ED_B (clk, nsqB, nposB, nnegB);
  assign gpioBank2[2] = qB[0] & btn[1];

  wire nsqC, nposC, nnegC;
  wire[7:0] qC;
  lfsr noiseC (clk, reset, nposC, qC);
  squareWave #(659*2) nC4 (clk, nsqC);
  edgeDetector ED_C (clk, nsqC, nposC, nnegC);
  assign gpioBank2[3] = qC[0] & btn[0];

endmodule
