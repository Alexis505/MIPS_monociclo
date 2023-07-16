module regfile (input clk, 
		input write_enable,
		input [4:0] ra_1, ra_2, write_address,
		input [31:0] write_data,
		output [31:0] rd_1, rd_2);

//ra_x = read address
//rd_x = read data (datos que entran en el regfile
//ya sea por instr r-type o lw
//write address es la direccion donde se cargara write_data

reg[31:0] rf[31:0];

always @(posedge clk)
	if (write_enable) rf[write_address] <= write_data;

assign rd_1 = (ra_1 != 0) ? rf[ra_1] : 0;
assign rd_2 = (ra_2 != 0) ? rf[ra_2] : 0;

endmodule
