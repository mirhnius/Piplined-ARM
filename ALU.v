module ALU(input [31 : 0] VAL1, VAL2, input C_in, input [3 : 0] EXE_CMD, output reg [31 : 0] finall_output, output reg C_out, V_out, output N,output  Z);
    wire [31:0] finall_output1, finall_output2, finall_output3, finall_output4;
    wire C_out1, C_out2, C_out3, C_out4;
    wire V_out1, V_out2, V_out3, V_out4;
	reg zz;
	assign {C_out1, finall_output1} = VAL1 + VAL2 + 1'b0;
	assign V_out1 = ((~finall_output1[31])&VAL1[31]&VAL2[31])|(finall_output1[31]&(~VAL1[31])&(~VAL2[31]));
	assign {C_out2, finall_output2} = VAL1 + VAL2 + C_in;
	assign V_out2 = ((~finall_output2[31])&VAL1[31]&VAL2[31])|(finall_output2[31]&(~VAL1[31])&(~VAL2[31]));
	assign {C_out3, finall_output3} = VAL1 - VAL2 - 1'b0;
	assign V_out3 = ((~finall_output3[31])&VAL1[31]&(~VAL2[31]))|(finall_output3[31]&(~VAL1[31])&(VAL2[31]));
	assign {C_out4, finall_output4} = VAL1 - VAL2 - 1'b1;
	assign V_out4 = ((~finall_output4[31])&VAL1[31]&(~VAL2[31]))|(finall_output4[31]&(~VAL1[31])&(VAL2[31]));
    always @(VAL1, VAL2, EXE_CMD) begin
        case(EXE_CMD)
            4'b0001: begin finall_output <= VAL2; C_out <= 0; V_out <= 0; end
            4'b1001: begin finall_output <= ~VAL2; C_out <= 0; V_out <= 0; end
            4'b0010: begin C_out <= C_out1; finall_output <= finall_output1; V_out <= V_out1; end
            4'b0011: begin C_out <= C_out2; finall_output <= finall_output2; V_out <= V_out2; end
            4'b0100: begin C_out <= C_out3; finall_output <= finall_output3; V_out <= V_out3; end
            4'b0101: begin C_out <= C_out4; finall_output <= finall_output4; V_out <= V_out4; end
            4'b0110: begin finall_output <= VAL1 & VAL2; C_out <= 0; V_out <= 0; end
            4'b0111: begin finall_output <= VAL1 | VAL2; C_out <= 0; V_out <= 0; end
            4'b1000: begin finall_output <= VAL1 ^ VAL2; C_out <= 0; V_out <= 0; end
        endcase 
    end
    assign N = finall_output[31];
	always @(*) begin
		if(finall_output == 0)begin
			zz <= 1;
		end
		if(finall_output == 1)begin
			zz <= 0;
		end
	end
	
    assign Z = (finall_output == 0);
endmodule