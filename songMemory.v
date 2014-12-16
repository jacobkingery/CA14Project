module songMemory(clk, Addr, DataOut);
  parameter song_len = 12;
  parameter encoding_len = 12;

  input clk;
  input[5:0] Addr;
  output[encoding_len-1:0] DataOut;
 
  reg [encoding_len-1:0] mem[song_len-1:0];
  initial begin 
    $readmemb("increasing.dat", mem);
  end

  assign DataOut = mem[Addr];
endmodule

module testSongMemory;
  reg clk;
  initial clk = 0;
  always #10 clk = ~clk;

  reg[5:0] Addr;
  initial Addr = 6'b0;
  wire[11:0] notes;  
  songMemory sMem (clk, Addr, notes);

  always #100 Addr = Addr + 1;

endmodule