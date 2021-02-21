module WB(input MRen, input [31 : 0] ALU_result, Mem_read_value, output [31 : 0] Write_value);
MUX2 WB_MUX (Mem_read_value,ALU_result,MRen,Write_value);
endmodule
