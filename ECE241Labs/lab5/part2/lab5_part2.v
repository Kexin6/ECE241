module lab5_part2(SW, CLOCK_50, HEX0);
	input [1:0] SW;
	input CLOCK_50;
	output [6:0] HEX0;
	
	counter c0 (
		.choice(SW),
		.clock(CLOCK_50),
		.h(HEX0)
	);
	
endmodule

module counter (input [1:0] choice, input clock, output [6:0] h);
	wire [25:0] Q;
	wire RDEnable;
	
	mux m0(
		.choice(choice),
		.clock_50(clock),
		.Q(Q)
	);
	
	RateDivider r0(
		.clock(clock),
		.Q(Q),
		.enable(RDEnable)
	);
	
	DisplayCounter d0 (
		.clock(clock),
		.enable(RDEnable),
		.h(h)
	);

endmodule
	

module RateDivider(input clock, input [25:0] Q, output enable);
	reg [25:0] q = 0;
	always @(posedge clock)
	begin
		if (q == 26'd0)
			q <= Q;
		else 
			q <= q - 1;
	end
	assign enable = (q == 26'd0) ? 1:0;
endmodule

module DisplayCounter(input clock, enable, output[6:0] h);
	reg [3:0] Q = 3'b000;
	
	always @(posedge clock)
	begin
		if (enable == 1'b1)
			Q <= Q + 1;
	end
	hex h0 (
		.pin({Q[3],{Q[2],{Q[1],{Q[0]}}}}),
		.h(h)
	);
	
endmodule

module mux (input [1:0] choice, clock_50, output reg [25:0] Q);
	
	always @(*)
	begin
		case (choice)
			2'b00: Q = 26'd1;
			2'b01: Q = 26'd12499999;
			2'b10: Q = 26'd24999999;
			2'b11: Q = 26'd49999999;
			default: Q = 0;
		endcase			
	end
endmodule 



module hex(input [3:0] pin, output [6:0] h);
	assign h[0] = (~pin[3] & ~pin[2] & ~pin[1] & pin[0]) | (~pin[3] & pin[2] & ~pin[1] & ~pin[0]) | 
		(pin[3] & ~pin[2] & pin[1] & pin[0]) | (pin[3] & pin[2] & ~pin[1] & pin[0]);
	assign h[1] = (~pin[3] & pin[2] & ~pin[1] & pin[0]) | (~pin[3] & pin[2] & pin[1] & ~pin[0]) |(pin[3] & ~pin[2] & pin[1] & pin[0]) |
		(pin[3] & pin[2] & ~pin[1] & ~pin[0]) | (pin[3] & pin[2] & pin[1] & ~pin[0]) | (pin[3] & pin[2] & pin[1] & pin[0]);
	assign h[2] = (~pin[3] & ~pin[2] & pin[1] & ~pin[0]) | (pin[3] & pin[2] & ~pin[1] & ~pin[0]) | 
		(pin[3] & pin[2] & pin[1] & ~pin[0]) | (pin[3] & pin[2] & pin[1] & pin[0]);
	assign h[3] = (~pin[3] & ~pin[2] & ~pin[1] & pin[0]) | (~pin[3] & pin[2] & ~pin[1] & ~pin[0]) | (~pin[3] & pin[2] & pin[1] & pin[0]) |
		(pin[3] & ~pin[2] & pin[1] & ~pin[0]) | (pin[3] & pin[2] & pin[1] & pin[0]);
	assign h[4] = (~pin[3] & ~pin[2] & ~pin[1] & pin[0]) | (~pin[3] & ~pin[2] & pin[1] & pin[0]) | (~pin[3] & pin[2] & ~pin[1] & ~pin[0]) |
		(~pin[3] & pin[2] & ~pin[1] & pin[0]) | (~pin[3] & pin[2] & pin[1] & pin[0]) | (pin[3] & ~pin[2] & ~pin[1] & pin[0]);
	assign h[5] = (~pin[3] & ~pin[2] & ~pin[1] & pin[0]) | (~pin[3] & ~pin[2] & pin[1] & ~pin[0]) | (~pin[3] & ~pin[2] & pin[1] & pin[0]) |
		(~pin[3] & pin[2] & pin[1] & pin[0]) | (pin[3] & pin[2] & ~pin[1] & pin[0]);
	assign h[6] = (~pin[3] & ~pin[2] & ~pin[1] & ~pin[0])| (~pin[3] & ~pin[2] & ~pin[1] & pin[0]) |
		(~pin[3] & pin[2] & pin[1] & pin[0]) | (pin[3] & pin[2] & ~pin[1] & ~pin[0]);
endmodule

