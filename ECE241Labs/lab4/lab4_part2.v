module lab4_part2(SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY);
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire [7:0] wrin, wrout;
	
	register r0 (
		.in(wrin),
		.Reset_b(SW[9]),
		.Clock(KEY[0]),
		.out(wrout)
	);
	
	ALU a0 (
		.data(SW[3:0]),
		.registerIn(wrout),
		.KEY(KEY[3:1]),
		.regout(wrin)
	);
	
	hex h0(
		.pin1(SW[3]),
		.pin2(SW[2]),
		.pin3(SW[1]),
		.pin4(SW[0]),
		.h0(HEX0[0]),
		.h1(HEX0[1]),
		.h2(HEX0[2]),
		.h3(HEX0[3]),
		.h4(HEX0[4]),
		.h5(HEX0[5]),
		.h6(HEX0[6])
	);
	
	hex h1(
		.pin1(0),
		.pin2(0),
		.pin3(0),
		.pin4(0),
		.h0(HEX1[0]),
		.h1(HEX1[1]),
		.h2(HEX1[2]),
		.h3(HEX1[3]),
		.h4(HEX1[4]),
		.h5(HEX1[5]),
		.h6(HEX1[6])
	);
	
	hex h2(
		.pin1(0),
		.pin2(0),
		.pin3(0),
		.pin4(0),
		.h0(HEX2[0]),
		.h1(HEX2[1]),
		.h2(HEX2[2]),
		.h3(HEX2[3]),
		.h4(HEX2[4]),
		.h5(HEX2[5]),
		.h6(HEX2[6])
	);
	
	hex h3(
		.pin1(0),
		.pin2(0),
		.pin3(0),
		.pin4(0),
		.h0(HEX3[0]),
		.h1(HEX3[1]),
		.h2(HEX3[2]),
		.h3(HEX3[3]),
		.h4(HEX3[4]),
		.h5(HEX3[5]),
		.h6(HEX3[6])
	);
	
	hex h4(
		.pin1(wrout[3]),
		.pin2(wrout[2]),
		.pin3(wrout[1]),
		.pin4(wrout[0]),
		.h0(HEX4[0]),
		.h1(HEX4[1]),
		.h2(HEX4[2]),
		.h3(HEX4[3]),
		.h4(HEX4[4]),
		.h5(HEX4[5]),
		.h6(HEX4[6])
	);
	
	hex h5(
		.pin1(wrout[7]),
		.pin2(wrout[6]),
		.pin3(wrout[5]),
		.pin4(wrout[4]),
		.h0(HEX5[0]),
		.h1(HEX5[1]),
		.h2(HEX5[2]),
		.h3(HEX5[3]),
		.h4(HEX5[4]),
		.h5(HEX5[5]),
		.h6(HEX5[6])
	);
	
	assign LEDR[7:0] = wrout[7:0];
endmodule


//ALU modules

//Modules for the first case
module Eqn0(input [3:0] A, input [3:0] B, output [7:0] ALUout);
		wire w1, w2, w3;
		
		assign cin = 1'b0;
		assign ALUout[7] = 0;
		assign ALUout[6] = 0;
		assign ALUout[5] = 0;
	
	full_adder f3 (
		.a(A[3]),
		.b(B[3]),
		.cin(w3), 
		.s(ALUout[3]),
		.cout(ALUout[4])
	);
	
	full_adder f2 (
		.a(A[2]),
		.b(B[2]),
		.cin(w2),
		.s(ALUout[2]),
		.cout(w3)
	);
	
	full_adder f1 (
		.a(A[1]),
		.b(B[1]),
		.cin(w1),
		.s(ALUout[1]),
		.cout(w2)
	);
	
	full_adder f0 (
		.a(A[0]),
		.b(B[0]),
		.cin(cin),
		.s(ALUout[0]),
		.cout(w1)
	);
	

endmodule

module full_adder (input a, b, cin, output cout, s);
	assign s = a ^ b ^ cin;
	assign cout = (a & b) | (b & cin) | (a & cin);
endmodule


//Module for the second case
module Eqn1(input [3:0] A, input [3:0] B, output [7:0] ALUout);
	assign ALUout = A + B;
	assign ALUout[7] = 1'b0;
	assign ALUout[6] = 1'b0;
	assign ALUout[5] = 1'b0;
endmodule
  
  
//Modules for the third case
module Eqn2(input [3:0] A, input [3:0] B, output [7:0] ALUout);
	assign ALUout = {~(A | B), ~(A & B)};
	
endmodule


//Module for the 4th case
module Eqn3(input [3:0] A, input [3:0] B, output reg [7:0] ALUout);

always @(*)
	begin
		if ((|A) | (|B)) 
			ALUout = 8'b11000000; 
		else 
			ALUout = 8'b00000000;
	end
endmodule



//Module for the 5th case 
module Eqn4(input [3:0] A, input [3:0] B, output reg [7:0] ALUout);

