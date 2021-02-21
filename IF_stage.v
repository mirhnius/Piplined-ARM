module IF_Stage(input clk, reset, freeze, Branch_taken, input [31:0] BranchAddr, output reg [31:0] PC, output [31:0] Instruction);
	wire [31:0] PC_in;
	InstructionMeM InstructionMeM(PC, Instruction);
	MUX2 MUX2 (BranchAddr,PC,Branch_taken,PC_in);
	always @(posedge clk or posedge reset)
	begin
		if(reset)
			PC <= 32'b0;
		else if(freeze)
			PC <= PC_in;
		else
			PC <= PC_in + 32'd4;
	end
endmodule
 