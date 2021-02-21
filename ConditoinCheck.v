module ConditionCheck(input Z, C, N, V, input[3 : 0] cond, output reg check);
    always @(Z, C, N, V, cond) begin
 	 	
 	 	if(cond==4'b0000)begin
			if(Z==1)begin
				check=1'b1;
			end else begin
				check=1'b0;
			end
		end
		else if(cond==4'b0001)begin
			if(Z==0)begin
				check=1'b1;
			end else begin
				check=1'b0;
			end
		end
		else if(cond==4'b0010)begin
			if(C==1)begin
				check=1'b1;
			end else begin
				check=1'b0;
			end
		end
		else if(cond==4'b0011)begin
			if(C==0)begin
				check=1'b1;
			end else begin
				check=1'b0;
			end
		end
		else if(cond==4'b0100)begin
			if(N==1)begin
				check=1'b1;
			end else begin
				check=1'b0;
			end
		end
		else if(cond==4'b0101)begin
			if(N==0)begin
				check=1'b1;
			end else begin
				check=1'b0;
			end
		end
		else if(cond==4'b0110)begin
			if(V==1)begin
				check=1'b1;
			end else begin
				check=1'b0;
			end
		end
		else if(cond==4'b0111)begin
			if(V==0)begin
				check=1'b1;
			end else begin
				check=1'b0;
			end
		end    
        else begin
			case(cond)
				4'b1000 : check = (C==1 && Z==0) ? 1'b1 : 1'b0;
				4'b1001 : check = (C==0 || Z==1) ? 1'b1 : 1'b0;
				4'b1010 : check = (N==V) ? 1'b1 : 1'b0;
				4'b1011 : check = (N!=V) ? 1'b1 : 1'b0;
				4'b1100 : check = (Z==0 && N==V) ? 1'b1 : 1'b0;
				4'b1101 : check = (Z==1 && N!=V) ? 1'b1 : 1'b0;
				4'b1110 : check = 1'b1;
				4'b1111 : check = 1'b0;
			endcase
		end
    end
endmodule