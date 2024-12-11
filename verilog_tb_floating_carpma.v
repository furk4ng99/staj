`timescale 1ns / 1ps

module tb_floating_point_carpma;

  reg clk;
  reg [63:0] carpan;
  reg [63:0] carpilan;
  wire [63:0] sonuc;


  always begin
    #5 clk = ~clk;
  end

  floating_carpma uut(
    .clk(clk),
    .carpan(carpan),
    .carpilan(carpilan),
    .sonuc(sonuc)
  );

  initial begin
  
    clk = 0;
    carpan = 64'b0100000000111001000000000000000000000000000000000000000000000000; // 5
    carpilan = 64'b10100000000101001100000000011101001010011101110001110010010111000; // 12.750445
	#100000000000
	
	
	$stop;
  end

endmodule
