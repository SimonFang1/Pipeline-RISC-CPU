`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:50:26 04/07/2017 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(
    input clock,
	 input en,
	 input reset,
	 input start,
	 input debug,
	 input show_gr,
	 input m_clk_btn,
	 input [3:0] select_y,
	 output reg [6:0] display_atog,
	 output display_dp,
	 output [3:0] display_an
    );
	 
	 wire cpu_clk_auto, cpu_clk_manual, cpu_clk;
	 wire display_clk;
	 
	 wire [15:0] d_datain, i_datain;
    wire [7:0] i_addr, d_addr;
    wire [15:0] d_dataout;
    wire d_we;
    wire [15:0] pcpu_y;
	 
	 
	 assign cpu_clk = debug == 1'b1 ? cpu_clk_manual : cpu_clk_auto;
    manual_clock m_clk(
        .clock(clock),
	     .reset(reset),
	     .button(m_clk_btn),
	     .signal(cpu_clk_manual)
    );
	 clock_div clk_div_cpu(
        .clock(clock),
	     .reset(reset),
	     .div_ratio(32'd50_000_000), // 1s
	     .clk_div(cpu_clk_auto)
    );
	 clock_div clk_div_display(
        .clock(clock),
	     .reset(reset),
	     .div_ratio(32'd50_000), // 1ms
	     .clk_div(display_clk)
    );
	 
	 // 7-segment
	 reg [1:0] svn_seg_counter;
	 reg [3:0] svn_seg_en;
	 wire [6:0] atog_inv [3:0];
	 always @(posedge display_clk or posedge reset) begin
	     if (reset)
		      svn_seg_counter <= 0;
	     else
		      svn_seg_counter <= svn_seg_counter + 1'b1;
	 end
	 always @(*) begin
	     case(svn_seg_counter)
		      2'd0: begin svn_seg_en = 4'b0001; display_atog = ~atog_inv[0]; end
		      2'd1: begin svn_seg_en = 4'b0010; display_atog = ~atog_inv[1]; end
		      2'd2: begin svn_seg_en = 4'b0100; display_atog = ~atog_inv[2]; end
		      2'd3: begin svn_seg_en = 4'b1000; display_atog = ~atog_inv[3]; end
		  endcase
	 end
	 assign display_an = ~svn_seg_en;
	 assign display_dp = 1'b1;
	 seven_seg ss0(
	     .x(pcpu_y[3:0]),
        .y(atog_inv[0])
	 );
	 seven_seg ss1(
	     .x(pcpu_y[7:4]),
        .y(atog_inv[1])
	 );
	 seven_seg ss2(
	     .x(pcpu_y[11:8]),
        .y(atog_inv[2])
	 );
	 seven_seg ss3(
	     .x(pcpu_y[15:12]),
        .y(atog_inv[3])
	 );
	 
	 // 
	 PCPU pcpu(
        .clock(cpu_clk),
		  .reset(reset),
	     .d_datain(d_datain),
	     .enable(en),
	     .i_datain(i_datain),
		  .show_gr(show_gr),
	     .select_y(select_y),
	     .start(start),
	     .d_addr(d_addr),
	     .d_dataout(d_dataout),
		  .d_we(d_we),
		  .i_addr(i_addr),
		  .y(pcpu_y)
    );
	
	i_mem i_mem0(
      .clka(clock),
      .addra(i_addr),
      .douta(i_datain)
   );
	 
//	 imem imem0(
//        .address(i_addr),
//	     .q(i_datain)
//    );

	 dmem dmem0(
	     .clock(clock),
		  .address(d_addr),
		  .we(d_we),
		  .data(d_dataout),
		  .q(d_datain)
    );
	 
endmodule
