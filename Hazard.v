module Hazard(input [3 : 0] Rn, address_2, mem_dest, exe_dest, input two_src, mem_wb_en, exe_wb_en, output reg  hazard,input Exe_RD_EN);

	always @(*) begin
		hazard = 1'b0;
		if(Exe_RD_EN==1 ) begin
			if(Rn == exe_dest)
				hazard = 1'b1;
		end
		if(Exe_RD_EN==1)begin
			if(two_src==1 )begin
				if(address_2 == exe_dest)
					hazard = 1'b1;
			end
		end
	end
endmodule
