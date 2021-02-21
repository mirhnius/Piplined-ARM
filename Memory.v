module Memory(input [31 : 0] data,input [31 : 0] address, input w_en, input r_en, input clk, output reg [31 : 0] out);
    reg [31 : 0] mem [0 : 64-1];
    wire [31 : 0] address_np;
    always @(posedge clk) begin
        if(w_en)
            mem[address_np] <= data;
    end
    always @(*) begin
    
    if (r_en==1) out <= mem[address_np];
    else if(r_en==0) out <= 32'b0;
    end
    assign address_np = {address[31 : 2], 2'b0} - 32'h400;
endmodule