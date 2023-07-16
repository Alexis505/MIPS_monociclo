module datapath (input clk, reset,
		 input regdst, alusrc, memtoreg, regwrite,
		 input pcsrc,jump,
		 //memread y memwrite no entran al datapath si no
		 //a la memoria de datos :) 
                 input[2:0] alu_control,
                 input[31:0] instr,
                 input[31:0] read_data, 
		 output zero,
		 output[31:0] aluout,
		 output[31:0] write_data,
		 output[31:0] pc);

//wire para contener instr[20-16] o instr[15-11]
wire[4:0] write_register;		
//wire para atender todos los posbibles pc
wire[31:0] pc_plus4, pc_branch, pc_nextbr, pc_next;
//wire para extender de 16 a 32 b y otro para multiplicar por 4
wire[31:0] signimm,signimmsh;
//fuentes de alu
wire[31:0] alu_srca, alu_srcb;
//wire para escoger entre la data mem o alu result
wire[31:0] result;

//calculamos los posibles siguientes PC
//establecemos el siguiente pc en base a pc_next 
//por lo tanto pc_next contiene el siguiente pc definitivo
flop #(32) fp(clk, reset, pc_next, pc);
adder pcplus4(pc,32'b100,pc_plus4);
//para calcular pc branch, usamos 
//primero shift left l 2 porque recordar que el formato es
//multilpicar por 4, lo que contenga el campo immediate en las intr
sl2 immshll(signimm, signimmsh);
adder pcbranch(pc_plus4,signimmsh,pc_branch);
mux2 #(32) mux_pc(pc_plus4,pc_branch,pcsrc,pc_nextbr);
mux2 #(32) mux_pcnext(pc_nextbr,{pc_plus4[31:28],instr[25:0],2'b00}, jump, pc_next);

//logica para el reg file
regfile regfile(clk,regwrite,instr[25:21],instr[20:16],write_register,result,alu_srca,write_data);
mux2 #(5) wrmux(instr[20:16],instr[15:11],regdst,write_register);
mux2 #(32) result_mux(aluout,read_data,memtoreg,result); 
signext signxt_imm(instr[15:0],signimm);

//logica de la alu
mux2 #(32) alusrcb_mux(write_data,signimm,alusrc,alu_srcb);
alu alu_inst(alu_srca,alu_srcb,alu_control,aluout,zero);
endmodule

