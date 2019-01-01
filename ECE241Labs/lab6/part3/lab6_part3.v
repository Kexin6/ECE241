module lab6_part3(SW, KEY, CLOCK_50, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input [9:0] SW;
    input [3:0] KEY;
    input CLOCK_50;
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output [9:0] LEDR;
	 
    wire reset;
    wire go;
	 wire [4:0] remainder;
	 wire [4:0] divisor;

	 assign divisor[3:0] = SW[3:0];
	 assign divisor[4] = 1'b0;
    assign go = ~KEY[1];
    assign reset = KEY[0];

    part3 U0(
        .clk(CLOCK_50),
        .reset(reset),
        .go(go),
        .dividend(SW[7:4]),
		  .divisor(divisor),
		  .quotient(LEDR[3:0]),
		  .remainder(remainder)
    );
      

    hex_decoder H0(
        .hex_digit(divisor[3:0]), 
        .segments(HEX0)
        );
	 
	 hex_decoder H1(
        .hex_digit(4'b0000), 
        .segments(HEX1)
        );
        
    hex_decoder H2(
        .hex_digit(SW[7:4]), 
        .segments(HEX2)
        );

	 hex_decoder H3(
        .hex_digit(4'b0000), 
        .segments(HEX3)
        );  
	 
	 hex_decoder H4(
        .hex_digit(LEDR[3:0]), 
        .segments(HEX4)
        );
		  
	 hex_decoder H5(
        .hex_digit(remainder[3:0]), 
        .segments(HEX5)
        );

endmodule

module part3(
    input clk,
    input reset,
    input go,
    input [3:0] dividend,
	 input [4:0] divisor,
    output [3:0] quotient,
	 output [4:0] remainder
    );

    // lots of wires to connect our datapath and control
    wire ld_a, ld_d, ld_r;
    wire ld_alu_out;
    wire alu_op;
	 wire a4;
	 wire q0;
	 wire left_shift;
	 wire alu_enable;

    control C0(
        .clk(clk),
        .reset(reset),
        .go(go),
		  .a4(a4),
		  .alu_enable(alu_enable),
        
        .ld_alu_out(ld_alu_out), 
        .ld_a(ld_a),
        .ld_d(ld_d),
        .ld_r(ld_r), 
        
		  .left_shift(left_shift),
		  .q0(q0),
        .alu_op(alu_op)
    );

    datapath D0(
        .clk(clk),
        .reset(reset),

        .ld_alu_out(ld_alu_out), 
		  .alu_enable(alu_enable),
        .ld_a(ld_a),
        .ld_d(ld_d),
        .ld_r(ld_r), 
		  
		  .left_shift(left_shift),
		  .q0(q0),
        .alu_op(alu_op),

        .dividend(dividend),
        .divisor(divisor),
		  .quotient(quotient),
		  .remainder(remainder),
		  .a4(a4)
    );
                
 endmodule        

module datapath(
    input clk,
    input reset,
    input ld_alu_out,
	 input ld_a, ld_d, ld_r,
	 input left_shift,
	 input q0,
    input alu_op,
	 input alu_enable,
	 input [3:0] dividend,
	 input [4:0] divisor,
    output reg [3:0] quotient,
	 output reg [4:0] remainder,
	 output a4
    );
    
    // input registers
    reg [4:0] a;
	 reg [3:0] d;

    // output of the alu
    reg [4:0] alu_out;
    assign a4 = a[4];
    // Registers a, d with respective input logic
    always@(posedge clk) begin
        if(reset) begin
            a <= 5'b00000; 
            d <= 4'b0000;  
        end
        else begin
            if(ld_a)
					a <= ld_alu_out ? alu_out : divisor; // load alu_out if load_alu_out signal is high, otherwise load from divisor
            if(ld_d)
                d <= dividend; // load alu_out if load_alu_out signal is high
					 if(left_shift) 
					 begin
						a <= (a << 1'b1);
						a[0] <= d[3];
						d <= (d << 1'b1);
					 end
					 
					 if(q0)
					 begin
						d[0] <= a4 ? 1'b0 : 1'b1;
					 end
        end
    end
	
    // Output result register
    always@(posedge clk) begin
        if(reset) begin
            quotient <= 4'b0000;
				remainder <= 5'b00000;
        end
        else 
            if(ld_r)
				begin
                quotient <= d;
					 remainder <= a;
				end
    end

    // The ALU 
    always @(*)
    begin : ALU
        // alu
        case (alu_op)
            0: begin
					if(alu_enable)
						begin
							alu_out = a + divisor; //performs addition
						 end
               end
            1: begin
					if(alu_enable)
						begin
                   alu_out = a - divisor; //performs subtractor
						end
               end
            default: alu_out = 5'b00000;
        endcase
    end
	  
endmodule



module control(
    input clk,
    input reset,
    input go,
	 input a4,

    output reg ld_alu_out,
	 output reg alu_enable,
	 output reg ld_a, ld_d, ld_r,
	 output reg left_shift,
	 output reg q0,
    output reg alu_op
    );

    reg [5:0] current_state, next_state; 
    
    localparam  S_LOAD          = 5'd0,
                S_LOAD_WAIT     = 5'd1,
                S_LEFT_0        = 5'd2,
                S_DIVISOR_0     = 5'd3,
                WAIT_0          = 5'd4,
                ADD_0           = 5'd5,
                S_LEFT_1        = 5'd6,
                S_DIVISOR_1     = 5'd7,
                WAIT_1          = 5'd8,
                ADD_1           = 5'd9,
                S_LEFT_2        = 5'd10,
					 S_DIVISOR_2     = 5'd11,
					 WAIT_2          = 5'd12,
					 ADD_2           = 5'd13,
					 S_LEFT_3        = 5'd14,
					 S_DIVISOR_3     = 5'd15,
					 WAIT_3          = 5'd16,
					 ADD_3           = 5'd17,
					 OUT             = 5'd18;
    
    // Next state logic aka our state table
    always@(*)
    begin: state_table //need to change the logic of the state_table
            case (current_state)
                S_LOAD: next_state = go ? S_LOAD_WAIT : S_LOAD; 
                S_LOAD_WAIT: next_state = go ? S_LOAD_WAIT : S_LEFT_0; 
                S_LEFT_0: next_state = S_DIVISOR_0; 
                S_DIVISOR_0: next_state = WAIT_0; 
                WAIT_0: next_state = ADD_0; 
                ADD_0: next_state = S_LEFT_1;  
                S_LEFT_1: next_state = S_DIVISOR_1; 
                S_DIVISOR_1: next_state = WAIT_1; 
                WAIT_1: next_state = ADD_1;
					 ADD_1: next_state = S_LEFT_2;
					 S_LEFT_2: next_state = S_DIVISOR_2;
					 S_DIVISOR_2: next_state = WAIT_2;
                WAIT_2: next_state = ADD_2; 
					 ADD_2: next_state = S_LEFT_3;
					 S_LEFT_3: next_state = S_DIVISOR_3;
					 S_DIVISOR_3: next_state = WAIT_3;
					 WAIT_3: next_state = ADD_3;
					 ADD_3: next_state = OUT;
					 OUT: next_state = S_LOAD;
            default:     next_state = S_LOAD;
        endcase
    end // state_table
   

    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0 to avoid latches.
        // This is a different style from using a default statement.
        // It makes the code easier to read.  If you add other out
        // signals be sure to assign a default value for them here.
        ld_alu_out = 1'b0;
        ld_a = 1'b0;
        ld_d = 1'b0;
        ld_r = 1'b0;
		  alu_op = 1'b0;
		  left_shift = 1'b0;
		  q0 = 1'b0;
		  alu_enable = 1'b0;

        case (current_state)
				S_LOAD: begin
					ld_d = 1'b1;
				end
            S_LEFT_0: begin
					left_shift = 1'b1;
				end
				S_DIVISOR_0: begin 
					ld_a = 1'b1;
               alu_op = 1'b1; // Do subtraction operation
					ld_alu_out = 1'b1;
					alu_enable = 1'b1;
            end
				ADD_0: begin
					if(a4) begin
						ld_a = 1'b1;
						alu_op = 1'b0; // Do addition operation
						ld_alu_out = 1'b1;
						alu_enable = 1'b1;
					end
					else 
						q0 = 1'b1;
            end
				S_LEFT_1: begin
					left_shift = 1'b1;
				end
				S_DIVISOR_1: begin 
					ld_a = 1'b1;
               alu_op = 1'b1; // Do subtraction operation
					ld_alu_out = 1'b1;
					alu_enable = 1'b1;
            end
				ADD_1: begin
					if(a4) begin
						ld_a = 1'b1;
						alu_op = 1'b0; // Do addition operation
						ld_alu_out = 1'b1;
						alu_enable = 1'b1;
					end
					else 
						q0 = 1'b1;
            end
				S_LEFT_2: begin
					left_shift = 1'b1;
				end
            S_DIVISOR_2: begin 
					ld_a = 1'b1;
               alu_op = 1'b1; // Do subtraction operation
					ld_alu_out = 1'b1;
					alu_enable = 1'b1;
            end
				ADD_2: begin
               if(a4) begin
						ld_a = 1'b1;
						alu_op = 1'b0; // Do addition operation
						ld_alu_out = 1'b1;
						alu_enable = 1'b1;
					end
					else 
						q0 = 1'b1;
            end
				S_LEFT_3: begin
					left_shift = 1'b1;
				end
				S_DIVISOR_3: begin 
               ld_a = 1'b1;
					alu_op = 1'b1; // Do subtraction operation
					ld_alu_out = 1'b1;
					alu_enable = 1'b1;
            end
				ADD_3: begin
               if(a4) begin
						ld_a = 1'b1;
						alu_op = 1'b0; // Do addition operation
						ld_alu_out = 1'b1;
						alu_enable = 1'b1;
					end
					else 
						q0 = 1'b1;
            end
				OUT: begin
					ld_r = 1'b1;
				end
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(reset)
            current_state <= S_LOAD;
        else
            current_state <= next_state;
    end // state_FFS
endmodule

module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule
