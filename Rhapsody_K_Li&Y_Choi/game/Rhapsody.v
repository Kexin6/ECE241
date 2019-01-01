// part3

module Rhapsody
	(
       ///////// ADC /////////
      inout              ADC_CS_N,
      output             ADC_DIN,
      input              ADC_DOUT,
      output             ADC_SCLK,
		
		input				AUD_ADCDAT,

		/*input and output of audio module*/
		// Bidirectionals
		inout				AUD_BCLK,
		inout				AUD_ADCLRCK,
		inout				AUD_DACLRCK,

		// Outputs
		output				AUD_XCK,
		output				AUD_DACDAT,

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
		
      ///////// HEX /////////
      output      [6:0]  HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,

      ///////// KEY /////////
      input       [3:0]  KEY,

      ///////// LEDR /////////
      output      [9:0]  LEDR,

      ///////// SW /////////
      input       [9:0]  SW,

      ///////// TD /////////
      input              TD_CLK27,
      input      [7:0]  TD_DATA,
      input             TD_HS,
      output             TD_RESET_N,
      input             TD_VS,
		// VGA 
		output			VGA_CLK,   				//	VGA Clock
		output			VGA_HS,					//	VGA H_SYNC
		output			VGA_VS,					//	VGA V_SYNC
		output			VGA_BLANK_N,				//	VGA BLANK
		output			VGA_SYNC_N,				//	VGA SYNC
		output	[7:0]	VGA_R,   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
		output	[7:0]	VGA_G,	 				//	VGA Green[7:0]
		output	[7:0]	VGA_B,     				//	VGA Blue[7:0]
		//PS2 keyboard
		inout PS2_CLK,
		inout PS2_DAT
);
	
	assign VGA_CLK = VGA_clk;
	assign VGA_HS = VGA_hs;
	assign VGA_VS = VGA_vs;
	assign VGA_BLANK_N = VGA_blank;
	assign VGA_SYNC_N = VGA_sync;
	assign VGA_R = VGA_r; assign VGA_B = VGA_b; assign VGA_G = VGA_g;
	wire point_hit1,point_hit2,point_3;
	wire [3:0] first_digit,second_digit;
	wire [10:0] X,Y;
	
	hexDecode hex0(updated_score[3:0], HEX0[6:0]);
	hexDecode hex1({1'b00,updated_score[6:4]},HEX1[6:0]);
	hexDecode hex2(second_digit,HEX2[6:0]);
	hexDecode hex3(first_digit,HEX3[6:0]);
	/*
	hexDecode hex0(Y[3:0],HEX0[6:0]);
	hexDecode hex1(Y[7:4],HEX1[6:0]);
	hexDecode hex2({1'b0,Y[10:8]},HEX2[6:0]);	
	hexDecode hex3(X[3:0],HEX3[6:0]);
	hexDecode hex4(X[7:4],HEX4[6:0]);
	hexDecode hex5({1'b0,X[10:8]},HEX5[6:0]);
	*/
	
	wire [7:0] vga_b,vga_r,vga_g;wire vga_blank,vga_clk,vga_hs,vga_vs,vga_sync;
	wire [7:0] vga_b_,vga_r_,vga_g_;wire vga_blank_,vga_hs_,vga_vs_,vga_sync_;
	wire[10:0] VGA_X,VGA_Y;
	camera camera_in(
      .ADC_CS_N(ADC_CS_N),
      .ADC_DIN(ADC_DIN),
      .ADC_DOUT(ADC_DOUT),
      .ADC_SCLK(ADC_SCLK),
      .CLOCK_50(CLOCK_50),
      .DRAM_ADDR(DRAM_ADDR),
      .DRAM_BA(DRAM_BA),
      .DRAM_CAS_N(DRAM_CAS_N),
      .DRAM_CKE(DRAM_CKE),
      .DRAM_CLK(DRAM_CLK),
      .DRAM_CS_N(DRAM_CS_N),
      .DRAM_DQ(DRAM_DQ),
      .DRAM_LDQM(DRAM_LDQM),
      .DRAM_RAS_N(DRAM_RAS_N),
      .DRAM_UDQM(DRAM_UDQM),
      .DRAM_WE_N(DRAM_WE_N),
      //.FPGA_I2C_SCLK(FPGA_I2C_SCLK),
      //.FPGA_I2C_SDAT(FPGA_I2C_SDAT),
		.resetn(resetn),
      .TD_CLK27(TD_CLK27),
      .TD_DATA(TD_DATA),
      .TD_HS(TD_HS),
      .TD_RESET_N(TD_RESET_N),
      .TD_VS(TD_VS),
		.td_reset(KEY[3]),
		.VGA_B(vga_b),
      .VGA_BLANK_N(vga_blank),
      .VGA_CLK(vga_clk),
      .VGA_G(vga_g),
      .VGA_HS(vga_hs),
      .VGA_R(vga_r),
      .VGA_SYNC_N(vga_sync),
      .VGA_VS(vga_vs),
		.debug(LEDR[9:0]),
		.coordinate_x(X),
		.coordinate_y(Y),
		.position(position),
		.VGA_X(VGA_X),
		.VGA_Y(VGA_Y)
	);
	vga_adapter VGA_camera(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour({vga_r,vga_g,vga_b}),
			.x(VGA_X),
			//.x({1'b0,x}),
			.y(VGA_Y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(vga_r_),
			.VGA_G(vga_g_),
			.VGA_B(vga_b_),
			.VGA_HS(vga_hs_),
			.VGA_VS(vga_vs_),
			.VGA_BLANK(vga_blank_),
			.VGA_SYNC(vga_sync_),
			.VGA_CLK(vga_clk_));
		defparam VGA.RESOLUTION = "640x480";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 8;
		defparam VGA.BACKGROUND_IMAGE = "title.mif";
	//assign LEDR[2:0] = position;
	//assign LEDR[9:3] = TD_DATA;
	//score module
	wire  [6:0] updated_score;wire win;
	score score_update(
	.clk(CLOCK_50),
	.resetn(resetn),
	.expected_position({point_hit1,point_hit2,point_hit3}),
	.real_position(position),
	.updated_score(updated_score),
	.win(win)
	); 
	/*inout for vga display module */
	
	// Declare your inputs and outputs here

	wire [2:0] position;
	
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
	
	mux_speed choose(
				//.choice(SW[1:0]), 
				.choice(song_select[1:0]), 
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
				.second_digit(second_digit),
				.point_hit1(point_hit1),
				.point_hit2(point_hit2),
				.point_hit3(point_hit3)
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
				.SW(song_select[1:0]),
				//.LEDR(LEDR),
				.KEY(KEY)
			);
			keyboard PS2_key(
			// Inputs
			.CLOCK_50(CLOCK_50),
			.resetn(resetn),

			// Bidirectionals
			.PS2_CLK(PS2_CLK),
			.PS2_DAT(PS2_DAT),
			
			// Outputs
			.HEX4(HEX4[6:0]),
			.HEX5(HEX5[6:0]),
			.value(song_select[1:0])
		);
	wire [1:0] song_select;				
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	
	assign writeEn = (ld_title || is_black || WE1 || WE2 || WE3 || WE4) ? 1'b1 : 1'b0;
	//assign writeEn = WE1;
	wire [7:0] VGA_r,VGA_b,VGA_g; wire VGA_clk,VGA_sync,VGA_hs,VGA_vs,VGA_blank;
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			//.x({1'b0,x}),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_r),
			.VGA_G(VGA_g),
			.VGA_B(VGA_b),
			.VGA_HS(VGA_hs),
			.VGA_VS(VGA_vs),
			.VGA_BLANK(VGA_blank),
			.VGA_SYNC(VGA_sync),
			.VGA_CLK(VGA_clk));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 3;
		defparam VGA.BACKGROUND_IMAGE = "title.mif";

endmodule
