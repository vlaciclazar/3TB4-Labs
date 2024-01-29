module counter (clk, reset, out);    
   
	input clk
	input reset
	output reg[3:0] out
  
	always @ (posedge clk) begin  
		if (reset) begin 
			out <= 4'b0000;  
		end else begin  
			out <= out + 4'b0001;  
		end
	end  

endmodule 
