module lab5_part1 (SW, KEY, HEX0, HEX1);
	input [1:0] SW;
	input [3:0] KEY;
	output [6:0] HEX0, HEX1;
	
	eight_bit_counter(
		.enable(SW[1]),
		.clock(KEY[0]), 
		.clear_b(SW[0]),
		.H0(HEX1),
		.H1(HEX0)
	);
	
endmodule


module eight_bit_counter(input enable, clock, clear_b, output [6:0] H0, output [6:0] H1);
	wire w7, w6, w5, w4, w3, w2, w1, w0;
	wire [7:0] Q;
	
	
	TFlipFlop t7 (
		.T(enable),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[7])
	);
	
	TFlipFlop t6 (
		.T(w7),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[6])
	);

	
	TFlipFlop t5 (
		.T(w6),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[5])
	);

	
	TFlipFlop t4 (
		.T(w5),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[4])
	);

	
	TFlipFlop t3 (
		.T(w4),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[3])
	);

	
	TFlipFlop t2 (
		.T(w3),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[2])
	);

	
	TFlipFlop t1 (
		.T(w2),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[1])
	);

	TFlipFlop t0 (
		.T(w1),
		.clock(clock),
		.clear_b(clear_b),
		.Q(Q[0])
	);
	
	hex h0 (
		.pin({Q[4],{Q[5],{Q[6],{Q[7]}}}}),
		.h(H0)
	);

	hex h1 (
		.pin({Q[3],{Q[2],{Q[1],{Q[0]}}}}),
		.h(H1)
	);

	assign w7 = Q[7] & enable;
	assign w6 = Q[6] & w7;
	assign w5 = Q[5] & w6;
	assign w4 = Q[4] & w5;
	assign w3 = Q[3] & w4;
	assign w2 = Q[2] & w3;
	assign w1 = Q[1] & w2;
	
endmodule



module TFlipFlop (T, clock, clear_b, Q);			
	input T;
	input clock;
	input clear_b;
	output reg Q;
	always@(posedge clock, negedge clear_b)
		if(clear_b == 0)
			Q <= 0;
		else
			Q <= T ^ Q;	
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

