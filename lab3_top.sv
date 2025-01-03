// define the states of the combination lock
`define reset_state  	4'b0000
`define correct1	4'b0001
`define correct2	4'b0010
`define correct3	4'b0011
`define correct4	4'b0100
`define correct5	4'b0101
`define correct6	4'b0110 // opened
`define wrong1		4'b0111
`define wrong2		4'b1000
`define wrong3		4'b1001
`define wrong4		4'b1010
`define wrong5		4'b1011
`define wrong6		4'b1100 // closed


module lab3_top(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);
	
	input [3:0] SW;
	input [3:0] KEY;
	output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output reg [9:0] LEDR;   // optional: use these outputs for debugging on your DE1-SoC

	wire clk = ~KEY[0];  // this is your clock
	wire rst_n = ~KEY[3]; // this is your reset; your reset should be synchronous and active-low (~?)

	// Regs for the state machine
	reg[3:0] present_state; // 4-bit state encoding for combination lock
	reg is_open;
	reg is_closed;

	// The State Machine 
	always @(posedge clk) begin
		
		if(rst_n) begin
			present_state = `reset_state; 
			is_open = 1'b0;
			is_closed = 1'b0;
		
		end else begin 
	
			case(present_state)
			
				`reset_state: begin
					if(SW == 4'b0110)
						present_state = `correct1;
					else
						present_state = `wrong1; end
					
				`correct1: begin
					if(SW == 4'd1)
						present_state = `correct2;
					else
						present_state = `wrong2; end
					
				`correct2: begin 
					if(SW == 4'd1)
						present_state = `correct3;
					else
						present_state = `wrong3; end
					
				`correct3: begin
					if(SW == 4'd3)
						present_state = `correct4;
					else
						present_state = `wrong4; end
					
				`correct4: begin
					if(SW == 4'd7)
						present_state = `correct5;
					else
						present_state = `wrong5; end
				
				`correct5: begin
					if(SW == 4'd1) begin
						present_state = `correct6;
						is_open = 1'b1; end
					else
						present_state = `wrong6; end
				
				`correct6: present_state = `correct6; 
				
				`wrong1: present_state = `wrong2; 
				
				`wrong2: present_state = `wrong3; 
					
				`wrong3: present_state = `wrong4; 
					
				`wrong4: present_state = `wrong5; 
					
				`wrong5: begin
					is_closed = 1'b1; 
					present_state = `wrong6; end
					
				`wrong6: present_state = `wrong6; 
			
				default: present_state = 4'bxxxx;		
				
			endcase 
		end
		
	end

	
	// The Combinational Logic Decoder
	always_comb begin
	
		if(is_open == 1'b1) begin
			HEX5 = 7'b1111111;
			HEX4 = 7'b1111111;
			HEX3 = 7'b1000000; // O
			HEX2 = 7'b0001100; // P
			HEX1 = 7'b0000110; // E 
			HEX0 = 7'b0101011; // n  
			
		
		end else if(is_closed == 1'b1) begin
			HEX5 = 7'b1000110; // C 
			HEX4 = 7'b1000111; // L 
			HEX3 = 7'b1000000; // O 
			HEX2 = 7'b0010010; // S 
			HEX1 = 7'b0000110; // E 
			HEX0 = 7'b0100001; // d 
			
		
		end else begin
			
			case(SW[3:0]) // Immediately displays the decimal number currently entered in binary on the switches 
			
				4'd0: begin HEX0 = 7'b1000000; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111; HEX5 = 7'b1111111; end // 0
				4'd1: begin HEX0 = 7'b1111001; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111; HEX5 = 7'b1111111; end // 1
				4'd2: begin HEX0 = 7'b0100100; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111; HEX5 = 7'b1111111; end // 2		
				4'd3: begin HEX0 = 7'b0110000; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111; HEX5 = 7'b1111111; end // 3	
				4'd4: begin HEX0 = 7'b0011001; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111; HEX5 = 7'b1111111; end // 4
				4'd5: begin HEX0 = 7'b0010010; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111; HEX5 = 7'b1111111; end // 5	
				4'd6: begin HEX0 = 7'b0000010; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111; HEX5 = 7'b1111111; end // 6
				4'd7: begin HEX0 = 7'b1111000; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111; HEX5 = 7'b1111111; end // 7
				4'd8: begin HEX0 = 7'b0000000; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111; HEX5 = 7'b1111111; end // 8
				4'd9: begin HEX0 = 7'b0011000; HEX1 = 7'b1111111; HEX2 = 7'b1111111; HEX3 = 7'b1111111; HEX4 = 7'b1111111; HEX5 = 7'b1111111; end // 9	
				default: begin		// Display "Error" if other number is entered on switches is invalid (>9)
					HEX5 = 7'b1111111;
					HEX4 = 7'b0000110; 
					HEX3 = 7'b0101111; 
					HEX2 = 7'b0101111; 
					HEX1 = 7'b0100011; 
					HEX0 = 7'b0101111; end
			
			endcase
		end
	end
	
endmodule 
