module maindec (input [5:0] opcode,
		output regdst, //senal para escribir en memoria como sw
		output alusrc, //para escribir el register file
		output memtoreg, //senal para decidir si tomar los campos 20-16 o 15-11 de la instruccion para write register 
		output regwrite, //senal para escoger read data 2 o el vector de bits que fue transformado de un 16 bits a 32 bits gracias a sign extended
		output memread, //senal para escoger entre el valor leido de la memoria (1,ej: lw) o el valor resultado de la alu (0, r-inst)
		output memwrite,
		output branch,
		output jump,
		output [1:0] aluop);

reg [9:0] controls;

//acomodamos las senales de acuerdo a la tabla de la figura 4.18 del libro
//de john hennesy 
assign {regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch,jump,aluop} = controls;

always @(*)
	case(opcode)
	    6'b000000: controls <= 10'b1001000010; //r-type instruction
	    6'b100011: controls <= 10'b0111100000; //load inst
	    6'b101011: controls <= 10'b0100010000; //sw inst
	    6'b000100: controls <= 10'b0000001001; //branch inst
	    6'b001000: controls <= 10'b0101000000; //addi inst
	    6'b000010: controls <= 10'b0000000100; //j inst
	    default: controls <= 10'bxxxxxxxxxx;  //no existe otro op para este subconjunto de instrucciones de mips
	endcase
endmodule