always @(*)
	begin
		if ((A == 4'b1100 | A == 4'b0110 | A == 4'b0011 | A == 4'b1001 | A == 4'b1010 | A == 4'b0101) 
		& (B == 4'b1110 | B == 4'b0111 | B == 4'b1011 | B == 4'b1101)) 
			ALUout = 8'b00111111; 
		else 
			ALUout = 8'b00000000;
	end
endmodule


//Module for the 6th case
module Eqn5(input [3:0] A, input [3:0] B, output [7:0] ALUout);
	assign ALUout[7:4] = B;
	assign ALUout[3:0] = ~A;
endmodule


//Modules for the 7th case
module Eqn6(input [3:0] A, input [3:0] B, output [7:0] ALUout);
	assign ALUout = {A ^ B, A ^~ B};
	
endmodule

module ALU(input [3:0] data, input [3:1] KEY, input [7:0] registerIn, output [7:0] regout);
	
	wire [7:0] w0, w1, w2, w3, w4, w5, w6, w7;
	//Instantiation of the equations
	Eqn0 e0 (
		.A(data[3:0]),
		.B(registerIn[3:0]),
		.ALUout(w0[7:0])
	);
	
	Eqn1 e1 (
		.A(data[3:0]),
		.B(registerIn[3:0]),
		.ALUout(w1[7:0])
	);
	
	Eqn2 e2 (
		.A(data[3:0]),
		.B(registerIn[3:0]),
		.ALUout(w2[7:0])
	);	
	
	Eqn3 e3 (
		.A(data[3:0]),
		.B(registerIn[3:0]),
		.ALUout(w3[7:0])
	);
	
	Eqn4 e4 (
		.A(data[3:0]),
		.B(registerIn[3:0]),
		.ALUout(w4[7:0])
	);
	
	Eqn5 e5 (
		.A(data[3:0]),
		.B(registerIn[3:0]),
		.ALUout(w5[7:0])
	);
	
	Eqn6 e6 (
		.A(data[3:0]),
		.B(registerIn[3:0]),
		.ALUout(w6[7:0])
	);

	
	reg [7:0] Output;
	always @(*)

		begin
			case(KEY)
				3'b000: Output = w0;
				3'b001: Output = w1;
				3'b010: Output = w2;
				3'b011: Output = w3;
				3'b100: Output = w4;
				3'b101: Output = w5;
				3'b110: Output = w6;
				3'b111: Output = registerIn;
				default: Output = w0;
			endcase
		end
	assign regout = Output;
endmodule

module register (input [7:0]in, input Reset_b, Clock, output reg[7:0] out);
	always @(posedge Clock)
	begin
		//active low
		if(Reset_b == 1'b0)
			out <= 8'b00000000;
		else
			out <= in;
	end
	
endmodule


	
module hex(input pin1, pin2, pin3, pin4, output h0, h1, h2, h3, h4, h5, h6);
	assign h0 = (~pin1 & ~pin2 & ~pin3 & pin4) | (~pin1 & pin2 & ~pin3 & ~pin4) | 
		(pin1 & ~pin2 & pin3 & pin4) | (pin1 & pin2 & ~pin3 & pin4);
	assign h1 = (~pin1 & pin2 & ~pin3 & pin4) | (~pin1 & pin2 & pin3 & ~pin4) |(pin1 & ~pin2 & pin3 & pin4) |
		(pin1 & pin2 & ~pin3 & ~pin4) | (pin1 & pin2 & pin3 & ~pin4) | (pin1 & pin2 & pin3 & pin4);
	assign h2 = (~pin1 & ~pin2 & pin3 & ~pin4) | (pin1 & pin2 & ~pin3 & ~pin4) | 
		(pin1 & pin2 & pin3 & ~pin4) | (pin1 & pin2 & pin3 & pin4);
	assign h3 = (~pin1 & ~pin2 & ~pin3 & pin4) | (~pin1 & pin2 & ~pin3 & ~pin4) | (~pin1 & pin2 & pin3 & pin4) |
		(pin1 & ~pin2 & pin3 & ~pin4) | (pin1 & pin2 & pin3 & pin4);
	assign h4 = (~pin1 & ~pin2 & ~pin3 & pin4) | (~pin1 & ~pin2 & pin3 & pin4) | (~pin1 & pin2 & ~pin3 & ~pin4) |
		(~pin1 & pin2 & ~pin3 & pin4) | (~pin1 & pin2 & pin3 & pin4) | (pin1 & ~pin2 & ~pin3 & pin4);
	assign h5 = (~pin1 & ~pin2 & ~pin3 & pin4) | (~pin1 & ~pin2 & pin3 & ~pin4) | (~pin1 & ~pin2 & pin3 & pin4) |
		(~pin1 & pin2 & pin3 & pin4) | (pin1 & pin2 & ~pin3 & pin4);
	assign h6 = (~pin1 & ~pin2 & ~pin3 & ~pin4)| (~pin1 & ~pin2 & ~pin3 & pin4) |
		(~pin1 & pin2 & pin3 & pin4) | (pin1 & pin2 & ~pin3 & ~pin4);
		
endmodule
