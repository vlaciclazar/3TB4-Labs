module thirty_bit_counter( input clk , input reset , output reg [29:0] result );

	

	always@ ( posedge clk , negedge reset ) begin
		if (!reset ) begin
			result <= 30'b0;
		end else begin
			result <= result + 1'b1;
		end
	end
endmodule 