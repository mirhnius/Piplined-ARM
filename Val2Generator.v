module Val2Generator(input [11 : 0] shift_operand, input signed [31 : 0] val_rm, input MRW, Imm, output reg [31 : 0] Val2);
     reg [31 : 0] temp;
    wire [7 : 0] Imm2;
    wire [61 : 0] temp_imm;
    wire [3 : 0] Rm;
    wire [1 : 0] shift;
    wire [4 : 0] shift_imm;
    wire [63 : 0] IRS_output;
  
    always @(*) begin
        case(shift)
        2'b00: temp = val_rm << shift_imm;
        2'b01: temp = val_rm >> shift_imm;
        2'b10: temp = val_rm >>> shift_imm;
        2'b11: temp = IRS_output[31 : 0];
        endcase
    end
    always @(*) begin
        if(MRW)
            Val2 = {20'b0, shift_operand};
        else if(Imm)
            Val2 = temp_imm[31 : 0];
        else if(~(Imm || shift_operand[4]))
            Val2 = temp;
        else
            Val2 = val_rm;
    end

    assign temp_imm = ({22'b0, Imm2, 24'b0, Imm2} >> {shift_operand[11 : 8], 1'b0});
    assign Rm = shift_operand[3 : 0];
    assign shift = shift_operand[6 : 5];
    assign shift_imm = shift_operand[11 : 7];
    assign Imm2 = shift_operand[7 : 0];
    assign IRS_output = {val_rm, val_rm} >> shift_imm;
endmodule