module testbench();

reg clk;
reg reset;

wire [31:0] write_data, data_addr;
wire mem_write,mem_read;

top tb_top(clk,reset,write_data,data_addr,mem_write,mem_read);

//initialize test
initial
    begin
        reset <= 1; #22; reset <= 0;
    end

always
    begin
        clk <= 1; #5; clk <= 0; #5;
    end

always @(negedge clk)
    begin
        if(mem_write) begin
	    if (data_addr === 84 & write_data === 7) begin
	        $display("Simulation succeeded");
		$stop;
	    end else if (data_addr !== 80) begin
		$display("simulation failed");
		$stop;
	    end
	   end
     end


endmodule

