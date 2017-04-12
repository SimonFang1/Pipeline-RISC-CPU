`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:10:14 04/11/2017
// Design Name:   PCPU
// Module Name:   D:/ISEDesign/ESAD/week6/PCPU/pcpu_tb.v
// Project Name:  PCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "header.v"
module pcpu_tb;

	// Inputs
	reg clock;
	reg [15:0] d_datain;
	reg enable;
	reg [15:0] i_datain;
	reg reset;
	reg [4:0] select_y;
	reg start;

	// Outputs
	wire [7:0] d_addr;
	wire [15:0] d_dataout;
	wire d_we;
	wire [7:0] i_addr;
	wire [15:0] y;

	// Instantiate the Unit Under Test (UUT)
	PCPU pcpu (
		.clock(clock), 
		.d_datain(d_datain), 
		.enable(enable), 
		.i_datain(i_datain), 
		.reset(reset), 
		.select_y(select_y), 
		.start(start), 
		.d_addr(d_addr), 
		.d_dataout(d_dataout), 
		.d_we(d_we), 
		.i_addr(i_addr), 
		.y(y)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		d_datain = 0;
		enable = 0;
		i_datain = 0;
		reset = 0;
		select_y = 0;
		start = 0;
		#10 reset = 1;
		#10 reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$display("pc:     id_ir      :reg_A:reg_B:reg_C:da:dd  :w:reC1:gr1 :gr2 : gr3");
		$monitor("%h:%b:%h :%h :%h :%h:%h:%b:%h:%h:%h:%h", 
	pcpu.pc, pcpu.id_ir, pcpu.reg_A, pcpu.reg_B, pcpu.reg_C,
	d_addr, d_dataout, d_we, pcpu.reg_C1, pcpu.gr[1], pcpu.gr[2], pcpu.gr[3]);
	

#10 start =1; enable = 1;
#10 
	i_datain = {`LOAD, `gr1, 1'b0, `gr0, 4'b0000};
#10 i_datain = {`LOAD, `gr2, 1'b0, `gr0, 4'b0001};
#10 i_datain = {`NOP, 11'b000_0000_0000};
#10 i_datain = {`NOP, 11'b000_0000_0000};
	d_datain =16'h00AB;  // 3 clk later from LOAD
#10 i_datain = {`NOP, 11'b000_0000_0000};
	d_datain =16'h3C00;  // 3 clk later from LOAD
#10 i_datain = {`ADD, `gr3, 1'b0, `gr1, 1'b0, `gr2};
#10 i_datain = {`NOP, 11'b000_0000_0000};
#10 i_datain = {`NOP, 11'b000_0000_0000};
#10 i_datain = {`NOP, 11'b000_0000_0000};
#10 i_datain = {`STORE, `gr3, 1'b0, `gr0, 4'b0010};
#10 i_datain = {`HALT, 11'b000_0000_0000};
#10 start =0;	

	end
	always #5 clock = ~clock;
      
endmodule

