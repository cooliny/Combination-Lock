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

module tb_lab3();
	
	// Declare inputs and outputs of DUT
	reg [3:0] sim_SW;
	reg [3:0] sim_KEY;
	reg [9:0] sim_LEDR;
	reg [6:0] sim_HEX0, sim_HEX1, sim_HEX2, sim_HEX3, sim_HEX4, sim_HEX5;

// DUT identifies instance

// initial blocks -> sequence of statements, order matters!
// Use delays! #<time units>;
// Use #display to "print out" values (e.g. $display("Output is %b, we expected %b", sim_result, (4?b1100 & 4?b1010));)
// Use #stop; to stop simulator

	lab3_top DUT(
		.SW(sim_SW), 
		.KEY(~sim_KEY),
		.LEDR(sim_LEDR),
		.HEX0(sim_HEX0), 
		.HEX1(sim_HEX1), 
		.HEX2(sim_HEX2), 
		.HEX3(sim_HEX3), 
		.HEX4(sim_HEX4), 
		.HEX5(sim_HEX5)
	);

	/* initial begin // clk change
		sim_KEY[0] = 0; 
		#5;
		forever begin
			sim_KEY[0] = 1; 
			#5;
			sim_KEY[0] = 0; 
			#5;
		end
	end */
	

	initial begin // For DUT inputs
		
		sim_SW = 4'd0;
		
		// Test Reset Mechanism
		sim_KEY[3] = 1'b1; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;
		sim_KEY[3] = 1'b0; #5;

		// Test State Machine
		// Test initialization to the reset (reset_pressed)
		if(tb_lab3.DUT.present_state == `reset_state)
			$display("In reset state");		
		else
			$display("Error");
		
		sim_SW = 4'd6; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;


		// Test transition to the 1st correct number 
		if(tb_lab3.DUT.present_state == `correct1)
			$display("Correct number 1");		
		else
			$display("Error");

		sim_SW = 4'd1; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;	
		

		// Test transition to the 2nd correct number
		if(tb_lab3.DUT.present_state == `correct2)
			$display("Correct number 2");		
		else
			$display("Error");
		sim_SW = 4'd1; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;


		// Test transition to the 3rd corect number
		if(tb_lab3.DUT.present_state == `correct3)
			$display("Correct number 3");		
		else
			$display("Error");
		sim_SW = 4'd3; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;


		// Test transition to the 4th correct number
		if(tb_lab3.DUT.present_state == `correct4)
			$display("Correct number 4");		
		else
			$display("Error");
		sim_SW = 4'd7; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;


		// Test transition to the 5th correct number
		if(tb_lab3.DUT.present_state == `correct5)
			$display("Correct number 5");		
		else
			$display("Error");
		sim_SW = 4'd1; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;


		// Test transition to the 6th correct number
		if(tb_lab3.DUT.present_state == `correct6)
			$display("Correct number 6");		
		else
			$display("Error");
		
		#20; // Reset to test a different combination
		sim_KEY[3] = 1'b1; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;
		sim_KEY[3] = 1'b0; #5;
		
		// Test initialization to the reset (reset_pressed)
		if(tb_lab3.DUT.present_state == `reset_state)
			$display("In reset state");		
		else
			$display("Error");
		
		sim_SW = 4'd6; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;


		// Test transition to the 1st correct number 
		if(tb_lab3.DUT.present_state == `correct1)
			$display("Correct number 1");		
		else
			$display("Error");

		sim_SW = 4'd1; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;	


		// Test transition to the 2nd correct number 
		if(tb_lab3.DUT.present_state == `correct2)
			$display("Correct number 2");		
		else
			$display("Error");

		sim_SW = 4'd2; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;	
		
		// Test transition to an incorrect number 
		if(tb_lab3.DUT.present_state == `correct3)
			$display("Correct number 2");		
		else
			$display("Wrong Number 3");

		sim_SW = 4'd3; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;	

		// Test transition to the 4th correct number 
		if(tb_lab3.DUT.present_state == `wrong4)
			$display("Correct number 4");		
		else
			$display("Error");

		sim_SW = 4'd7; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;	

		// Test transition to the 5th correct number 
		if(tb_lab3.DUT.present_state == `wrong5)
			$display("Correct number 5");		
		else
			$display("Error");

		sim_SW = 4'd1; #5;
		sim_KEY[0] = 1'b1; #5;
		sim_KEY[0] = 1'b0; #5;	

		// Test transition to the 6th correct number 
		if(tb_lab3.DUT.present_state == `wrong6) 
			$display("Correct number 5");		
		else
			$display("Error");

	end	

endmodule: tb_lab3
