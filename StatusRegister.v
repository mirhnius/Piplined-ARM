module StatusRegister(input clk, reset, S, input[3:0] status, output reg [3:0] SR);
  
  always @(negedge clk or posedge reset ) begin
		if(reset)
			SR <= 4'b0;
		else if(S)
			SR <= status;
		else
			SR <= SR;
		
  end

endmodule
