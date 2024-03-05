module dsp_subsystem (input sample_clock,  input reset, input [1:0] selector, input [15:0] input_sample, output reg [15:0]output_sample);

wire[15:0] filtered_sample;
wire[15:0] echo_sample;

FIR_filter(.clk(sample_clock),.input_sample(input_sample),.output_sample(filtered_sample));
echo_machine(.clk(sample_clock),.input_sample(input_sample),.output_sample(echo_sample));

always @(posedge sample_clock) begin
case(selector)

	2'b00: begin
		output_sample = input_sample;
		end
		
	2'b01: begin
		output_sample = filtered_sample;
		end
	
	2'b10: begin
		output_sample = echo_sample;
		end

endcase
end
endmodule
