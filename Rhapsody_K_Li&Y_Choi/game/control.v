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
				S_WAIT: begin plot_next_state = S_SCORE_CLEAR;end
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
	output [3:0] first_digit,second_digit,
	output reg point_hit1, point_hit2, point_hit3
    );

 localparam zero= 64'b0001100000100100010000100100001001000010010000100010010000011000,
			  one  = 64'b0001100000111000010110001001100000011000000110000001100011111111,
			  two  = 64'b0011110001111110011001101100011000001100000110000111000011111111,
			  three= 64'b0011110001100110010001100011110000000100000001100100011000111100,
			  four = 64'b0001100000111000011010001100100011111111000010000000100000001000,
			  five = 64'b0111111101000000010000000111110000000110000001100000011001111000,
			  six  = 64'b0011111101000000010000000101110011111110110001101100011001111000,
			  seven= 64'b1111111011111110000011000001100000110000011000001100000010000000, 
			  eight= 64'b0111111010000001100000010111111010000001100000011000000101111110,
			  nine = 64'b0001110000100100011001000011110000000100000001000100100000110000;

	//wire [3:0] first_digit,second_digit;
	reg [63:0] first_color, second_color;
	assign second_digit = score % 10;//(score[3:0] > 4'b1001)? 4'b0: score[3:0];
	assign first_digit = (score/10) % 10;//({1'b0,score[6:4]} + ((score[3:0] > 4'b1001) ? (score[3:0] - 4'b1001) : 1'b0));
	
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
					if(y_out <= 7'd108 && y_out >= 7'd90) begin
						point_hit1 <= 1'b1;
					end
					else begin
						point_hit1 <= 1'b0;
					end
					
			end
			
			
			if(ld_plot2) begin
				counter <= counter + 1'b1;
				x_out <= 7'd78 + counter[1:0];
				y_out <= y_counter2 + counter[3:2];
				middleAddress <= middleAddress + 1'b1;
				colour_reg <= middle_color;
					if(y_out <= 7'd108 && y_out >= 7'd90) begin
						point_hit2 <= 1'b1;
					end
					else begin
						point_hit2<= 1'b0;
					end
			end
			if(ld_plot3) begin
				counter <= counter + 1'b1;
				x_out <= 7'd124 + counter[1:0];
				y_out <= y_counter3 + counter[3:2];
				rightAddress <= rightAddress + 1'b1;
				colour_reg <= right_color;
					if(y_out <= 7'd108 && y_out >= 7'd90) begin
						point_hit3 <= 1'b1;
					end
					else begin
						point_hit3 <= 1'b0;
					end
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
					y_counter <= y_counter + 3'b111;
			end
			if (is_update2) begin
				if(y_counter2 == 7'd116) 
					y_counter2 <= 7'b0000000;
				else
					y_counter2 <= y_counter2 + 3'b111;
			end
			if (is_update3) begin
				if(y_counter3 == 7'd116) 
					y_counter3 <= 7'b0000000;
				else
					y_counter3 <= y_counter3 + 3'b111;
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
			if (update_1 == 1'b1) begin // draw first digit
				x_out <= 8'd140 + counter_1[2:0];
				y_out <= 7'd110 + counter_1[5:3];
				counter_1 <= counter_1 + 1'b1;
				colour_reg <= (first_color[6'b111111 - counter_1])? 9'b000000000: 9'b111111111;end
			if (update_2 == 1'b1) begin //draw second digit
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

module mux_speed (input [1:0] choice, clock_50, output reg [19:0] q);
	
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