module ID_reg(input clk, rst, flush, WB_EN_in, memory_read_en_in, memory_write_en_in,input [3 : 0] execute_cmd_in,input B, S,input [31 : 0] PC_in, Val_Rn_in, Val_Rm_in,input [11 : 0] Shift_operand_in,input imm_in,input [23 : 0] Signed_imm_in,input [3 : 0] Dest_in, SR_in,output reg WB_EN_out, memory_read_en, memory_write_en,output reg [3 : 0]  execute_cmd_out,output reg B_out, S_out,output reg [31 : 0] PC_out, Val_Rn_out, Val_Rm_out,output reg [11 : 0] Shift_operand_out,output reg imm_out,output reg [23 : 0] Signed_imm_out,output reg [3 : 0]  Dest_out, SR_out,input reg[3:0] src1,src2,output reg[3:0] src1_new,src2_new);
	always @(posedge clk) begin
		if(rst | flush) begin WB_EN_out <= 0; execute_cmd_out <= 0; Val_Rn_out <= 0; Val_Rm_out <= 0; B_out <= 0; S_out <= 0; PC_out <= 0; Signed_imm_out <= 0; Dest_out <= 0; SR_out <= 0; Shift_operand_out <= 0; imm_out <= 0; memory_read_en <= 0; memory_write_en <= 0; src1_new<=0; src2_new<=0;
		end 
		if(~(rst | flush)) begin Val_Rn_out <= Val_Rn_in; Val_Rm_out <= Val_Rm_in; WB_EN_out <= WB_EN_in; execute_cmd_out <= execute_cmd_in; Dest_out <= Dest_in; SR_out <= SR_in; B_out <= B; S_out <= S; PC_out <= PC_in; Shift_operand_out <= Shift_operand_in; imm_out <= imm_in; Signed_imm_out <= Signed_imm_in;memory_read_en <= memory_read_en_in; memory_write_en <= memory_write_en_in; src1_new<=src1; src2_new<=src2;
		end
	end
endmodule