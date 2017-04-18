`timescale 1ns / 1ps
module manual_clock(
    input clock,
	 input reset,
	 input button,
	 output reg signal
    );
	 
    parameter RESET = 2'b00, SET = 2'b01, LOCK = 2'b10;
	 reg [1:0] state, nextstate;
    
    always @(posedge clock or posedge reset) begin
        if(reset) begin
		      signal <= 0;
            state <= RESET;
        end else begin
            state <= nextstate;
				if (state == SET)
		          signal <= ~signal;
		  end
    end
	 always @(*) begin
        case(state)
            RESET:
                if (button == 1'b1) nextstate <= SET;
                else  nextstate <= RESET;
            SET: nextstate <= LOCK;
            LOCK:
                if (button == 1'b1) nextstate <= LOCK;
                else nextstate <= RESET;
            default: nextstate <= RESET;
        endcase
    end

endmodule
