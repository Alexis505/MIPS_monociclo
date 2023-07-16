module alu (input [31:0] src_a,src_b,
				//input [5:0] shamnt,
				input [2:0] alucontrol,
				output reg [31:0] alu_out,
				output zero);

always @ (alucontrol,src_a,src_b)					
	begin
		case (alucontrol)
			3'b000: alu_out <= src_a&src_b;
			3'b001: alu_out <= src_a|src_b;
			3'b010: alu_out <= src_a+src_b;
			3'b110: alu_out <= src_a-src_b;
			3'b111: alu_out <= src_a<=src_b ? 32'h00000001:32'h00000000;
			//3'b011: rt <= rg << shamnt;
			default alu_out <= 32'h00000000;
			//3'b100: rt = ~(rd|rg);
		endcase
	end

assign zero = (alu_out == 32'b0) ? 1'b1:1'b0;

endmodule
