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
	reg enable;
	reg reset;
	reg [3:0] select_y;
	reg start;
	reg show_gr;

	// Outputs
	wire [7:0] d_addr;
	wire [15:0] d_dataout;
	wire d_we;
	wire [7:0] i_addr;
	wire [15:0] i_datain;
	wire [15:0] d_datain;
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
		.y(y),
		.show_gr(show_gr)
	);

	 imem imem0(
        .address(i_addr),
	     .q(i_datain)
    );
	 
	 dmem dmem0(
	     .clock(clock),
	     .address(d_addr),
		  .we(d_we),
		  .data(d_dataout),
		  .q(d_datain)
    );

	initial begin
		// Initialize Inputs
		clock = 0;
		enable = 0;
		reset = 0;
		select_y = 0;
		start = 0;
		show_gr = 0;
		#10 reset = 1;
		#10 reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$display("pc:     id_ir      :reg_A:reg_B:reg_C:da:dd  :w:reC1:gr1 :gr2 : gr3");
		$monitor(
				"%h:%b:%h :%h :%h :%h:%h:%b:%h:%h:%h:%h", 
				pcpu.pc, pcpu.id_ir, pcpu.reg_A, pcpu.reg_B, pcpu.reg_C,
				d_addr, d_dataout, d_we, pcpu.reg_C1, pcpu.gr[1], pcpu.gr[2], pcpu.gr[3]
		);
		start = 1;
		enable = 1;
		#10;
	
	end
	always #5 clock = ~clock;
      
endmodule

module imem(
    input [7:0] address,
	 output [15:0] q
    );
	 reg [15:0] ram[0:255];
	 assign q = ram[address];
	 initial begin
	     $readmemb("ipcore_dir/i_mem.mif", ram);
	 end
endmodule

module dmem(
	 input clock,
	 input [7:0] address,
	 input we,
	 input [15:0] data,
	 output [15:0] q
    );
    reg [15:0] ram[0:255];
	 assign q = ram[address];
    always @(posedge clock) begin
        if (we)
            ram[address] <= data;
	 end
	 initial begin
	     $readmemb("ipcore_dir/d_mem.mif", ram);
	 end
endmodule
