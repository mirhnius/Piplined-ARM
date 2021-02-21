module ARM(input clk, rst);
  wire freeze, Branch_taken, flush, WB_WB_EN,memory_read_en_in_WB,two_src,WB_EN, MEM_R_EN, memory_write_en, B, S, imm;
  wire [31:0] BranchAddr, WB_Value;
  wire [3:0] WB_Dest, SR,Rn, address_2,EXE_CMD_out, Dest_out, SR_out, Dest_in_mem,EXE_CMD, Dest, status;
  wire [31:0] PC_in_IF_reg, PC_in_ID, PC_in_ID_reg, PC_in_EX;
  wire [31:0] Instruction_in_IF_reg, Instruction_out;  
  wire [31:0] Val_Rn, Val_Rm, ALU_result, MEM_data_in_mem,Val_Rn_out, Val_Rm_out, ALU_result_in_mem, Val_Rm_in_mem,ALU_Res_in_WB, MEM_data_in_WB;
  wire [11:0] Shift_operand,Shift_operand_out;
  wire [23:0] Signed_imm_24,Signed_imm_24_out;
  wire WB_EN_out, MEM_R_EN_out, MEM_W_EN_out, S_out, imm_out, WB_EN_in_mem, memory_Read_en_in_mem, MEM_W_EN_in_mem; 
  wire [1:0] sel_src_1,sel_src_2;
  wire [3:0] src1,src2,src1_new,src2_new;
  IF_Stage IF_Stage(clk, rst, freeze, Branch_taken, BranchAddr, PC_in_IF_reg, Instruction_in_IF_reg);
  IF_Stage_Reg IF_Stage_Reg(clk, rst, freeze, Branch_taken, PC_in_IF_reg, Instruction_in_IF_reg, PC_in_ID, Instruction_out);  
  MEM MEM(clk, memory_Read_en_in_mem, MEM_W_EN_in_mem, ALU_result_in_mem, Val_Rm_in_mem, MEM_data_in_mem);
  MEM_reg MEM_reg(clk, rst, WB_EN_in_mem, memory_Read_en_in_mem, ALU_result_in_mem, MEM_data_in_mem, Dest_in_mem, WB_WB_EN, memory_read_en_in_WB, MEM_data_in_WB, ALU_Res_in_WB, WB_Dest);
  WB WB(memory_read_en_in_WB, ALU_Res_in_WB, MEM_data_in_WB, WB_Value);
  ID ID(clk, rst, PC_in_ID, Instruction_out, SR, WB_Dest, WB_Value, WB_WB_EN, WB_EN, MEM_R_EN, memory_write_en,  EXE_CMD, B, S, PC_in_ID_reg, Val_Rn, Val_Rm, Shift_operand, imm, Signed_imm_24, Dest, address_2, Rn, freeze, two_src,src1,src2);
  ID_reg ID_reg(clk, rst, Branch_taken, WB_EN, MEM_R_EN, memory_write_en, EXE_CMD, B, S, PC_in_ID_reg, Val_Rn, Val_Rm, Shift_operand, imm, Signed_imm_24, Dest, SR, WB_EN_out, MEM_R_EN_out, MEM_W_EN_out,  EXE_CMD_out, Branch_taken, S_out, PC_in_EX, Val_Rn_out, Val_Rm_out, Shift_operand_out, imm_out, Signed_imm_24_out, Dest_out, SR_out,src1,src2,src1_new,src2_new);
  
  
  Hazard Hazard(Rn, address_2, Dest_in_mem, Dest_out, two_src, WB_EN_in_mem, WB_EN_out, freeze,MEM_R_EN_out);
  
  forward forward(WB_EN_in_mem,WB_WB_EN, 	Dest_in_mem,WB_Dest,src1_new,src2_new,sel_src_1,sel_src_2);
  
  
  
  EX EX(clk, rst, EXE_CMD_out, MEM_R_EN_out, MEM_W_EN_out, PC_in_EX, Val_Rn_out, Val_Rm_out, imm_out, Shift_operand_out, Signed_imm_24_out, SR_out, ALU_result, BranchAddr, status,sel_src_1,sel_src_2,		WB_Value,ALU_result_in_mem);
  EXE_reg EXE_reg(clk, rst, WB_EN_out, MEM_R_EN_out, MEM_W_EN_out, ALU_result, Val_Rm_out, Dest_out, WB_EN_in_mem, memory_Read_en_in_mem, MEM_W_EN_in_mem, ALU_result_in_mem, Val_Rm_in_mem, Dest_in_mem);
  StatusRegister StatusRegister(clk, rst, S_out, status, SR);
endmodule
