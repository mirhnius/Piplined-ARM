`timescale 1ps/1ps
module TB();
  reg clk = 0;
  reg reset ;

  initial begin
    reset = 1;
    #35 reset = 0;
    #8000
    $stop;
  end

  always #10 clk = ~clk;
  ARM arm(clk, reset);


endmodule
