module dlatch(data,en,q);
	input D;
	input en;
	output q;

	always @(en or data) begin
		if (en) begin
			q <= D;
		end
	end
	
endmodule
