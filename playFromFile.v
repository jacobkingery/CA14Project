module playFromFile(clk, gpioBank1, gpioBank2, gpioBank3);
  parameter song_len = 12;
  parameter encoding_len = 12;
  parameter note_frequency = 1;

  input clk;
  output[3:0] gpioBank1, gpioBank2, gpioBank3;


  reg[5:0] Addr;
  initial Addr = 6'b0;
  wire[encoding_len-1:0] notes;
  songMemory sMem (clk, Addr, notes);

  wire metronome, posMet, negMet;
  squareWave #(note_frequency) tempo (clk, metronome);
  edgeDetector tempo_edge (clk, metronome, posMet, negMet);

  keyboardBringup keyboard (clk, notes[11:4], notes[3:0], gpioBank1, gpioBank2, gpioBank3);

  always @(posedge clk) begin
      Addr <= Addr + posMet;
      if (Addr == song_len) begin
        Addr <= 6'b0;
      end
  end

endmodule

// module testPlayFromFile;
//   reg clk;
//   initial clk = 0;
//   always #10 clk = ~clk;

//   wire[3:0] outBank1, outBank2, outBank3;

//   playFromFile #(12,12,10000) pFF (clk, outBank1, outBank2, outBank3);

// endmodule