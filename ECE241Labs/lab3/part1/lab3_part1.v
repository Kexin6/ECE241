module lab3_part1(SW, LEDR);

	//ports for input and output
	input [9:0] SW;
	output [9:0] LEDR;
	
	//
	seven_to_one v0 (
		.MuxSelect(SW[9:7]),
		.Input(SW[6:0]),
		.export(LEDR[0])
	);	
		
	
endmodule

module seven_to_one(input [6:0] Input, input [2:0] MuxSelect, output export);
	reg Out;
	always @(*)
	begin
		case(MuxSelect[2:0])
			3'b000: Out = Input[0];
			3'b001: Out = Input[1];
			3'b010: Out = Input[2];
			3'b011: Out = Input[3];
			3'b100: Out = Input[4];
			3'b101: Out = Input[5];
			3'b110: Out = Input[6];
			default: Out = Input[0];
		endcase
	end
	
	assign export = Out;
	
endmodule
			