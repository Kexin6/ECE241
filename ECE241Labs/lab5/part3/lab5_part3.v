module lab5_part3 (SW, KEY, LEDR, CLOCK_50);
	input [2:0] SW;
	input [1:0] KEY;
	input CLOCK_50;
	output [1:0] LEDR;
	morseCoder m0 (
		.choice(SW),
		.clock_50(CLOCK_50),
		.resetn(KEY[0]),
		.clock(KEY[1]),
		.LED(LEDR[0])
		
	);

endmodule

module morseCoder (input [2:0] choice, input clock_50, resetn, clock, output LED);
	wire [12:0] muxQ;
	wire enable50;
	  
	mux m0 (
		.choice(choice),
		.Q(muxQ) 
	);
	
	RateDivider r0(
		.clock(clock_50),
		.divider(26'd24999999),
		.enable(enable50)
	);
	
	ShiftReg s0(
		.clock(clock_50),
		.Q(muxQ),
		.resetn(resetn),
		.enable(enable50),
		.outQ(LED),
		.loadn(clock)
	);
		
endmodule

module mux (input [2:0] choice, output reg [12:0] Q);
	
	always @(*)
	begin
		case (choice[2:0])
			3'b000: Q = 13'b1010100000000;
			3'b001: Q = 13'b1110000000000;
			3'b010: Q = 13'b1010111000000;
			3'b011: Q = 13'b1010101110000;
			3'b100: Q = 13'b1011101110000;
			3'b101: Q = 13'b1110101011100;
			3'b110: Q = 13'b1110101110111;
			3'b111: Q = 13'b1110111010100;
			default: Q = 0;
		endcase			
	end
endmodule 

module ShiftReg (input resetn, enable, clock, loadn,input [12:0] Q, output reg outQ);
	reg [12:0] out;

	
	always @(negedge resetn, posedge clock)
	begin
		if (resetn == 0)
			begin
			out <= 0;
			outQ <= 0;
			end
			else if (loadn == 0)
			begin
				out <= Q;
				outQ <= 0;
			end
			else if (enable == 1)
			begin
				outQ <= out[12];
				out <= (out << 1'b1);
			end
		end
endmodule

	



module RateDivider(input clock, input [26:0] divider, output enable);
	reg [25:0] q = 0;
	
	always @(posedge clock)
	begin
		if (q == 26'd0)
			q <= divider;
		else 
			q <= q - 1;
	end
	
	assign enable = (q == 26'd0) ? 1:0;
	
	
endmodule
