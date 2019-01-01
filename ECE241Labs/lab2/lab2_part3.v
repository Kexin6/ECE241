//top module for lab2 part3 hex convertor
module lab2_part3(SW, HEX0);
	input [3:0] SW;
	output [6:0]HEX0;
	
	//assign ports to pins for HEX0[6:0]
	Eqn0 h0 (
		.pin1(SW[3]),
		.pin2(SW[2]),
		.pin3(SW[1]),
		.pin4(SW[0]),
		.pin5(HEX0[0])
	);
	
	Eqn1 h1 (
		.pin1(SW[3]),
		.pin2(SW[2]),
		.pin3(SW[1]),
		.pin4(SW[0]),
		.pin5(HEX0[1])	
	);
	
	Eqn2 h2 (
		.pin1(SW[3]),
		.pin2(SW[2]),
		.pin3(SW[1]),
		.pin4(SW[0]),
		.pin5(HEX0[2])	
	);
	
	Eqn3 h3 (
		.pin1(SW[3]),
		.pin2(SW[2]),
		.pin3(SW[1]),
		.pin4(SW[0]),
		.pin5(HEX0[3])	
	);
	
	Eqn4 h4 (
		.pin1(SW[3]),
		.pin2(SW[2]),
		.pin3(SW[1]),
		.pin4(SW[0]),
		.pin5(HEX0[4])	
	);
	
	Eqn5 h5 (
		.pin1(SW[3]),
		.pin2(SW[2]),
		.pin3(SW[1]),
		.pin4(SW[0]),
		.pin5(HEX0[5])	
	);
	
	Eqn6 h6 (
		.pin1(SW[3]),
		.pin2(SW[2]),
		.pin3(SW[1]),
		.pin4(SW[0]),
		.pin5(HEX0[6])	
	);
	

endmodule

//module for 0th led light bar HEX0[0]
module Eqn0(input pin1, pin2, pin3, pin4, output pin5);
	assign pin5 = (~pin1 & ~pin2 & ~pin3 & pin4) | (~pin1 & pin2 & ~pin3 & ~pin4) | 
		(pin1 & ~pin2 & pin3 & pin4) | (pin1 & pin2 & ~pin3 & pin4);
endmodule

//module for 1st led light bar HEX0[1]
module Eqn1(input pin1, pin2, pin3, pin4, output pin5);
	assign pin5 = (~pin1 & pin2 & ~pin3 & pin4) | (~pin1 & pin2 & pin3 & ~pin4) |(pin1 & ~pin2 & pin3 & pin4) |
		(pin1 & pin2 & ~pin3 & ~pin4) | (pin1 & pin2 & pin3 & ~pin4) | (pin1 & pin2 & pin3 & pin4);
endmodule

//module for 2nd led light bar HEX0[2]
module Eqn2(input pin1, pin2, pin3, pin4, output pin5);
	assign pin5 = (~pin1 & ~pin2 & pin3 & ~pin4) | (pin1 & pin2 & ~pin3 & ~pin4) | 
		(pin1 & pin2 & pin3 & ~pin4) | (pin1 & pin2 & pin3 & pin4);
endmodule

//module for 3rd led light bar HEX0[3]
module Eqn3(input pin1, pin2, pin3, pin4, output pin5);
	assign pin5 = (~pin1 & ~pin2 & ~pin3 & pin4) | (~pin1 & pin2 & ~pin3 & ~pin4) | (~pin1 & pin2 & pin3 & pin4) |
		(pin1 & ~pin2 & pin3 & ~pin4) | (pin1 & pin2 & pin3 & pin4);
endmodule
	
//module for 4th led light bar HEX0[4]
module Eqn4(input pin1, pin2, pin3, pin4, output pin5);
	assign pin5 = (~pin1 & ~pin2 & ~pin3 & pin4) | (~pin1 & ~pin2 & pin3 & pin4) | (~pin1 & pin2 & ~pin3 & ~pin4) |
		(~pin1 & pin2 & ~pin3 & pin4) | (~pin1 & pin2 & pin3 & pin4) | (pin1 & ~pin2 & ~pin3 & pin4);
endmodule

//module for 5th led light bar HEX0[5]
module Eqn5(input pin1, pin2, pin3, pin4, output pin5);
	assign pin5 = (~pin1 & ~pin2 & ~pin3 & pin4) | (~pin1 & ~pin2 & pin3 & ~pin4) | (~pin1 & ~pin2 & pin3 & pin4) |
		(~pin1 & pin2 & pin3 & pin4) | (pin1 & pin2 & ~pin3 & pin4);
endmodule

//module for 6th led light bar HEX0[6]
module Eqn6(input pin1, pin2, pin3, pin4, output pin5);
	assign pin5 = (~pin1 & ~pin2 & ~pin3 & ~pin4)| (~pin1 & ~pin2 & ~pin3 & pin4) |
		(~pin1 & pin2 & pin3 & pin4) | (pin1 & pin2 & ~pin3 & ~pin4);
endmodule


