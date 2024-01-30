module four_bit_counter( input clk , input reset , input enable , output reg [ WIDTH -1:0 ] result );

	parameter WIDTH =4;

	always@ (negedge enable, negedge reset) begin
		if (!reset  ) begin
			result <= 4'b0;
		end else if ( !enable ) begin
			result <= result + 1'b1;
		end
	end
endmodule