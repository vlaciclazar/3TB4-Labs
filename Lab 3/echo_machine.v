module echo_machine(input clk, input [15:0] input_sample, output reg [15:0] output_sample);

	wire[15:0] delay;
	
	wire[15:0] division;
	
	wire[15:0] output_feedback;
	
	assign output_feedback = output_sample;
	
	shift_register(.clock(clk),.shiftin(output_feedback),.shiftout(delay));
	
	assign division = delay >>> 5;
	
	always@(posedge clk) begin
	
	
		output_sample = division + input_sample;
	end
	
endmodule
	
	
	