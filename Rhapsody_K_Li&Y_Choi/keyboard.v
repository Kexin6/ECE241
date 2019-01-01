////////////////////////////
/// keyboard interface to DE2
/// Feb 13 2015
/// ps2 interface
/// proto type
///////////////////////////

module keyboard (
 hex4_out, 		// 7 bit binary Output
 hex5_out, 		// 7 bit binary Output
 clk		, 		// input 50 MHz clk
 ps_clk 	, 		// ps2 clock
 ps_data	 		// ps2 data
);			


 input clk;
 input ps_data;
 input ps_clk;
 
 output reg [6:0] hex4_out ;
 output reg [6:0] hex5_out ;

 //internal registers
  
 reg [13:0] hex_out ;
 reg [7:0] counter;
 reg [10:0] data;
 reg valid;
 reg cnt;
 reg cnt2;

 /////////////////////////////////////////////////////////////////////////
 // characters and symbols created for displaying values on Hex display //
 // some require two HEX displays others don't                          // 
 // Note not all key codes from keyboard are here. Some are missing     //
 // from this list,you may create them by adding them                   //
 /////////////////////////////////////////////////////////////////////////
 
 parameter HEX_1 = 14'b11111111111001;		// one
 parameter HEX_2 = 14'b11111110100100;		// two
 parameter HEX_3 = 14'b11111110110000;		// three
 parameter HEX_4 = 14'b11111110011001;		// four
 

///////////////////////////////////////
/////// counters enables       ////////
///////////////////////////////////////	

wire cnt1 = (counter >= 8'd11 )? 1'b1 : 1'b0;

/////////////////////////////
/// clock for PS2      //////
/////////////////////////////	

	 always @ (negedge ps_clk or posedge cnt1 )
	 
	 begin 
	 
		if (cnt1)
		begin
			counter <= 0;
			cnt <= 1;
		end
		
			else
			
		begin
			
			counter <= counter + 1;
			cnt <= 0;
			
		end	
	end
	
	
/////////////////////////////////////////////////////////////////////
/// Serial shift register to reteive data from the PS_data line   ///
/////////////////////////////////////////////////////////////////////

	
always @ (negedge ps_clk or  posedge cnt )

 begin
 
 if (cnt) begin  valid <= 1; end
 
 else
 
 case (counter)
 	
		8'd0	: begin valid = 1; data[0] = ps_data; end // start
		8'd1	: begin valid = 0; data[1] = ps_data; end // bit 0
		8'd2	: begin valid = 0; data[2] = ps_data; end // bit 1
		8'd3	: begin valid = 0; data[3] = ps_data; end // bit 2 	
		8'd4	: begin valid = 0; data[4] = ps_data; end // bit 3
		
		8'd5	: begin valid = 0; data[5] = ps_data; end // bit 4
		8'd6	: begin valid = 0; data[6] = ps_data; end // bit 5		
		8'd7	: begin valid = 0; data[7] = ps_data; end // bit 6
		8'd8	: begin valid = 0; data[8] = ps_data; end // bit 7
		
		8'd9	: begin valid = 1; data[9] = ps_data; end // parity
		8'd10 : begin valid = 1; data[10] = ps_data; end // stop
		8'd11	: begin valid = 1; end 
		8'd12	: begin valid = 1; end

	endcase
end
	
 
///////////////////////////////////////////////////////////////////////////
/// compare and select key code value to be displayed on HEX displays   ///
///////////////////////////////////////////////////////////////////////////

 always @(posedge clk )	
 
	begin
	
		
		hex_out = 14'b11111111111111;   // default setting
	
		
		if (data[8:1] == 8'b00010110) begin	
		 hex_out <= HEX_1; 
		 end
		 
		 else
		 
		 if (data[8:1] == 8'b00011110) begin  
		 hex_out <= HEX_2; 
		 end
		 
		 else
		 
		 if (data[8:1] == 8'b00100110) begin 
		 hex_out <= HEX_3; 
		 end 
		 
		 else 
		 
		 if (data[8:1] == 8'b00100101) begin
		  hex_out <= HEX_4; 
		 end
		
	end

////////////////////////////////////
// values for HEX display       ////
////////////////////////////////////

always hex4_out <= hex_out[6:0];
always hex5_out <= hex_out[13:7];

endmodule
