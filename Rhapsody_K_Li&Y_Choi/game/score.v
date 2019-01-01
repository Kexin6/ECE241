//compared expected position and real position and update score

module score (
	input clk, 
	input resetn,
	input [2:0] expected_position,
	input [2:0] real_position,
	output[6:0] updated_score,
	output win
	);
	
	reg [6:0] score;
	assign updated_score[6:0] = score[6:0];
	
//fsm for preventing mutiple count up for one position
reg [2:0] current_state, next_state;
localparam  
			
				S_WAIT 				= 3'd000,//just before checking
				S_POINT1				= 3'b001,
				S_POINT1_WAIT     = 3'b010,
				S_POINT2				= 3'b011,
				S_POINT2_WAIT 		= 3'b100,
				S_POINT3				= 3'b101;
	
	always@(*)
    begin: plot_state_table
            case (current_state)
				S_WAIT: begin
					next_state = expected_position[2] == 1'b1 ? S_POINT1 : S_WAIT;
				end
				S_POINT1: begin
					next_state =  S_POINT1_WAIT; 
				end
				S_POINT1_WAIT: begin
					next_state = expected_position[1] == 1'b1 ? S_POINT2 : S_POINT1_WAIT;
				end
				S_POINT2: begin
					next_state =  S_POINT2_WAIT; 
				end
				S_POINT2_WAIT: begin
					next_state = expected_position[0] == 1'b1 ? S_POINT3 : S_POINT2_WAIT;
				end
				S_POINT3: begin
					next_state =  S_WAIT; 
				end
				default: next_state = S_WAIT;
				endcase
	end
	
reg add, hold;

always @(*)
    begin: enable_signals
		add = 1'b0;
		hold = 1'b0;
		case (current_state)
			S_WAIT: begin
				hold = 1'b1;
			end
			S_POINT1: begin
				add = 1'b1;
			end
			S_POINT1_WAIT: begin
				hold = 1'b1;
			end
			S_POINT2: begin
				add = 1'b1;
			end
			S_POINT2_WAIT: begin
				hold = 1'b1;
			end
			S_POINT3: begin
				add = 1'b1;
			end
		endcase
	end

   always@(posedge clk)
    begin: state_FFs
        if(!resetn) begin
			current_state <= S_WAIT;
			end
		  else begin
			current_state <= next_state;end
    end // state_FFS

always @ (posedge clk)
begin

 if (!resetn) begin
	score <= 7'b0;
 end
 else if (score == 7'b1100011) begin
	score <= score;
 end
 else if (hold) begin
	score <= score;
 end
 else if (add) begin  // look at 18 rows
	if (expected_position == real_position && expected_position != 3'b000) begin
		score <= score + 1'b1;end
	else begin
		score <= score; end
 end
 else begin
	score <= score;
 end
end

assign win = (score == 7'b1100011);
	
/*	
	//internal wire
	reg [2:0] last_position;
	
	always@(posedge clk)
	begin	
		if (!resetn) begin
			score <= 7'b0;
			last_position <= 3'b0;
		end
		
		else if (score == 7'b1100011)begin //score = decimal 99
			score <= score;
			last_position <= 3'b0;
		end
		else if (expected_position == real_position && expected_position != 3'b000 && expected_position != last_position)begin
			score <= score + 1'b1;
			last_position <= expected_position;
		end
		else begin
			last_position <= last_position;
			score <= score;
		end 
	end
*/	
endmodule
