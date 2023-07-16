module mips (input clk,reset,
	     input[31:0] instr,
	     input[31:0] read_data,
             output mem_write,mem_read,
	     output[31:0] alu_out,
             output[31:0] write_data,
	     output[31:0] pc);


wire regdst,alu_src,memtoreg,regwrite,jump,pcsrc,zero;
wire[2:0] alu_control;

controller control(instr[31:26],instr[5:0],zero,regdst,alu_src,memtoreg,regwrite,mem_read,mem_write,jump,pcsrc,alu_control);

datapath dp(clk,reset,regdst,alu_src,memtoreg,regwrite,pcsrc,jump,alu_control,instr,read_data,zero,alu_out,write_data,pc);

endmodule
