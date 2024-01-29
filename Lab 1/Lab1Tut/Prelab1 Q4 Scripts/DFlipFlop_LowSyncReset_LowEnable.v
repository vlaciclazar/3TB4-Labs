module DFlipFlop_SyncReset_Enable(D,clk,sync_reset,enable,Q);

	input D; 
	input clk; 
	input sync_reset;
	input enable;
	output reg Q; 
	
	always @(posedge clk) begin
	
		if(!sync_reset) begin
			Q <= 1'b0; 
		end else if (!enable) begin
			Q <= D; 
		end
		
	end
	
endmodule 