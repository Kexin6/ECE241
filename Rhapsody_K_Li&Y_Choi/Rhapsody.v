// part3

module Rhapsody
	(
		
      ///////// ADC /////////
      inout              ADC_CS_N,
      output             ADC_DIN,
      input              ADC_DOUT,
      output             ADC_SCLK,

      ///////// CLOCK /////////
      input              CLOCK_50,

      ///////// DRAM /////////
      output      [12:0] DRAM_ADDR,
      output      [1:0]  DRAM_BA,
      output             DRAM_CAS_N,
      output             DRAM_CKE,
      output             DRAM_CLK,
      output             DRAM_CS_N,
      inout       [15:0] DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_RAS_N,
      output             DRAM_UDQM,
      output             DRAM_WE_N,

      ///////// FPGA /////////
      output             FPGA_I2C_SCLK,
      inout              FPGA_I2C_SDAT,
      input  resetn,
      ///////// TD /////////
      input              TD_CLK27,
      input      [7:0]  TD_DATA,
      input             TD_HS,
      output             TD_RESET_N,
      input             TD_VS,
		input 				td_reset,
		
		
		input				AUD_ADCDAT;

		/*input and output of audio module*/
		// Bidirectionals
		inout				AUD_BCLK;
		inout				AUD_ADCLRCK;
		inout				AUD_DACLRCK;
		inout				I2C_SDAT;

		// Outputs
		output				AUD_XCK;
		output				AUD_DACDAT;

		output				I2C_SCLK;
	
		
		//debug
		output      [7:0]  VGA_B,
      output             VGA_BLANK_N,
      output             VGA_CLK,
      output      [7:0]  VGA_G,
      output             VGA_HS,
      output      [7:0]  VGA_R,
      output             VGA_SYNC_N,
      output             VGA_VS,
		
		output [9:0] debug,
		output [10:0] coordinate_x,
		output [10:0] coordinate_y,
		output [2:0] position
	);
	//outputing the position of player
	wire [9:0] camera_out;
	wire [2:0] position;
	wire [9:0] vga_r,vga_b,vga_g; wire vga_hs,vga_vs,vga_blank_n,vga_sync_n,vga_clk;
	wire [10:0] x_cor, y_cor;
	camera camera1(
			.clk(CLOCK_50),
			.clk_27(TD_CLK27),
			.resetn(resetn),
			.debug(camera_out),
			.td_data(TD_DATA),
			.td_hs(TD_HS),
			.td_vs(TD_VS),
			.td_reset_n(TD_RESET_N),
			.i2c_sclk(I2C_SCLK),
			.i2c_sdat(I2C_SDAT),
			.VGA_r(vga_r),
			.VGA_g(vga_g),
			.VGA_b(vga_b),
			.VGA_hs(vga_hs),
			.VGA_vs(vga_vs),
			.VGA_blank_n(vga_blank_n),
			.VGA_sync_n(vga_sync_n),
			.VGA_clk(vga_clk),
			.position(position),
			.x_cor(coordinate_x),
			.y_cor(coordinate_y)
	);
	
	output [6:0] HEX0,HEX1,HEX2,HEX3;
	wire [3:0] first_digit,second_digit;
	/*
	hexDecode hex0(updated_score[3:0], HEX0[6:0]);
	hexDecode hex1({2'b00,updated_score[5:4]},HEX1[6:0]);
	hexDecode hex2(first_digit,HEX2[6:0]);
	hexDecode hex3(second_digit,HEX3[6:0]);
	*/
	hexDecode hex0(y_cor[3:0], HEX0[6:0]);
	hexDecode hex1(y_cor[7:4],HEX1[6:0]);
	hexDecode hex2({1'b0,y_cor[10:8]},HEX2[6:0]);
	hexDecode hex3(x_cor[3:0], HEX3[6:0]);
	hexDecode hex4(x_cor[7:4],HEX4[6:0]);
	hexDecode hex5({1'b0,x_cor[10:8]},HEX5[6:0]);
	//score module
	wire  [6:0] updated_score;
	wire score_updated,win;
	score score_update(
	.clk(CLOCK_50),
	.resetn(resetn),
	.expected_position(3'b111),
	.real_position(position),
	.updated_score(updated_score),
	.score_updated(score_updated),
	.win(win)
	); 
	/*inout for vga display module */
	
	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;
	// Declare your inputs and outputs here
	input [9:0] SW;
	output [9:0] LEDR;
	//assign LEDR[2:0] = position;
	//assign LEDR[9:3] = updated_score[6:0];
	//assign LEDR[9:9] = score_updated;
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

	wire [8:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Create wires

   //wire clearn = ~KEY[1];
   //wire plot = ~KEY[2];
	wire clock_60;

	// wires connected btw control and datapath
	wire [4:0] feedback_counter;
	wire [6:0] feedback_counter_black_y, feedback_counter_title_y;
	wire [7:0] feedback_counter_black_x, feedback_counter_title_x;
	wire [7:0] feedback_x_counter;
	wire [6:0] feedback_y_counter;
	wire [6:0] feedback_y_counter2;
	wire [6:0] feedback_y_counter3;
	wire [5:0] feedback_counter_1,feedback_counter_2;
	wire [7:0] feedback_counter_clear;
	wire load_x, load_y;

	wire is_update, is_update2, is_update3;
	wire is_end, is_end2, is_end3;
	wire colour_black, colour_black2, colour_black3;
	wire direction_x_change;
	wire direction_y_change;
	wire clock_60_Hz;
	wire [19:0]Qq;

	//assign LEDR[6:0] = feedback_title_counter;
	// assign LEDR[1] = direction_x_change;
	// assign LEDR[2] = direction_y_change;
	wire is_black, ld_title;
	wire WE1, WE2, WE3, WE4;
	wire [14:0] backAddress, titleAddress;
	wire [8:0] color_q, color_first;
	wire [3:0] leftAddress, middleAddress, rightAddress;
	wire [8:0] test_color;
	wire [8:0] left_color, middle_color, right_color;
	//assign LEDR[3:0] = leftAddress;
	wire update_1,update_2,updated_clear;
	
	mux choose(
				.choice(SW[1:0]), 
				.clock_50(CLOCK_50), 
				.q(Qq)
				);
	counter_60 clock60(
				.clock(CLOCK_50),
			   .pulse(clock_60_Hz),
				.q(Qq)
				);

	control c0(.clk(CLOCK_50),
			   .slowerClk(clock_60_Hz),
            .resetn(resetn),
			   .counter(feedback_counter),
			   .x_counter(feedback_x_counter),
			   .y_counter(feedback_y_counter),
				.y_counter2(feedback_y_counter2),
				.y_counter3(feedback_y_counter3),
				.counter_1(feedback_counter_1),
				.counter_2(feedback_counter_2),
				.counter_clear(feedback_counter_clear),
				.counter_black_y(feedback_counter_black_y),
				.counter_title_y(feedback_counter_title_y),
				.counter_black_x(feedback_counter_black_x),
				.counter_title_x(feedback_counter_title_x),
            .ld_plot(WE1),
				.ld_plot2(WE2),
				.ld_plot3(WE3),
			   .is_black(is_black),
				.ld_title(ld_title),
			   .is_update(is_update),
				.is_update2(is_update2),
				.is_update3(is_update3),
				.score_updated(score_updated),
			   .is_end(is_end),
				.is_end2(is_end2),
				.is_end3(is_end3),
			   .colour_black(colour_black),
				.colour_black2(colour_black2),
				.colour_black3(colour_black3),
				.update_1(update_1),
				.update_2(update_2),
				.updated_clear(updated_clear),
				.ld_score(WE4),
				.key1(KEY[1])
			   //.debug(LEDR[9:0])
            );

    datapath d0(
				.clk(CLOCK_50),
            .resetn(resetn),
           // .colour_in(SW[9:7]),
			   .ld_plot(WE1),
				.ld_plot2(WE2),
				.ld_plot3(WE3),
			   .is_black(is_black),
				.ld_title(ld_title),
			   .is_update(is_update),
				.is_update2(is_update2),
				.is_update3(is_update3),
			   .is_end(is_end),
				.is_end2(is_end2),
				.is_end3(is_end3),
			   .colour_black(colour_black),
				.colour_black2(colour_black2),
				.colour_black3(colour_black3),
				.update_1(update_1),
				.update_2(update_2),
				.updated_clear(updated_clear),
				.ld_score(WE4),
            .x_out(x),
            .y_out(y),
			   .counter(feedback_counter),
			   .counter_black_y(feedback_counter_black_y),
				.counter_title_y(feedback_counter_title_y),
				.counter_black_x(feedback_counter_black_x),
				.counter_title_x(feedback_counter_title_x),
			   .x_counter(feedback_x_counter),
			   .y_counter(feedback_y_counter),
				.y_counter2(feedback_y_counter2),
				.y_counter3(feedback_y_counter3),
				.counter_1(feedback_counter_1),
				.counter_2(feedback_counter_2),
				.counter_clear(feedback_counter_clear),
            .colour(colour),
				.backAddress(backAddress),
				.color_q(color_q),
				.leftAddress(leftAddress),
				.middleAddress(middleAddress),
				.rightAddress(rightAddress),
				.left_color(left_color),
				.right_color(right_color),
				.middle_color(middle_color),
				.score(updated_score),
				.titleAddress(titleAddress),
				.color_first(color_first),
				.first_digit(first_digit),
				.second_digit(second_digit)
             );
					
				// background
			background9 back(
					.address(backAddress),
					.clock(CLOCK_50),
					.wren(0),
					.q(color_q)
				);
			title first(
				.address(titleAddress),
				.clock(CLOCK_50),
				.wren(0),
				.q(color_first)
			);
				
				// blocks
				
			left left0(
					.address(leftAddress),
					.clock(CLOCK_50),
					.wren(0),
					.q(left_color)
				);
				
			middle middle0(
					.address(middleAddress),
					.clock(CLOCK_50),
					.wren(0),
					.q(middle_color)
				);
			right right0(
					.address(rightAddress),
					.clock(CLOCK_50),
					.wren(0),
					.q(right_color)
				);
			/*	
			music mu0(
					.CLOCK_50(CLOCK_50),
					.AUD_ADCDAT(AUD_ADCDAT),
					.AUD_BCLK(AUD_BCLK),
					.AUD_ADCLRCK(AUD_ADCLRCK),
					.AUD_DACLRCK(AUD_DACLRCK),
					.FPGA_I2C_SDAT(FPGA_I2C_SDAT),
					.AUD_XCK(AUD_XCK),
					.AUD_DACDAT(AUD_DACDAT),
					.FPGA_I2C_SCLK(FPGA_I2C_SCLK),
					.SW(SW),
					.LEDR(LEDR),
					.KEY(KEY)
			);*/
					
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	
	assign writeEn = (ld_title || is_black || WE1 || WE2 || WE3 || WE4) ? 1'b1 : 1'b0;
	//assign writeEn = WE1;
	
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			//.x({1'b0,x}),
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
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 3;
		defparam VGA.BACKGROUND_IMAGE = "title.mif";

endmodule

module control(
   input clk,
	input slowerClk,
   input resetn,
   input Black,
	input [4:0] counter, // counter for 4 x 4 block
	//input [16:0] counter_black, // counter for erase
	//input [16:0] counter_title,
	input [6:0] counter_black_y,
	input [7:0] counter_black_x,
	input [6:0] counter_title_y,
	input [7:0] counter_title_x,
	input [7:0] x_counter,
	input [6:0] y_counter,
	input [6:0] y_counter2, 
	input [6:0] y_counter3,
	input [5:0] counter_1,counter_2,
	input [7:0] counter_clear,
	input score_updated,
	input key1,
   output reg ld_plot, ld_plot2, ld_plot3, is_black, is_update, is_update2, is_update3, is_end, is_end2, is_end3, colour_black,
	colour_black2, colour_black3,update_1,update_2,updated_clear,ld_score, ld_title,// ld for counter
	output [9:0] debug
	);

	reg [4:0] plot_current_state, plot_next_state;
	reg [3:0] frameCounter;

	// Go high once 15 frames
	assign debug[4:0] = plot_current_state;
	//assign debug[6:0] = counter;
	//assign debug[9] = ld_plot;
	wire go;
	assign go = (frameCounter == 4'b0000) ? 1'b1 : 1'b0;

	
	localparam  
			
				S_PLOT_BEGIN 	 = 5'd0,
				S_CLEAR         = 5'd1,
				S_PLOT          = 5'd2,
				S_BLACK         = 5'd3,
				S_UPDATE        = 5'd4,
				S_PLOT_END      = 5'd5,
				S_PLOT_BEGIN2	 = 5'd6,
				S_CLEAR2			 = 5'd7,
				S_PLOT2			 = 5'd8,
				S_UPDATE2		 = 5'd9,
				S_PLOT_END2		 = 5'd10,
				S_PLOT_BEGIN3	 = 5'd11,
				S_CLEAR3			 = 5'd12,
				S_PLOT3			 = 5'd13,
				S_UPDATE3		 = 5'd14,
				S_PLOT_END3		 = 5'd15,
				S_WAIT 			 = 5'd16,
				S_SCORE_CLEAR 	 = 5'd17,
				S_DIGIT_1 		 = 5'd18,
				S_DIGIT_2 		 = 5'd19,
				S_TITLE 		    = 5'd20,
				S_TITLE_WAIT 	 = 5'd21,
				S_TITLE_PLOT 	 = 5'd22;
			
				
				

	always@(*)
    begin: plot_state_table
            case (plot_current_state)
				
				S_TITLE_PLOT: begin
					if(counter_title_x == 8'd159 && counter_title_y == 7'd119)
						plot_next_state = S_TITLE;
						
					else
						plot_next_state = S_TITLE_PLOT;
				
				end
				S_TITLE: begin
					if (!key1)
						plot_next_state = S_TITLE_WAIT;
					else
						plot_next_state = S_TITLE;
				end
				S_TITLE_WAIT: begin
					if (key1) 
						plot_next_state = S_BLACK;
					else 
						plot_next_state = S_TITLE_WAIT;
				end
				S_BLACK: begin
					//if (key1)
					//	plot_next_state = S_TITLE_PLOT;
					if (counter_black_x == 8'd159 && counter_black_y == 7'd119)
						plot_next_state = S_PLOT_BEGIN; // jump out of loop
					else
						plot_next_state = S_BLACK; // draw inside loop
				end
            S_PLOT_BEGIN: begin
					//if (key1)
					//	plot_next_state = S_TITLE_PLOT;
					if (~go) // loop in current state
						plot_next_state = S_PLOT_BEGIN;
					else
						plot_next_state = S_CLEAR;
				end
				S_CLEAR: begin
					//if (key1)
					//	plot_next_state = S_TITLE_PLOT;
					if (counter == 5'b10000)
						plot_next_state = S_UPDATE; // jump out of loop
					else
						plot_next_state = S_CLEAR; // draw inside loop
				end
				S_UPDATE: begin
					plot_next_state = S_PLOT;
				end
				S_PLOT: begin
					//if (key1)
					//	plot_next_state = S_TITLE_PLOT;
					if (counter == 5'b10000)
						plot_next_state = S_PLOT_END; // jump out of loop
					else
						plot_next_state = S_PLOT; // draw inside loop
				end
				S_PLOT_END: plot_next_state = S_PLOT_BEGIN2;
				S_PLOT_BEGIN2: begin
					//if (key1)
					//	plot_next_state = S_TITLE_PLOT;
					if (~go) // loop in current state
						plot_next_state = S_PLOT_BEGIN2;
				   else
						plot_next_state = S_CLEAR2;
				end
				S_CLEAR2: begin
					//if (key1)
					//	plot_next_state = S_TITLE_PLOT;
					if (counter == 5'b10000)
						plot_next_state = S_UPDATE2; // jump out of loop
					else
						plot_next_state = S_CLEAR2; // draw inside loop
				end
				S_UPDATE2: begin
					plot_next_state = S_PLOT2;
				end
				S_PLOT2: begin
					//if (key1)
					//	plot_next_state = S_TITLE_PLOT;
					if (counter == 5'b10000)
						plot_next_state = S_PLOT_END2; // jump out of loop
					else
						plot_next_state = S_PLOT2; // draw inside loop
				end
				S_PLOT_END2: plot_next_state = S_PLOT_BEGIN3;
				S_PLOT_BEGIN3: begin
					//if (key1)
					//	plot_next_state = S_TITLE_PLOT;
					if (~go) // loop in current state
						plot_next_state = S_PLOT_BEGIN3;
					else
						plot_next_state = S_CLEAR3;
				end
				S_CLEAR3: begin
					//if (key1)
					//	plot_next_state = S_TITLE_PLOT;
					if (counter == 5'b10000)
						plot_next_state = S_UPDATE3; // jump out of loop
					else
						plot_next_state = S_CLEAR3; // draw inside loop
				end
				S_UPDATE3: begin
					plot_next_state = S_PLOT3;
				end
				S_PLOT3: begin
					//if (key1)
					//	plot_next_state = S_TITLE_PLOT;
					if (counter == 5'b10000)
						plot_next_state = S_PLOT_END3; // jump out of loop
					else
						plot_next_state = S_PLOT3; // draw inside loop
				end
				S_PLOT_END3: plot_next_state = S_WAIT;
				S_WAIT: begin plot_next_state = (!score_updated) ? S_PLOT_BEGIN : S_SCORE_CLEAR;end
				S_SCORE_CLEAR: begin plot_next_state = (counter_clear == 8'b11100000) ? S_DIGIT_1:S_SCORE_CLEAR;end
				S_DIGIT_1: begin plot_next_state = (counter_1 == 6'b111111)? S_DIGIT_2:S_DIGIT_1;end
				S_DIGIT_2: begin plot_next_state = (counter_2 == 6'b111111)? S_PLOT_BEGIN : S_DIGIT_2;end
				
            default:    plot_next_state = S_TITLE;
        endcase
    end // plot_state_table
	 
    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0 to avoid latches.
        // This is a different style from using a default statement.
        // It makes the code easier to read.  If you add other out
        // signals be sure to assign a default value for them here.
		ld_plot = 1'b0;
		ld_plot2 = 1'b0;
		ld_plot3 = 1'b0;
		is_black = 1'b0;
		is_update = 1'b0;
		is_update2 = 1'b0;
		is_update3 = 1'b0;
		is_end = 1'b0;
		is_end2 = 1'b0;
		is_end3 = 1'b0;
		colour_black = 1'b0;
		colour_black2 = 1'b0;
		colour_black3 = 1'b0;
		update_1 = 1'b0;
		update_2 = 1'b0;
		updated_clear = 1'b0;
		ld_score = 1'b0;
		ld_title = 1'b0;
		case (plot_current_state)
			S_TITLE_PLOT: begin
				ld_title = 1'b1;
			end
			S_BLACK: begin
				ld_plot = 1'b1;
				ld_plot2 = 1'b1;
				ld_plot3 = 1'b1;
				is_black = 1'b1;
			end
			S_PLOT: begin
				ld_plot = 1'b1;
			end
			S_PLOT2: begin
				ld_plot2 = 1'b1;
			end
			S_PLOT3: begin
				ld_plot3 = 1'b1;
			end
			S_CLEAR: begin
				ld_plot = 1'b1;
				colour_black = 1'b1;
			end
			S_CLEAR2: begin
				ld_plot2 = 1'b1;
				colour_black2 = 1'b1;
			end
			S_CLEAR3: begin
				ld_plot3 = 1'b1;
				colour_black3 = 1'b1;
			end
			S_UPDATE: begin
				is_update = 1'b1;
			end
			S_UPDATE2: begin
				is_update2 = 1'b1;
			end
			S_UPDATE3: begin
				is_update3 = 1'b1;
			end
			S_PLOT_END: begin
				is_end = 1'b1;
			end
			S_PLOT_END2: begin
				is_end2 = 1'b1;
			end
			S_PLOT_END3: begin
				is_end3 = 1'b1;
			end
			S_SCORE_CLEAR: begin updated_clear = 1'b1;ld_score = 1'b1;end
			S_DIGIT_1: begin update_1 = 1'b1;ld_score = 1'b1;end
			S_DIGIT_2: begin update_2 = 1'b1;ld_score = 1'b1;end
			//default:
				//is_black = 1'b0;
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals

    // current_state registers + frame counter -> / 15frames
    always@(posedge clk)
    begin: state_FFs
        if(!resetn) begin
			frameCounter <= 4'd0; // 15 - 1
			plot_current_state <= S_TITLE_PLOT;
		end
        else begin
			// loop for frameCounter, if clock_60_Hz is high
			if (slowerClk == 1) begin
				if (frameCounter == 4'd14) begin
					frameCounter <= 4'd0;
				end
				else begin
					frameCounter <= frameCounter + 1'b1;
				end
			end
			else begin
				if (frameCounter == 4'd0)
					frameCounter <= frameCounter + 1'b1;
			end
			plot_current_state <= plot_next_state;
		end
    end // state_FFS

endmodule

module datapath(
	input clk,
	input resetn,
	//input [2:0] colour_in,
	input ld_plot, ld_plot2, ld_plot3, is_black, is_update, is_update2, is_update3, 
	is_end, is_end2, is_end3, colour_black, colour_black2, colour_black3,update_1,update_2,updated_clear,ld_score,ld_title,
	input [8:0] color_q,left_color, right_color, middle_color, color_first,
	input [6:0] score,
	output reg [5:0] counter_1,counter_2,
	output reg [7:0] counter_clear,
	output reg [1:0] testAddress,
	output reg [7:0] x_out,
	output reg [6:0] y_out,
	output reg [4:0] counter,
	output reg [7:0] counter_black_x,
	output reg [6:0] counter_black_y,
	output reg [7:0] counter_title_x,
	output reg [6:0] counter_title_y,
	output reg [7:0] x_counter, // --> 160 /255
	output reg [6:0] y_counter, // --> 120 /127
	output reg [6:0] y_counter2,
	output reg [6:0] y_counter3,
	output [8:0] colour, 
	output reg [14:0] backAddress, titleAddress,
	output reg [3:0] leftAddress, middleAddress, rightAddress,
	output [3:0] first_digit,second_digit
    );

 localparam zero= 64'b0001100000100100010000100100001001000010010000100010010000011000,
			  one  = 64'b0001100000111000010110001001100000011000000110000001100011111111,
			  two  = 64'b0011110001111110011001101100011000001100000110000111000011111111,
			  three= 64'b0011110001100110010001100011110000000100000001100100011000111100,
			  four = 64'b0001100000111000011010001100100011111111000010000000100000001000,
			  five = 64'b0111111101000000010000000111110000000110000001100000011001111000,
			  six  = 64'b0011111101000000010000000101110011111110110001101100011001111000,
			  seven= 64'b1111111011111110000011000001100000110000011000001100000010000000, 
			  eight= 64'b0000000000011000001001000010010000011000001001000010010000011000,
			  nine = 64'b0001110000100100011001000011110000000100000001000100100000110000;

	//wire [3:0] first_digit,second_digit;
	reg [63:0] first_color, second_color;
	assign second_digit = score % 10;//(score[3:0] > 4'b1001)? 4'b0: score[3:0];
	assign first_digit = (score/10)%10;//({score[6:4],1'b0} + ((score[3:0] > 4'b1001) ? (score[3:0] - 4'b1001) : 1'b0));
	
	always@(*)
	begin
		if (first_digit == 4'b0) first_color = zero;
		else if (first_digit == 4'b1) first_color = one;
		else if (first_digit == 4'b10) first_color = two;
		else if (first_digit == 4'b11) first_color = three;
		else if (first_digit == 4'b100) first_color = four;
		else if (first_digit == 4'b101) first_color = five;
		else if (first_digit == 4'b110) first_color = six;
		else if (first_digit == 4'b111) first_color = seven;
		else if (first_digit == 4'b1000) first_color = eight;
		else if (first_digit == 4'b1001) first_color = nine;
		else first_color = zero;
		if (second_digit == 4'b0) second_color = zero;
		else if (second_digit == 4'b1) second_color = one;
		else if (second_digit == 4'b10) second_color = two;
		else if (second_digit == 4'b11) second_color = three;
		else if (second_digit == 4'b100) second_color = four;
		else if (second_digit == 4'b101) second_color = five;
		else if (second_digit == 4'b110) second_color = six;
		else if (second_digit == 4'b111) second_color = seven;
		else if (second_digit == 4'b1000) second_color = eight;
		else if (second_digit == 4'b1001) second_color = nine;
		else second_color = zero;
	end
 
    // Registers x,y with respective input logic
	//reg [5:0] datareg_x;
	//reg [5:0] datareg_y;
	reg [8:0] colour_reg;

	// input registers
	assign colour = colour_reg;

    always@(posedge clk) begin
        if(~resetn) begin
			//datareg_x <= 6'b0;
			//datareg_y <= 6'b0;
			x_out <= 8'd0;
			y_out <= 7'd0;
         counter <= 5'd0;
         counter_black_y <= 7'd0;
			counter_black_x <= 8'd0;
			counter_title_x <= 8'd0;
			counter_title_y <= 7'd0;
			x_counter <= 8'b1;
			y_counter <= 7'b1;
			y_counter2 <= 7'b1;
			y_counter3 <= 7'b1;
			leftAddress <= 4'b0;
			middleAddress <= 4'b0;
			rightAddress <= 4'b0;
			backAddress <= 15'b0;
			titleAddress <= 15'b0;
			counter_1 <= 6'b0;
			counter_2 <= 6'b0;
			counter_clear <= 8'b0;
			colour_reg <= 9'b0;
        end
		  else begin
			if(ld_plot) begin
				counter <= counter + 1'b1;
				x_out <= 6'd32 + counter[1:0];
				y_out <= y_counter + counter[3:2];
				leftAddress <= leftAddress + 1'b1;
				colour_reg <= left_color;
			end
			
			
			if(ld_plot2) begin
				counter <= counter + 1'b1;
				x_out <= 7'd78 + counter[1:0];
				y_out <= y_counter2 + counter[3:2];
				middleAddress <= middleAddress + 1'b1;
				colour_reg <= middle_color;
			end
			if(ld_plot3) begin
				counter <= counter + 1'b1;
				x_out <= 7'd124 + counter[1:0];
				y_out <= y_counter3 + counter[3:2];
				rightAddress <= rightAddress + 1'b1;
				colour_reg <= right_color;
			end
			if(ld_title) begin
				counter_title_x <= counter_title_x + 1'b1;
				x_out <= counter_title_x;
				y_out <= counter_title_y;
				if(counter_title_x == 8'd159)begin //reset when finish one row, and update y 
					counter_title_x <= 8'b00000000;
					counter_title_y <= counter_title_y + 1'b1;
				end
				if(counter_title_y == 7'd120)begin//reset when finish all row
					counter_title_y <= 7'b0000000;
					counter_title_x <= 8'b00000000;end
				titleAddress <= titleAddress + 1'b1;
				colour_reg <= color_first;				
			end
			if(colour_black) begin
				counter <= counter + 1'b1;
				x_out <= 6'd32 + counter[1:0];
				y_out <= y_counter + counter[3:2];
				colour_reg <= 9'b111111111;
			end
			if(colour_black2) begin
				counter <= counter + 1'b1;
				x_out <= 7'd78 + counter[1:0];
				y_out <= y_counter2 + counter[3:2];
				colour_reg <= 9'b111111111;
			end
			if(colour_black3) begin
				counter <= counter + 1'b1;
				x_out <= 7'd124 + counter[1:0];
				y_out <= y_counter3 + counter[3:2];
				colour_reg <= 9'b111111111;
			end
			if (is_black) begin	
				counter_black_x <= counter_black_x + 1'b1;
				x_out <= counter_black_x;
				y_out <= counter_black_y;
				if(counter_black_x == 8'd159)begin //reset when finish one row, and update y 
					counter_black_x <= 8'b00000000;
					counter_black_y <= counter_black_y + 1'b1;
				end
				if(counter_black_y == 7'd120)begin//reset when finish all row
					counter_black_y <= 7'b0000000;
					counter_black_x <= 8'b00000000;end
				backAddress <= backAddress + 1'b1;
				colour_reg <= color_q;				
			end
			if (is_update) begin
				if(y_counter == 7'd116) 
					y_counter <= 7'b0000000;
				else
					y_counter <= y_counter + 4'b1111;
			end
			if (is_update2) begin
				if(y_counter2 == 7'd116) 
					y_counter2 <= 7'b0000000;
				else
					y_counter2 <= y_counter2 + 4'b1111;
			end
			if (is_update3) begin
				if(y_counter3 == 7'd116) 
					y_counter3 <= 7'b0000000;
				else
					y_counter3 <= y_counter3 + 4'b1111;
			end
			
			if (is_end) begin
				counter <= 5'b0;
				leftAddress <= 4'b0;
				middleAddress <= 4'b0;
				rightAddress <= 4'b0;
				
			end
			if (is_end2) begin
				counter <= 5'b0;
				leftAddress <= 4'b0;
				middleAddress <= 4'b0;
				rightAddress <= 4'b0;
			end
			if (is_end3) begin
				counter <= 5'b0;
				leftAddress <= 4'b0;
				middleAddress <= 4'b0;
				rightAddress <= 4'b0;
			end
			if (updated_clear == 1'b1)begin
				x_out <= 8'd140 + counter_clear[4:0];
				y_out <= 7'd110 + counter_clear[7:5];
				counter_clear <= counter_clear + 1'b1;
				colour_reg <= 9'b111111111; end //clear with white color
			if (update_1 == 1'b1) begin
				x_out <= 8'd140 + counter_1[2:0];
				y_out <= 7'd110 + counter_1[5:3];
				counter_1 <= counter_1 + 1'b1;
				colour_reg <= (first_color[6'b111111 - counter_1])? 9'b000000000: 9'b111111111;end
			if (update_2 == 1'b1) begin
				x_out <= 8'd148 + counter_2[2:0];
				y_out <= 7'd110 + counter_2[5:3];
				counter_2 <= counter_2 + 1'b1;
				colour_reg <= (second_color[6'b111111 - counter_2])? 9'b000000000: 9'b111111111;end
        end
    
		  end
endmodule

module counter_60(clock, q, Q, pulse);
	input clock;
	input [19:0] q;
	output reg pulse;
	output reg [19:0] Q;

	always@(posedge clock)
	begin
		if (Q == 20'd0)
		begin
			Q <= q;
			
			pulse <= 1'b1;
		end
		else
		begin
			Q <= Q - 1'b1;
			pulse <= 1'b0;
		end
	end
endmodule

module mux (input [1:0] choice, clock_50, output reg [19:0] q);
	
	always @(*)
	begin
		case (choice)
			2'b00: q = 20'd833332;
			2'b01: q = 20'd416665;
			2'b10: q = 20'd208332;
			2'b11: q = 20'd104165;
			default: q = 20'b0;
		endcase			
	end
endmodule 