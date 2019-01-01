module check_position (
input clk, 
input resetn, 
input [10:0] vga_x,
input [10:0] vga_y,
input [7:0] color, 
input [15:0] white,
output reg [10:0] x_cor,
output reg [10:0] y_cor,
output reg [2:0] position);

//reg [8:0] red_counter_1,red_counter_2,red_counter_3;
//output the x coordinate for first pixel that is over the red thersold
//change to having low value of blue and green

//fsm to reset position light before every check to prevent sticky led light

/*
localparam  
			
				S_BEFORE_CHECK 	= 2'd00,//just before checking
				S_CHECK				= 2'b01,
				S_N_CHECK         = 2'b10;

reg [1:0] current_state, next_state;
//state control logic
always@(*)
    begin: plot_state_table
            case (current_state)
				S_BEFORE_CHECK: begin
					next_state = S_CHECK;
				end
				S_CHECK: begin
					next_state = (vga_y >= 11'd200 && vga_y <11'd218) ? S_CHECK : S_N_CHECK; 
				end
				S_N_CHECK: begin
					next_state = (vga_y >= 11'd182 && vga_y <11'd200 && !(vga_y >= 11'd200 && vga_y <11'd218)) ? S_BEFORE_CHECK : S_N_CHECK;
				end
				default: next_state = S_BEFORE_CHECK;
				endcase
	end

reg reset, check, hold;

always @(*)
    begin: enable_signals
		reset = 1'b0;
		check = 1'b0;
		hold = 1'b0;
		case (current_state)
			S_BEFORE_CHECK: begin
				reset = 1'b1;
			end
			S_CHECK: begin
				check = 1'b1;
			end
			S_N_CHECK: begin
				hold = 1'b1;
			end
		endcase
	end

   always@(posedge clk)
    begin: state_FFs
        if(!resetn) begin
			current_state <= S_BEFORE_CHECK;
			end
		  else begin
			current_state <= next_state;end
    end // state_FFS


always @ (posedge clk)
begin

 if (!resetn) begin
 x_cor <= 11'b0;
 y_cor <= 11'b0;
 position <= 3'b0;
 end
 else if (reset) begin
 x_cor <= 11'b0;
 y_cor <= 11'b0;
 position <= 3'b0;end
 else if (check) begin  // look at 18 rows
		if (color >= 8'b11111100 && white[7:0] < 8'b11001000 && white[15:8] < 8'b11001000 ) begin
			x_cor <= vga_x;
			y_cor <= vga_y;
			 if (vga_x >= 11'd0 && vga_x < 11'd200) begin
				position <= 3'b100;end
			 else if (vga_x >= 11'd200 && vga_x < 11'd400) begin
				position <= 3'b010;end
			 else if (vga_x >= 11'd400 && vga_x < 11'd640) begin
				position <= 3'b001;end
			else begin
				 position <= position;end
		end
		else begin
			position <= position;end
		
 end
 else if (hold)begin // not checking 
		x_cor <= x_cor;
		y_cor <= y_cor;
		position <= position;
 end
 else begin
		position <= position;
		x_cor <= x_cor;
		y_cor <= y_cor;
	end
end
*/
	 
	
	
always @ (posedge clk)
begin

 if (!resetn) begin
 x_cor <= 11'b0;
 y_cor <= 11'b0;
 //red_counter_1 <= 9'b0;
 //red_counter_2 <= 9'b0;
 //red_counter_3 <= 9'b0;
 end
 else if (vga_y >= 11'd200 && vga_y <11'd218) begin  // look at 18 rows
		if (color >= 8'b11111100 && white[7:0] < 8'b11001000 && white[15:8] < 8'b11001000 ) begin
			x_cor <= vga_x;
			y_cor <= vga_y;
			 if (vga_x >= 11'd0 && vga_x < 11'd200) begin
				//red_counter_1 <= red_counter_1 + 1'b1;
				position <= 3'b100;end
			 else if (vga_x >= 11'd200 && vga_x < 11'd400) begin
				//red_counter_2 <= red_counter_2 + 1'b1;
				position <= 3'b010;end
			 else if (vga_x >= 11'd400 && vga_x < 11'd640) begin
				//red_counter_3 <= red_counter_3 + 1'b1;
				position <= 3'b001;end
			 else begin
				 position <= position;end
				 //red_counter_1 <= red_counter_1;
				 //red_counter_2 <= red_counter_2;
				 //red_counter_3 <= red_counter_3;end
		end
		
 end
 else if (!(vga_y >= 11'd200 && vga_y <11'd218))begin // not checking 
		//red_counter_1 <= 9'b0;
		//red_counter_2 <= 9'b0;
		//red_counter_3 <= 9'b0;
		position <= position;
 end
 else begin
		position <= position;
		x_cor <= x_cor;
		y_cor <= y_cor;end
		//red_counter_1 <= red_counter_1;
		//red_counter_2 <= red_counter_2;
		//red_counter_3 <= red_counter_3;end
end



// if half of the bit are red, light up
/*
always@(*) begin
	if (!resetn) begin position <= 3'b0;end
	if (red_counter_1 >= 8'd100) begin 
		position[2] <= 1'b1;
		position[1:0] <= position[2:0];end
	else begin 
		position[2] <= 1'b0;
		position[1:0] <= position[2:0];end
	if (red_counter_2 >= 8'd100) begin 
		position[1] <= 1'b1;
		position[2] <= position[2];
		position[0] <= position[0];end
	else begin
		position[1] <= 1'b0;
		position[2] <= position[2];
		position[0] <= position[0];end
	if (red_counter_3 >= 8'd100) begin 
		position[0] <= 1'b1;
		position[2:1] <= position[2:1];end
	else begin
		position[0] <= 1'b0;
		position[2:1] <= position[2:1];end
end
*/
endmodule
