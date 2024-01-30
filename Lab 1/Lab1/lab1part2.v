module lab1part2 (input[3:0]SW,output[6:0] HEX0);
	
	seven_seg_decoder(SW[3:0],HEX0[6:0]);
	
endmodule
