module lab3_part2(SW, LEDR);
	input [9:0] SW;
	output[9:0] LEDR;
	
	wire w1, w2, w3;
		
	full_adder f0 (
		.a(SW[4]),
		.b(SW[0]),
		.cin(SW[8]),
		.s(LEDR[0]),
		.cout(w1)
	);
	
	full_adder f1 (
		.a(SW[5]),
		.b(SW[1]),
		.cin(w1),
		.s(LEDR[1]),
		.cout(w2)
	);
	
	full_adder f2 (
		.a(SW[6]),
		.b(SW[2]),
		.cin(w2),
		.s(LEDR[2]),
		.cout(w3)
	);
	
	full_adder f3 (
		.a(SW[7]),
		.b(SW[3]),
		.cin(w3),
		.s(LEDR[3]),
		.cout(LEDR[9])
	);
	
	
		
	
	
endmodule

//Each full adder has three inputs and two outputs
module full_adder (input a, b, cin, output cout, s);
	assign s = a ^ b ^ cin;
	assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

