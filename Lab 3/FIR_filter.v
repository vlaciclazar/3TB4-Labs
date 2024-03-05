module FIR_filter(input clk, input [15:0] input_sample , output reg [15:0] output_sample);

	parameter N = 32;
	
	wire signed [15:0] coeff [160:0];
	wire signed [31:0] out[N-1:0];
	reg signed [15:0] out_15_shifted [N-1:0];
	reg signed [15:0] input_sample_shifted[N-1:0];
	reg signed [15:0] summation;
	

	assign coeff [  0] =      -441;
	assign coeff [  1] =         0;
	assign coeff [  2] =       674;
	assign coeff [  3] =         0;
	assign coeff [  4] =     -1092;
	assign coeff [  5] =         0;
	assign coeff [  6] =      1581;
	assign coeff [  7] =        -0;
	assign coeff [  8] =     -2097;
	assign coeff [  9] =         0;
	assign coeff [ 10] =      2585;
	assign coeff [ 11] =         0;
	assign coeff [ 12] =     -2988;
	assign coeff [ 13] =         0;
	assign coeff [ 14] =      3253;
	assign coeff [ 15] =        -0;
	assign coeff [ 16] =     29422;
	assign coeff [ 17] =        -0;
	assign coeff [ 18] =      3253;
	assign coeff [ 19] =         0;
	assign coeff [ 20] =     -2988;
	assign coeff [ 21] =         0;
	assign coeff [ 22] =      2585;
	assign coeff [ 23] =         0;
	assign coeff [ 24] =     -2097;
	assign coeff [ 25] =        -0;
	assign coeff [ 26] =      1581;
	assign coeff [ 27] =         0;
	assign coeff [ 28] =     -1092;
	assign coeff [ 29] =         0;
	assign coeff [ 30] =       674;
	assign coeff [ 31] =         0;
	assign coeff [ 32] =      -441;


