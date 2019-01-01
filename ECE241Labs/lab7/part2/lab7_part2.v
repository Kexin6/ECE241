module lab7_part2(
		SW,
		KEY,
		CLOCK_50,
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B
		);
		
		input [9:0]SW;
		input	[3:0]KEY;
		input	CLOCK_50;				//	50 MHz
		
		output			VGA_CLK;   				//	VGA Clock
		output			VGA_HS;					//	VGA H_SYNC
		output			VGA_VS;					//	VGA V_SYNC
		output			VGA_BLANK_N;				//	VGA BLANK
		output			VGA_SYNC_N;				//	VGA SYNC
		output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
		output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
		output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
		

		
		fill f0 (
			.CLOCK_50(CLOCK_50),						//	On Board 50 MHz
			// Your inputs and outputs here
			.load_x(~KEY[3]),
			.plot(~KEY[1]),
			.black(~KEY[2]),
			.x_position(SW[6:0]),
			.y_position(SW[6:0]),
			.color(SW[9:7]),
			.KEY(KEY),							// On Board Keys
			// The ports below are for the VGA output.  Do not change.
			.VGA_CLK(VGA_CLK),   						//	VGA Clock
			.VGA_HS(VGA_HS),							//	VGA H_SYNC
			.VGA_VS(VGA_VS),							//	VGA V_SYNC
			.VGA_BLANK_N(VGA_BLANK_N),						//	VGA BLANK
			.VGA_SYNC_N(VGA_SYNC_N),						//	VGA SYNC
			.VGA_R(VGA_R),   						//	VGA Red[9:0]
			.VGA_G(VGA_G),	 						//	VGA Green[9:0]
			.VGA_B(VGA_B)   						//	VGA Blue[9:0]
	);
	


endmodule

// Part 2 skeleton

module fill
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		load_x,
		plot,
		black,
		x_position,
		y_position,
		color,
		KEY,							// On Board Keys
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;					
	// Declare your inputs and outputs here
	input load_x, plot, black;
	input [7:0]x_position;
	input [6:0]y_position;
	input [2:0]color;
	
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	logic l0(
		.clock(CLOCK_50), 
		.resetn(resetn), 
		.load_x(load_x), 
		.black(black), 
		.plot(plot), 
		.color(color), 
		.x_position(x_position), 
		.y_position(y_position),
		.x_out(x), 
		.y_out(y), 
		.color_out(colour)
	);
	
endmodule

module logic(clock, resetn, load_x, black, plot, color, x_position, y_position,
x_out, y_out, color_out);
	input clock, resetn, plot, black, load_x;
	input [2:0] color;
	input [7:0] x_position;
	input [6:0] y_position;
	output [7:0] x_out;
	output [6:0] y_out;
	output [2:0] color_out;
	
	wire black, enable_c, enable_color, enable_plot, enable_x_adder, enable_y_adder, 
		enable_x, enable_y, enable_black, enable_rc;
	wire block_count, black_count;
	
	
	control c0(
		.resetn(resetn), 
		.plot(plot), 
		.black(black), 
		.clock50(clock), 
		.load_x(load_x), 
		.block_count(block_count),
		.black_count(black_count),
		.enable_c(enable_c), 
		.enable_color(enable_color), 
		.enable_plot(enable_plot), 
		.enable_x_adder(enable_x_adder), 
		.enable_y_adder(enable_y_adder), 
		.enable_x(enable_x), 
		.enable_y(enable_y), 
		.enable_black(enable_black), 
		.enable_rc(enable_rc)
	);
					
					
	dataPath d0(
		.enable_c(enable_c), 
		.enable_color(enable_color), 
		.enable_plot(enable_plot), 
		.enable_x_adder(enable_x_adder), 
		.enable_y_adder(enable_y_adder), 
		.enable_x(enable_x), 
		.enable_y(enable_y), 
		.enable_black(enable_black), 
		.enable_rc(enable_rc),
		.color(color), 
		.resetn(resetn), 
		.clock(clock), 
		.x_position(x_position), 
		.y_position(y_position), 
		.x_out(x_out), 
		.y_out(y_out), 
		.color_out(color_out), 
		.block_count(block_count), 
		.black_count(black_count)
	);

endmodule


module control(input resetn, plot, black, clock50, load_x, 
					input [3:0] block_count, 
					input [15:0] black_count, 
					output reg enable_c, enable_color, enable_plot, enable_x_adder, enable_y_adder, 
					enable_x, enable_y, enable_black, enable_rc);
					
	reg [2:0] current_state, next_state;
	
	localparam S_LOAD_X = 3'd0,
				  WAIT_0 = 3'd1,
				  S_LOAD_Y_COLOR = 3'd2,
				  WAIT_1 = 3'd3,
				  S_DRAW = 3'd4,
				  OUT = 3'd5,
				  BLACK = 3'd6;
				  
	
	// Next state logic aka our state table
	always@(*)
    begin: state_table 
            case (current_state)
					S_LOAD_X: begin
						if(black) next_state = BLACK;
						else next_state = load_x ? WAIT_0 : S_LOAD_X;
						end // Loop in current state until value is input
					WAIT_0: begin
						if(black) next_state = BLACK;
						else next_state = load_x ? WAIT_0 : S_LOAD_Y_COLOR;
						end 
					S_LOAD_Y_COLOR: begin
						if(black) next_state = BLACK;
						else next_state = plot ? WAIT_1 : S_LOAD_Y_COLOR;
						end 
					WAIT_1: begin
						if(black) next_state = BLACK;
						else next_state = plot ?  WAIT_1: S_DRAW;
						end 
					S_DRAW: begin
						if(black) next_state = BLACK;
						else next_state = (block_count <= 4'd15) ?  S_DRAW: OUT;
						end 
					OUT: begin
						if(black) next_state = BLACK;
						else next_state = S_LOAD_X;
						end 
					BLACK: next_state = (black_count <= 16'b1111111111111111) ? BLACK: OUT;
					
	
				endcase
    end // state_table
	
	 // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0 to avoid latches.
		  enable_c = 1'b0;
		  enable_color = 1'b0;
		  enable_plot = 1'b0;
		  enable_x_adder = 1'b0;
		  enable_y_adder = 1'b0;
		  enable_x = 1'b0;
		  enable_y = 1'b0; 
		  enable_black = 1'b0;
		  enable_rc = 1'b1;
		  
		  case (current_state)
					S_LOAD_X: begin
						enable_x = 1'b1;
						end 
					S_LOAD_Y_COLOR: begin
						enable_y = 1'b1;
						enable_color = 1'b1;
						end
					S_DRAW: begin
						enable_c = 1'b1;
						enable_plot = 1'b1;
						enable_x_adder = 1'b1;
						enable_y_adder = 1'b1;
						end 
					OUT: begin
						 enable_rc = 1'b0;
						end 
					BLACK: begin
						enable_black = 1'b1;
						enable_x_adder = 1'b1;
						enable_y_adder = 1'b1;
						enable_plot = 1'b1;
						end 
		  
				// default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals

	     // current_state registers
    always@(posedge clock50)
    begin: state_FFs
        if(!resetn)
            current_state <= S_LOAD_X;
        else
            current_state <= next_state;
    end // state_FFS
	 
endmodule

module dataPath(input enable_c, enable_color, enable_plot, enable_x_adder, enable_y_adder, 
					enable_x, enable_y, enable_black, enable_rc,
					input [3:0] color, input resetn, clock, 
					input [7:0] x_position, input [6:0] y_position, 
					output reg [7:0] x_out, output reg [6:0] y_out, 
					output reg [2:0] color_out, output reg [3:0] block_count, 
					output reg [15:0] black_count);
		
		reg [7:0] x_initial;
		reg [6:0] y_initial;
		
		
		//4-bit counter
		always@(posedge clock) begin
			if(!resetn | !enable_rc) block_count <= 4'b0;
			else if(enable_c) block_count <= block_count + 4'b1;
		end
		
		//16-bit counter
		always@(posedge clock) begin
			if(!resetn | !enable_rc) black_count <= 16'b0;
			else if(enable_black) black_count <= black_count + 1'b1;
		end
		
		//register
		always@(posedge clock)begin
			if(!resetn) begin
				x_initial <= 8'b0;
				y_initial <= 7'b0;
				color_out <= 3'b0;
			end
			else begin
			if(enable_x) 
				begin
				x_initial[7] <= 0;
				x_initial[6:0] <= x_position;
				end
			if(enable_y) y_initial[6:0] <= y_position;
			if(enable_color) color_out <= color;
			
			end
		end
		
		//adder
		always@(posedge clock) begin
			if(resetn)
				begin
					x_out <= 8'b0;
					y_out <= 7'b0;
				end
			else if (enable_x_adder) x_out <= x_initial + block_count[1:0];
			else if (enable_y_adder) y_out <= y_initial + block_count[3:2];
			else if (enable_black) begin
				x_out <= black_count[7:0];
				y_out <= black_count[14:8];
			end
		
		
		end
		

endmodule
