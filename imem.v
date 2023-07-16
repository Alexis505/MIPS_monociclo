module imem (input [5:0] pc,
	     output [31:0] instruction);

//memoria con solo 64 elementos
reg[31:0] RAM[63:0];

initial
    begin
        $readmemh("memfile.dat",RAM);
    end

//pc solo son 5 bits del vector de 32
//esto porque solo bastan 6 bits para direccionar los 64 elementos
//de nuesta data mem en esta simulacion
assign instruction = RAM[pc];

endmodule

