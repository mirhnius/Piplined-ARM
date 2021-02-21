module RegisterFile(input clk, input reset, input [3 : 0] src1, input [3 : 0] src2, input [3 : 0] Dest_wb, input [31 : 0] Result_WB, input writeBackEn, output [31 : 0] reg1, output [31 : 0] reg2);
    reg [31:0] Regs [0:14];
    integer count = 0;
    initial begin
     $readmemb("Register_File.txt", Regs);
    end 
    always @(negedge clk or posedge reset)
        if(reset) begin
            for(count=0;count<15;count=count+1) begin
                Regs[count] = 32'b0;
	    end
	end
        else
            if(writeBackEn==1)
            begin
                Regs[Dest_wb] <= Result_WB;
            end
    assign reg1 = Regs[src1];
    assign reg2 = Regs[src2];
endmodule
