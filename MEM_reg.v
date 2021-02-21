module MEM_reg(input clk, input reset,input WBen1, input MRen1, input [31 : 0] ALU1, input [31 : 0] M_data1, input [3:0] dest1,output reg WBen2,output reg MRen2,output reg [31 : 0] M_data2,output reg [31 : 0] ALU2,output reg [3:0] dest2);

	always @(posedge clk or posedge reset) begin
		if(reset) begin
			{WBen2,MRen2,M_data2,ALU2,dest2} = 0;
		end 
		else begin
			WBen2 <= WBen1;
			MRen2 <= MRen1;
			M_data2<= M_data1;
			ALU2 <= ALU1;
			dest2 <= dest1;
		end
	end
endmodule
