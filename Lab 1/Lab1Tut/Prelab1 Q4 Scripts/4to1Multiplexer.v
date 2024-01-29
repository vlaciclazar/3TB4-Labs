module mux(a,b,c,d,sel,q);
	input[1:0] a;
	input[1:0] b;
	input[1:0] c;
	input[1:0] d;
	input[1:0] sel;
	output reg [1:0] q;
	

	always@(a or b or c or d or sel) 
	begin
	
		case(sel)
			2'b00: q <= a;
			2'b01: q <= b;
			2'b10: q <= c;
			2'b11: q <= d;
		endcase
		
	end
	
endmodule 

