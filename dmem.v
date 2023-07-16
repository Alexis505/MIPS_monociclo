module dmem (input clk,mem_write,mem_read,
	     input[31:0] data_addr,
	     input[31:0] write_data,
	     output[31:0] read_data);

reg[31:0] RAM[63:0];

assign read_data = mem_read ? RAM[data_addr[31:2]] : 32'b0; //word aligned

always @(posedge clk)
	if (mem_write)
	    RAM[data_addr[31:2]] <= write_data;

endmodule