/*
	assign coeff [  0] =        -0;
	assign coeff [  1] =         0;
	assign coeff [  2] =         0;
	assign coeff [  3] =        -0;
	assign coeff [  4] =        -0;
	assign coeff [  5] =         0;
	assign coeff [  6] =         0;
	assign coeff [  7] =        -0;
	assign coeff [  8] =        -0;
	assign coeff [  9] =         0;
	assign coeff [ 10] =         0;
	assign coeff [ 11] =        -0;
	assign coeff [ 12] =        -0;
	assign coeff [ 13] =         0;
	assign coeff [ 14] =         0;
	assign coeff [ 15] =        -0;
	assign coeff [ 16] =        -0;
	assign coeff [ 17] =         0;
	assign coeff [ 18] =         0;
	assign coeff [ 19] =        -0;
	assign coeff [ 20] =        -1;
	assign coeff [ 21] =         0;
	assign coeff [ 22] =         1;
	assign coeff [ 23] =         0;
	assign coeff [ 24] =        -2;
	assign coeff [ 25] =        -0;
	assign coeff [ 26] =         4;
	assign coeff [ 27] =         0;
	assign coeff [ 28] =        -6;
	assign coeff [ 29] =        -0;
	assign coeff [ 30] =        10;
	assign coeff [ 31] =         0;
	assign coeff [ 32] =       -16;
	assign coeff [ 33] =        -0;
	assign coeff [ 34] =        24;
	assign coeff [ 35] =         0;
	assign coeff [ 36] =       -36;
	assign coeff [ 37] =        -0;
	assign coeff [ 38] =        51;
	assign coeff [ 39] =         0;
	assign coeff [ 40] =       -72;
	assign coeff [ 41] =        -0;
	assign coeff [ 42] =       100;
	assign coeff [ 43] =         0;
	assign coeff [ 44] =      -134;
	assign coeff [ 45] =        -0;
	assign coeff [ 46] =       178;
	assign coeff [ 47] =         0;
	assign coeff [ 48] =      -231;
	assign coeff [ 49] =        -0;
	assign coeff [ 50] =       294;
	assign coeff [ 51] =         0;
	assign coeff [ 52] =      -369;
	assign coeff [ 53] =        -0;
	assign coeff [ 54] =       454;
	assign coeff [ 55] =         0;
	assign coeff [ 56] =      -549;
	assign coeff [ 57] =        -0;
	assign coeff [ 58] =       653;
	assign coeff [ 59] =         0;
	assign coeff [ 60] =      -765;
	assign coeff [ 61] =        -0;
	assign coeff [ 62] =       882;
	assign coeff [ 63] =         0;
	assign coeff [ 64] =     -1000;
	assign coeff [ 65] =        -0;
	assign coeff [ 66] =      1118;
	assign coeff [ 67] =         0;
	assign coeff [ 68] =     -1230;
	assign coeff [ 69] =        -0;
	assign coeff [ 70] =      1334;
	assign coeff [ 71] =         0;
	assign coeff [ 72] =     -1425;
	assign coeff [ 73] =        -0;
	assign coeff [ 74] =      1499;
	assign coeff [ 75] =         0;
	assign coeff [ 76] =     -1555;
	assign coeff [ 77] =        -0;
	assign coeff [ 78] =      1589;
	assign coeff [ 79] =         0;
	assign coeff [ 80] =     31167;
	assign coeff [ 81] =         0;
	assign coeff [ 82] =      1589;
	assign coeff [ 83] =        -0;
	assign coeff [ 84] =     -1555;
	assign coeff [ 85] =         0;
	assign coeff [ 86] =      1499;
	assign coeff [ 87] =        -0;
	assign coeff [ 88] =     -1425;
	assign coeff [ 89] =         0;
	assign coeff [ 90] =      1334;
	assign coeff [ 91] =        -0;
	assign coeff [ 92] =     -1230;
	assign coeff [ 93] =         0;
	assign coeff [ 94] =      1118;
	assign coeff [ 95] =        -0;
	assign coeff [ 96] =     -1000;
	assign coeff [ 97] =         0;
	assign coeff [ 98] =       882;
	assign coeff [ 99] =        -0;
	assign coeff [100] =      -765;
	assign coeff [101] =         0;
	assign coeff [102] =       653;
	assign coeff [103] =        -0;
	assign coeff [104] =      -549;
	assign coeff [105] =         0;
	assign coeff [106] =       454;
	assign coeff [107] =        -0;
	assign coeff [108] =      -369;
	assign coeff [109] =         0;
	assign coeff [110] =       294;
	assign coeff [111] =        -0;
	assign coeff [112] =      -231;
	assign coeff [113] =         0;
	assign coeff [114] =       178;
	assign coeff [115] =        -0;
	assign coeff [116] =      -134;
	assign coeff [117] =         0;
	assign coeff [118] =       100;
	assign coeff [119] =        -0;
	assign coeff [120] =       -72;
	assign coeff [121] =         0;
	assign coeff [122] =        51;
	assign coeff [123] =        -0;
	assign coeff [124] =       -36;
	assign coeff [125] =         0;
	assign coeff [126] =        24;
	assign coeff [127] =        -0;
	assign coeff [128] =       -16;
	assign coeff [129] =         0;
	assign coeff [130] =        10;
	assign coeff [131] =        -0;
	assign coeff [132] =        -6;
	assign coeff [133] =         0;
	assign coeff [134] =         4;
	assign coeff [135] =        -0;
	assign coeff [136] =        -2;
	assign coeff [137] =         0;
	assign coeff [138] =         1;
	assign coeff [139] =         0;
	assign coeff [140] =        -1;
	assign coeff [141] =        -0;
	assign coeff [142] =         0;
	assign coeff [143] =         0;
	assign coeff [144] =        -0;
	assign coeff [145] =        -0;
	assign coeff [146] =         0;
	assign coeff [147] =         0;
	assign coeff [148] =        -0;
	assign coeff [149] =        -0;
	assign coeff [150] =         0;
	assign coeff [151] =         0;
	assign coeff [152] =        -0;
	assign coeff [153] =        -0;
	assign coeff [154] =         0;
	assign coeff [155] =         0;
	assign coeff [156] =        -0;
	assign coeff [157] =        -0;
	assign coeff [158] =         0;
	assign coeff [159] =         0;
	assign coeff [160] =        -0;
*/
	
	genvar i;
	integer k;
	generate
	for (i=0;i<N;i=i+1) begin:
		mult1 multiplier(.dataa(input_sample_shifted[i]),.datab(coeff[i]),.result(out[i]));
		
	end
	endgenerate
	
	always@(posedge clk) begin

		for (k=0;k<N;k=k+1) begin
		
			out_15_shifted[k] = out[k] >>> 15;
		end
		
	end
	
	integer j;
	integer l;
	
	always@(posedge clk) begin

	
		for(j=N-1;j>0;j=j-1) begin
			input_sample_shifted[j] = input_sample_shifted[j-1];

		end
		input_sample_shifted[0] = input_sample;

		for (l=0;l<N;l=l+1) begin
			summation = summation + out_15_shifted[l];
		end
		
		output_sample = summation;
		
			
	end
	
endmodule
	