//compared expected position and real position and update score

module score (
	input clk, 
	input resetn,
	input [2:0] expected_position,
	input [2:0] real_position,
	output[6:0] updated_score,
	output score_updated,
	output reg win);

	assign score_updated = 1'b1;
	
	reg [6:0] score; reg update;
	assign updated_score[6:0] = score[6:0];
//	assign score_updated = update;
	always@(posedge clk)
	begin	
		if (!resetn) begin
		score <= 7'b0;	
		update <= 1'b1;
		win <= 1'b0;end
		else begin
			if (expected_position[0] == real_position[0] && expected_position[0] == 1'b1)begin
				score <= score + 1'b1;	
				update <= 1'b1;
				win <= 1'b0;end
			else begin
				score <= score;
				update <= 1'b0;
				win <= 1'b0;end
			if (expected_position[1] == real_position[1]  && expected_position[1] == 1'b1)begin
				score <= score + 1'b1;	
				update <= 1'b1;
				win <= 1'b0;end
			else begin
				score <= score;
				update <= 1'b0;
				win <= 1'b0;end
			if (expected_position[2] == real_position[2] && expected_position[2] == 1'b1)begin
				score <= score + 1'b1;	
				update <= 1'b1;
				win <= 1'b0;end
			else begin
				score <= score;
				update <= 1'b0;
				win <= 1'b0;end
		end
		
		if (score == 7'b1100011)begin //score = decimal 99
			score <= score;
			update <= 1'b0;
			win <= 1'b1;end
	end
	
endmodule
