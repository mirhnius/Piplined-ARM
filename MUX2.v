module MUX2
	(
		input[31:0] a, b, 
		input sel,
		output [31:0] res
	);
assign res = sel ? a : b ;
endmodule




