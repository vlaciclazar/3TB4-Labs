module DFlipFlop_SyncReset(D,clk,sync_reset,Q);

	input D; 
	input clk; 
	input sync_reset;
	output reg Q; 
	
	always @(posedge clk) begin
	
		if(!sync_reset) begin
			Q <= 1'b0; 
		end else begin
			Q <= D; 
		end
		
	end
	
endmodule 