//LEDR[0] output display
module lab2_part2(LEDR, SW);
	inout [9:0] SW;
	output [9:0] LEDR;
	
	//Declare wires for connecting instances
	wire w0, w1, w2;
	
	//assign port SW[9] and wire w0 to pins for v7404 instance
	v7404 v1 (
		.pin1(SW[9]),
		.pin2(w0)
	);
	
	//assign ports and wires to pins for v7406 instance
	v7408 v2 (
		.pin4(SW[0]),
		.pin5(w0),
		.pin6(w1),
		.pin1(SW[9]),
		.pin2(SW[1]),
		.pin3(w2)
	);
	
	//assign port LEDR[0] and wires w1 and w2 to pins for v7432 instance
	v7432 v3 (
		.pin1(w1),
		.pin2(w2),
		.pin3(LEDR[0])
	);

endmodule

//Instantiate the first module v7404 using ordered port
module v7404(input pin1,pin3, pin5, pin9, pin11, pin13, output pin2, pin4, pin6, pin8, pin10, pin12);
	assign pin2 = (~pin1); //not gate
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;
endmodule

//Instantiate the first module v7408 using ordered port
module v7408(input pin1, pin2, pin4, pin5, pin12, pin13, pin10, pin9, output pin3, pin6, pin8, pin11);
	//and gates
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;
endmodule

//Instantiate the first module v7432 using ordered port
module v7432(input pin1, pin2, pin4, pin5, pin12, pin13, pin10, pin9, output pin3, pin6, pin8, pin11);
	assign pin3 = pin1 | pin2; // or gate
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;
	
endmodule
