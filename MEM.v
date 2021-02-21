module MEM(input clk,input  MEM_R_EN_in, input MEM_W_EN_in,input [31 : 0] ALU_Res_in, input [31 : 0] Val_Rm,output [31 : 0] MEM_data_out);

	Memory Memory(Val_Rm, ALU_Res_in, MEM_W_EN_in, MEM_R_EN_in, clk, MEM_data_out);
endmodule

