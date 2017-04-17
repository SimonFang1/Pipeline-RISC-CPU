`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:50:47 04/07/2017 
// Design Name: 
// Module Name:    PCPU 
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
`include "header.v"
module PCPU(
    input clock,
	 input [15:0] d_datain,
	 input enable,
	 input [15:0] i_datain,
	 input reset,
	 input [3:0] select_y,
	 input start,
	 output [7:0] d_addr,
	 output [15:0] d_dataout,
	 output d_we,
	 output [7:0] i_addr,
	 output reg [15:0] y,
	 input show_gr
    );
    
	 reg [7:0] pc;
	 reg [15:0] id_ir, ex_ir, mem_ir, wb_ir;
	 reg [15:0] reg_A, reg_B, reg_C, reg_C1;
	 reg [15:0] smdr, smdr1;
	 reg [2:0] flags; // flag[0]-CF, flag[1]-ZF, flag[2]-NF
	 `define CF		flags[0]
	 `define ZF		flags[1]
	 `define NF		flags[2]
	 reg dw;
	 
	 wire [15:0] w_ALUo;
	 wire [2:0] w_flags;
	 
	 assign d_dataout = smdr1;
    assign d_we = dw;
    assign d_addr = reg_C[7:0];
    assign i_addr = pc;
	 
	 //*********** General Register **********//
	 reg [15:0] gr[0:7];
	 initial begin
	     gr[0] = 0;
	 end
	 //************* WB *************//
    always @(posedge clock or posedge reset) begin
        if (reset) begin
		      gr[0] <= 0; gr[1] <= 0; gr[2] <= 0; gr[3] <= 0;
				gr[4] <= 0; gr[5] <= 0; gr[6] <= 0; gr[7] <= 0;
		  end else if (state ==`exec) begin
		      case(wb_ir[`I_OP])
				    `LOAD, `MOV,
					 `ADD, `ADDI, `ADDC,
					 `SUB, `SUBI, `SUBC, 
					 `NOT, `AND, `OR, `XOR,
					 `SL, `SRL, `SRA,
					 `LDIH: gr[wb_ir[`I_R1]] <= reg_C1;
				endcase
        end
    end
	 
	 //************* CPU control *************//
	 reg state, next_state;
    always @(posedge clock) begin
        if (reset)
            state <= `idle;
        else
            state <= next_state;
    end
        
    always @(*) begin
        case (state)
            `idle : 
                if ((enable == 1'b1) 
                && (start == 1'b1))
                    next_state = `exec;
                else    
                    next_state = `idle;
            `exec :
                if ((enable == 1'b0)
					 || wb_ir[`I_OP] == `HALT)
                    next_state = `idle;
                else
                    next_state = `exec;
        endcase
    end
	 
	 //************* IF *************//
	 reg pc_jump;
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            id_ir <= 16'b0000_0000_0000_0000;
            pc <= 8'b0000_0000;
        end else if (state ==`exec) begin
            id_ir <= i_datain;
				if (wb_ir[`I_OP] == `HALT)
				    pc <= pc;
				else if (pc_jump == 1'b1)
				    pc <= reg_C[7:0];
			   else
				    pc <= pc + 1'b1;
        end
    end
	 always @(*) begin
	     case(mem_ir[`I_OP])
		      `JUMP,
				`JMPR: pc_jump = 1'b1;
		      `BZ: pc_jump = (`ZF == 1'b1) ? 1'b1 : 1'b0;
				`BNZ: pc_jump = (`ZF == 1'b0) ? 1'b1 : 1'b0;
				`BN: pc_jump = (`NF == 1'b1) ? 1'b1 : 1'b0;
				`BNN: pc_jump = (`NF == 1'b0) ? 1'b1 : 1'b0;
				`BC: pc_jump = (`CF == 1'b1) ? 1'b1 : 1'b0;
				`BNC: pc_jump = (`CF == 1'b0) ? 1'b1 : 1'b0;
				default: pc_jump = 1'b0;
		  endcase
	 end
	 
	 //************* ID *************//
     always @(posedge clock or posedge reset) begin
	     if (reset) begin
		      ex_ir <= 16'd0;
		  end else if (state ==`exec) begin
            ex_ir <= id_ir;
				smdr <= gr[id_ir[`I_R1]];
				case(id_ir[`I_OP])
				    `JUMP,
					 `MOV: begin
					      reg_A <= 16'd0;
							reg_B <= id_ir[`I_IMDT];
					 end
					 `LDIH: begin
					     reg_A <= gr[id_ir[`I_R1]];
						  reg_B <= {id_ir[`I_IMDT], 8'd0};
					 end
					 `ADDI,
				    `JMPR,
				    `BZ,
				    `BNZ,
				    `BN,
				    `BNN,
				    `BC,
				    `BNC: begin
				        reg_A <= gr[id_ir[`I_R1]];
						  reg_B <= id_ir[`I_IMDT];
				    end
					 `LOAD,
					 `STORE,
					 `SL,
					 `SRL,
					 `SRA: begin
					     reg_A <= gr[id_ir[`I_R2]];
					     reg_B <= id_ir[`I_VAL3];
					 end
				    default: begin
					     reg_A <= gr[id_ir[`I_R2]];
						  reg_B <= gr[id_ir[`I_R3]];
					 end
            endcase
        end
    end
	 
	  //************* EX *************//  
     always @(posedge clock or posedge reset) begin
        if (reset) begin
		      mem_ir <= 16'd0;
		  end else if (state ==`exec) begin
            mem_ir <= ex_ir;
            reg_C <= w_ALUo;
				if (!(ex_ir[`I_OP] == `BN || ex_ir[`I_OP] == `BNN ||
				      ex_ir[`I_OP] == `BZ || ex_ir[`I_OP] == `BNZ ||
						ex_ir[`I_OP] == `BC || ex_ir[`I_OP] == `BNC))
                flags <= w_flags;
				smdr1 <= smdr;
            if (ex_ir[`I_OP] == `STORE)
                dw <= 1'b1;
            else
                dw <= 1'b0;
        end
    end
	 
	 //************* MEM *************//
    always @(posedge clock or posedge reset) begin
        if (reset) begin
		      wb_ir <= 16'd0;
		  end else if (state ==`exec) begin
		      if (wb_ir[`I_OP] != `HALT)
                wb_ir <= mem_ir;
            if (mem_ir[`I_OP] == `LOAD)
                reg_C1 <= d_datain;
            else
                reg_C1 <= reg_C;
        end
    end

	 //ALU 
	 reg [3:0] ALUop;
	 always @(ex_ir or flags) begin
	     case(ex_ir[`I_OP])
		     `LOAD,
			  `STORE,
			  `LDIH,
			  `BZ,
			  `BNZ,
			  `BN,
			  `BNN,
			  `BC,
			  `BNC,
			  `ADD,
			  `ADDI: ALUop = `A_ADD;
			  `ADDC: ALUop = `CF == 1'b1 ? `A_ADDPLS : `A_ADD;
			  `SUB,
			  `SUBI,
			  `CMP: ALUop = `A_SUB;
			  `SUBC: ALUop = `CF == 1'b1 ? `A_SUBMNS : `A_SUB;
			  `AND: ALUop = `A_AND;
			  `XOR: ALUop = `A_XOR;
			  `NOT: ALUop = `A_NOT;
			  `SL: ALUop = `A_SL;
			  `SRL: ALUop = `A_SRL;
			  `SRA: ALUop = `A_SRA;
			  `OR,
			  `JUMP,
			  `MOV: ALUop = `A_OR;
			  default: ALUop = `A_OR;
		  endcase
	 end
	 
	 ALU alu(
        .opcode(ALUop),
	     .operandA(reg_A),
	     .operandB(reg_B),
	     .ALUo(w_ALUo),
	     .flags(w_flags)
    );
	 
	 //*********** Output ***********//
	 always @(*) begin
	     if (show_gr == 1'b1) begin
		      case (select_y[2:0])
					3'b000: y = gr[0];
					3'b001: y = gr[1];
					3'b010: y = gr[2];
					3'b011: y = gr[3];
					3'b100: y = gr[4];
					3'b101: y = gr[5];
					3'b110: y = gr[6];
					3'b111: y = gr[7];
			  endcase
		  end else begin
		      case (select_y)
					4'd0: y = pc;    //{8'b0000_0000, pc};
					4'd1: y = id_ir;
					4'd2: y = ex_ir;
					4'd3: y = mem_ir;
					4'd4: y = wb_ir;
					4'd5: y = reg_A;
					4'd6: y = reg_B;
					4'd7: y = reg_C;
					4'd8: y = flags;
					4'd9: y = dw;
					4'd10: y = smdr;
					4'd11: y = smdr1;
					4'd12: y = reg_C1;
					default: y = pc;
			  endcase
		  end
	 end
endmodule
