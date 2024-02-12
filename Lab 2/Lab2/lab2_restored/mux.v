module mux(
  input[23:0] a , 
  input[23:0] b ,
  input[23:0] c ,
  input[23:0] d ,
  input[1:0] sel, 
  output reg [23:0] q);
  
  always @(sel) begin

    if(!sel[1] && !sel[0])begin
		q[23:0] <= a[23:0];
		
	 end else if (!sel[1] && sel[0]) begin
		q[23:0] <= b[23:0];
		
	 end else if (sel[1] && !sel[0]) begin
		q[23:0] <= c[23:0];
		
	 end else if (sel[1] && sel[0]) begin
		q[23:0] <= d[23:0];
				
		
    end
  end
endmodule
