module lab1part3(input[9:0]SW,input [3:0]KEY, input CLOCK_50, output[6:0]HEX0);

	wire [3:0]four_bit_count;
	wire [29:0]thirty_bit_count;
	wire [3:0]seven_seg_input;	

	four_bit_counter counter_four(.clk(CLOCK_50),
											.reset(KEY[0]),
											.enable(KEY[3]),
											.result(four_bit_count[3:0])
											);
											
	thirty_bit_counter counter_thirty(.clk(CLOCK_50),
												 .reset(KEY[0]),
												 .result(thirty_bit_count[29:0])
												 );
	
	mux m1(.a(SW[3:0]),
			 .b(four_bit_count[3:0]),
			 .c(thirty_bit_count[29:26]),
			 .d(4'b1111),
			 .sel(SW[9:8]),
			 .q(seven_seg_input[3:0])
			 );
			 
	seven_seg_decoder seven_seg(.x(seven_seg_input),.hex_LEDs(HEX0[6:0]));
					 
endmodule 

		
		
		
		


	