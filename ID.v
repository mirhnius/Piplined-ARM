module ID(input clk, rst,input [31 : 0] PC_in, INST,input [3:0] SR, Dest_wb,input [31 : 0] Result_WB,input writeBackEn,output WB_en, memoty_read_en, memoty_write_en,output [3:0] EXE_CMD_out,output B_out, S_out,output [31 : 0] PC_out, Val_Rn_out, Val_Rm_out,output [11:0] Shift_operand_out,output imm_out,output [23 : 0] Signed_imm_24_out,output [3:0]  Dest,src2, Rn,input hazard,output two_src,output[3:0] src1,src3  );
	wire cnd, mem_read, mem_write, wb_en, state_out, b;
	wire [3:0] EXE_CMD;
	
	assign PC_out = PC_in;
	assign Rn = INST[19:16];
	assign two_src = (~imm_out) | memoty_write_en;	
	assign WB_en = ~((~cnd) | hazard)? wb_en: 0;
	assign S_out = ~((~cnd) | hazard)? state_out:0 ;
	assign B_out = ~((~cnd) | hazard)? b: 0;	
	assign src1 = INST [19:16];
	assign src2 = (memoty_write_en==0)? INST [3:0]:INST [15:12] ;
	assign src3=src2;
	assign Shift_operand_out = INST[11:0];
	assign imm_out = INST[25];
	assign Dest = INST[15:12];
	assign Signed_imm_24_out = INST[23:0];
	assign memoty_read_en = ~((~cnd) | hazard)? mem_read: 0;
	assign memoty_write_en = ~((~cnd) | hazard)? mem_write: 0;
	assign EXE_CMD_out = ~((~cnd) | hazard)? EXE_CMD: 0;
	
	RegisterFile RegisterFile(clk, rst, src1, src2, Dest_wb, Result_WB, writeBackEn, Val_Rn_out, Val_Rm_out);
	ConditionCheck ConditionCheck(SR[3], SR[2], SR[1], SR[0], INST [31:28], cnd);
	ControlUnit ControlUnit(INST [27:26], INST [24:21], INST [20], EXE_CMD, mem_read, mem_write, wb_en, state_out, b);
endmodule

