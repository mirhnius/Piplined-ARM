module forward(input wb_en_mem, wb_en_wb,input[3:0] dst_mem, dst_wb,src_1,src_2,output reg[1:0] sel_src_1,output reg[1:0] sel_src_2);

	always @(*) begin
		sel_src_1 = 2'b00;
		sel_src_2 = 2'b00;
		if(src_1==dst_mem && wb_en_mem==1)begin
			sel_src_1=2'b01;
		end
		else if(src_1==dst_wb && wb_en_wb==1)begin
			sel_src_1=2'b10;
		end
		else begin
			sel_src_1=2'b00;
		end
		
		
		if(src_2==dst_mem && wb_en_mem==1)begin
			sel_src_2=2'b01;
		end
		else if(src_2==dst_wb && wb_en_wb==1)begin
			sel_src_2=2'b10;
		end
		else begin
			sel_src_2=2'b00;
		end 

	end
endmodule


