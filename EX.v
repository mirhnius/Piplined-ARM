module EX(input clk, rst, input [3:0] EXE_CMD,input MEM_R_EN, MEM_W_EN,input [31:0] PC, Val_Rn, Val_Rm,input imm,input [11:0] Shift_operand,input [23:0] Signed_imm_24,input [3:0] SR,output [31:0] ALU_result, Br_addr,output [3:0] status,input [1:0] sel_src_1,sel_src_2,input [31:0] WB_Value,ALU_result_in_mem);
	wire [31:0] Val_2;
	wire mem_r_w;
	wire [31 : 0] imm2;	
	assign mem_r_w = MEM_R_EN | MEM_W_EN;
	reg[31:0] src_1_mux_out;
	reg[31:0] src_2_mux_out;
	wire signed [31:0] value_1, value_2;
	assign value_1 = src_1_mux_out;
	assign value_2 = src_2_mux_out;
	always @(*) begin 
		case(sel_src_1) 
			2'b00:	
				src_1_mux_out = Val_Rn;
			2'b01:
				src_1_mux_out = ALU_result_in_mem;
			2'b10:
				src_1_mux_out = WB_Value;  
			default:
				src_1_mux_out = Val_Rn;
		endcase
	end


	always @(*) begin 
		case(sel_src_2) 
			2'd0 :
				src_2_mux_out = Val_Rm;
			2'd1 :
				src_2_mux_out = ALU_result_in_mem;
			2'd2 :
				src_2_mux_out = WB_Value;
			default :
				src_2_mux_out = Val_Rm;
		endcase
	end	
	ALU ALU(src_1_mux_out, Val_2, SR[2], EXE_CMD, ALU_result, status[2], status[0], status[1], status[3]);
	Val2Generator Val2Generator(Shift_operand, src_2_mux_out, mem_r_w, imm, Val_2);
    assign imm2 = {{6{Signed_imm_24[23]}}, Signed_imm_24, 2'b0};
    assign Br_addr = PC + imm2;
endmodule
