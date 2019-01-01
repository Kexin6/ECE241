module music (
	// Inputs
	CLOCK_50,
	KEY,

	AUD_ADCDAT,

	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	FPGA_I2C_SDAT,

	// Outputs
	AUD_XCK,
	AUD_DACDAT,

	FPGA_I2C_SCLK,
	SW,
	LEDR
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input				CLOCK_50;
input		[3:0]	KEY;
input		[9:0]	SW;

input				AUD_ADCDAT;

// Bidirectionals
inout				AUD_BCLK;
inout				AUD_ADCLRCK;
inout				AUD_DACLRCK;

inout				FPGA_I2C_SDAT;

// Outputs
output				AUD_XCK;
output				AUD_DACDAT;
output [9:0]		LEDR;

output				FPGA_I2C_SCLK;

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires
wire				audio_in_available;
wire		[31:0]	left_channel_audio_in;
wire		[31:0]	right_channel_audio_in;
wire				read_audio_in;

wire				audio_out_allowed;
wire		[31:0]	left_channel_audio_out;
wire		[31:0]	right_channel_audio_out;
wire				write_audio_out;

// Internal Registers

reg [13:0] count, count1, count2, count3; // 0 -> 9999
reg [16:0] address00, address01, address11; // 0 -> 59999
reg [16:0] address10;

reg snd;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

always @(posedge CLOCK_50)
begin
	if(count == 14'd8333) begin
		count <= 14'd0;
		if(address00 == 17'd89999)
			address00 <= 17'd0;
		else
			address00 <= address00 + 17'd1;
	end 
	if(count1 == 14'd8333) begin
		count1 <= 14'd0;
		if(address01 == 17'd89999)
			address01 <= 17'd0;
		else
			address01 <= address01 + 17'd1;
	end 
	if(count2 == 14'd8333) begin
		count2 <= 14'd0;
		if(address10 == 17'd89999)
			address10 <= 17'd0;
		else
			address10 <= address10 + 17'd1;
	end 
	
	if(count3 == 14'd8333) begin
		count3 <= 14'd0;
		if(address11 == 17'd89999)
			address11 <= 17'd0;
		else
			address11 <= address11 + 17'd1;
	end 
	else begin
		count <= count + 1;
		count1 <= count1 + 1;
		count2 <= count2 + 1;
		count3 <= count3 + 1;
	end
end
/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/
assign LEDR[9:0] = address01[14:5];
wire [5:0] w00, w01, w10, w11;
//00 
 waveData00 w0(
	.address(address00),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(w00));
	
//01 
waveData01 w1(
	.address(address01),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(w01));
	
//10
waveData10 w2(
	.address(address10),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(w10));
	
//11
waveData11 w3(
	.address(address11),
	.clock(CLOCK_50),
	.data(),
	.wren(1'b0),
	.q(w11));
	
reg[5:0] soundout;
	
always @(*)
	begin
		case (SW[1:0])
			2'b00: soundout = w00;
			2'b01: soundout = w01;
			2'b10: soundout = w10;
			2'b11: soundout = w11;
			default: soundout = w00;
		endcase			
	end


wire [31:0] sound = {soundout, {23'b0}};

assign read_audio_in			= audio_in_available & audio_out_allowed;

assign left_channel_audio_out	= left_channel_audio_in+sound;
assign right_channel_audio_out	= right_channel_audio_in+sound;
assign write_audio_out			= audio_in_available & audio_out_allowed;

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

Audio_Controller Audio_Controller (
	// Inputs
	.CLOCK_50						(CLOCK_50),
	.reset						(~KEY[2]),

	.clear_audio_in_memory		(),
	.read_audio_in				(read_audio_in),

	.clear_audio_out_memory		(),
	.left_channel_audio_out		(left_channel_audio_out),
	.right_channel_audio_out	(right_channel_audio_out),
	.write_audio_out			(write_audio_out),

	.AUD_ADCDAT					(AUD_ADCDAT),

	// Bidirectionals
	.AUD_BCLK					(AUD_BCLK),
	.AUD_ADCLRCK				(AUD_ADCLRCK),
	.AUD_DACLRCK				(AUD_DACLRCK),


	// Outputs
	.audio_in_available			(audio_in_available),
	.left_channel_audio_in		(left_channel_audio_in),
	.right_channel_audio_in		(right_channel_audio_in),

	.audio_out_allowed			(audio_out_allowed),

	.AUD_XCK					(AUD_XCK),
	.AUD_DACDAT					(AUD_DACDAT)

);

avconf_audio #(.USE_MIC_INPUT(1)) avc (
	.FPGA_I2C_SCLK					(FPGA_I2C_SCLK),
	.FPGA_I2C_SDAT					(FPGA_I2C_SDAT),
	.CLOCK_50					(CLOCK_50),
	.reset						(~KEY[2])
);

endmodule
