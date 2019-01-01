module hexDecode (
	input [3:0] in ,
	output [6:0] out);

	//equation 0 , for segment 0 etc.
	assign out[0] = ~((in[1]&(~in[3]))|((~in[0])&(~in[2]))|(in[3]&(~in[0]))|(in[1]&in[2])|(in[0]&(~in[3])&in[2])|((~in[1])&in[3]&(~in[2])));
	assign out[1] = ~(((~in[3])&(~in[2]))|((~in[0])&(~in[2]))|((~in[1])&(~in[0])&(~in[3]))|(in[1]&in[0]&(~in[3]))|((~in[1])&in[0]&in[3]));
	assign out[2] = ~((in[3]&(~in[2]))|((~in[1])&(~in[3]))|((~in[1])&in[0])|(in[0]&(~in[3]))|(in[1]&in[2]&(~in[3])));
	assign out[3] = ~(((~in[1])&in[3])|((~in[3])&(~in[2])&(~in[0]))|((~in[3])&(~in[2])&in[1])|(in[1]&(~in[0])&in[2])|(in[0]&in[3]&(~in[2]))|((~in[1])&in[0]&in[2]));
	assign out[4] = ~((in[1]&(~in[0]))|((~in[0])&(~in[2]))|(in[3]&in[2])|((~in[1])&(~in[0])&in[3])|(in[1]&in[0]&in[3]));
	assign out[5] = ~((in[3]&(~in[2]))|((~in[1])&(~in[0]))|((~in[1])&(~in[3])&in[2])|(in[1]&in[3]&in[2])|(in[1]&(~in[0])&in[2]));
	assign out[6] = ~((in[1]&(~in[0]))|(in[3]&(~in[2]))|(in[1]&(~in[3])&(~in[2]))|((~in[1])&(~in[3])&in[2])|(in[0]&in[3]&in[2]));
	

endmodule
