
//The function of this starterkit:
//1. After compile and download the starter kit to DE1-SoC board, the HEX LEDs will blink.
//2. After 6 seconds, the LDER9 is on, indicating the player 2 wins one time.
//3. Each tinm the KEY2 is pressed, the player 2 will win one more time after 6 secconds.
//4. Press KEY1 will reset the project.




//The requirements for your project:

// 1.   	Key1 for reset, Key2 for resume, Key0 is player 1, Key3 is for player 2
// 2.   	If Key0 is pressed earlier than Key3, player 1 wins. If Key3 is pressed earlier, player2 wins.
// 3. 	If Key0 and Key3 pressed at the same time, no one wins. 
// 4. 	If player1 wins, one more LEDs of the LED0-4 will light up.If player2 wins, one more LEDs of the LED=9-5 will light up,  
// 5. 	After power up, or after reset, all of LEDs are off. the HEXs will blink for 5 seconds. then will be off for  2+randdom seconds.
			//Here the random ranges form 1 sec to 5 sec
// 6. 	The winner's reaction time will show by the HEXs.
//	7. 	If there is a cheating (press the KEY0 or KEY3 before the timer starts,(in program, (set that if the timer reading is less than 
			//80 ms, it is cheating)
			//the cheater's number, either 111111 or 222222 will show by HEXs. The program then stop for resumeing for next round.
//	8. 	if both player is cheating at the same time (or both player pressed at the same time, which is not likely to happen), display 888888 by HEXs and then wait to resume the game.




module lab2(input CLOCK_50,  input [3:0] KEY,  output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5, output [9:0] LEDR);
		

	parameter [2:0] RESET=3'b000, RESUME=3'b001, BLINKING=3'b010, OFF=3'b011, TIMER_DISPLAY=3'b100, WINNER_TIME_DISPLAY=3'b101,
							CHEAT=3'b110, WAIT=3'b111;
	
	reg [2:0] state=RESET, next_state=RESET;
	
	
	wire clk_ms;
	wire [19:0] ms, display_ms;
	
	
	wire [3:0] w_ms [5:0]; //wires after hex_to_bcd_converter.v for displayed time
	wire [3:0] w_blink[5:0];  //wires afer  blinking 
	wire [3:0] winner_ms [5:0]; //wires afer hex_to_bcd_converter.v for winner time

	reg [1:0] cheater;
	wire [23:0] digits;
	wire [3:0] digit [5:0];
	
	assign digit[0] = digits[3:0];
	assign digit[1] = digits[7:4];
	assign digit[2] = digits[11:8];
	assign digit[3] = digits[15:12];
	assign digit[4] = digits[19:16];
	assign digit[5] = digits[23:20];
	
	wire [13:0] random_num;
	reg [13:0] random_wait_time;
	wire rnd_ready;

	
	reg [1:0]  hex_sel = 2'b00;  //whether blinking or not
	wire [1:0] w_hex_sel; 
	assign w_hex_sel = hex_sel;
	
	
	reg display_counter_start;
	wire w_display_counter_start;
	
	
	reg player1_win,player2_win;
	
	reg[4:0] win1,win2;   // score for player 1 and 2.

	reg [19:0]temp;

	reg [19:0] winner_time;
	wire [19:0] w_winner_time;
	
	wire conditioned_key0, conditioned_key3;

	assign w_winner_time=winner_time;

	
	assign w_display_counter_start=display_counter_start; 
	
	assign LEDR[4:0]=win1;
	assign LEDR[9:5]={win2[0],win2[1],win2[2],win2[3],win2[4]} ;   

	
	clock_divider #(.factor(50000)) (.Clock(CLOCK_50), .Reset_n(KEY[1]), .Pulse_ms(clk_ms));
	
	counter c1(.clk(clk_ms), .reset_n(KEY[1]), .resume_n(KEY[2]), .enable(1), .ms_count(ms));

	counter (.clk(clk_ms), .reset_n(KEY[1]), .resume_n(KEY[2]), .enable(w_display_counter_start), 
				.ms_count(display_ms));
	
	
	blinkHEX (.ms_clk(clk_ms),.Reset_n(KEY[1]),.d0(w_blink[0]),.d1(w_blink[1]),.d2(w_blink[2]),.d3(w_blink[3]),
				 .d4(w_blink[4]),.d5(w_blink[5]));
	
		 
	hex_to_bcd_converter(.clk(CLOCK_50),.reset(KEY[1]),.hex_number(display_ms),.bcd_digit_0(w_ms[0]),
								.bcd_digit_1(w_ms[1]),.bcd_digit_2(w_ms[2]),.bcd_digit_3(w_ms[3]),
								.bcd_digit_4(w_ms[4]),.bcd_digit_5(w_ms[5]));
	
	hex_to_bcd_converter(.clk(CLOCK_50),.reset(KEY[1]),.hex_number(w_winner_time),
								.bcd_digit_0(winner_ms[0]),.bcd_digit_1(winner_ms[1]),.bcd_digit_2(winner_ms[2]),
								.bcd_digit_3(winner_ms[3]),.bcd_digit_4(winner_ms[4]),.bcd_digit_5(winner_ms[5]));

	mux m0(.a({w_ms[5],w_ms[4],w_ms[3],w_ms[2],w_ms[1],w_ms[0]}),
			 .b({4'b1111,4'b1111,4'b1111,4'b1111,4'b1111,4'b1111}),
			 .c({winner_ms[5],winner_ms[4],winner_ms[3],winner_ms[2],winner_ms[1],winner_ms[0]}),
			 .d({w_blink[5],w_blink[4],w_blink[3],w_blink[2],w_blink[1],w_blink[0]}),.sel(w_hex_sel),.q(digits));
	
	seven_seg_decoder  decoder0(.x(digit[0]), .hex_LEDs(HEX0));
	seven_seg_decoder  decoder1(.x(digit[1]), .hex_LEDs(HEX1));
	seven_seg_decoder  decoder2(.x(digit[2]), .hex_LEDs(HEX2));
	seven_seg_decoder  decoder3(.x(digit[3]), .hex_LEDs(HEX3));
	seven_seg_decoder  decoder4(.x(digit[4]), .hex_LEDs(HEX4));
	seven_seg_decoder  decoder5(.x(digit[5]), .hex_LEDs(HEX5));

	
	random(.clk(CLOCK_50),.reset_n(KEY[1]),.resume_n(KEY[2]),.random(random_num),.rnd_ready(rnd_ready));
	
	always@(posedge CLOCK_50) begin
	
		if(rnd_ready) begin
		
			random_wait_time = random_num;
		
		end
	
	end
	
	always @ (posedge CLOCK_50, negedge KEY[1], negedge KEY[2])
	begin
		if (!KEY[1])    // reset
			begin
				state<=RESET;
			end
		else if (!KEY[2])   //start/resume
			begin
				state<=RESUME;

			end
	
		else
			begin
				state<=next_state;
			end
	end
	

	always @ (posedge CLOCK_50) 
	begin
		//BLINKING, OFF, P1_CHEAT, P2_CHEAT, READY, P1_WIN, P2_WIN, WIN, RESET
		case (state)
			RESET: 
				begin	
					display_counter_start<=0;
					winner_time<=0;
					hex_sel <= 2'b01;
					win1<= 5'b00000;
					win2<= 5'b00000;
					next_state<=BLINKING;	
					player1_win = 0;
					player2_win=0;
				end
			RESUME:
				begin	
					
					//hex_sel=2'b00;
					display_counter_start<=0;
					winner_time<=0;
					hex_sel <= 2'b01;
					player1_win = 0;
					player2_win=0;
					
					if (win1 == 5'b11111 || win2 == 5'b11111) begin
						win1 = 5'b00000;
						win2 = 5'b00000;
					end
					
					next_state<=BLINKING;
				end
			BLINKING:
				begin
					hex_sel<=2'b11;
					display_counter_start<= 0;
					//$monitor("[$monitor] time=%0t a-0x%0h",$time,ms);
					if (ms>=3000)        //blink for  about 3 second	
						begin
							//hex_sel=2'b01;
							next_state<=OFF;
						end
					else begin
						next_state<=BLINKING;
					end
						
				end
			
			OFF:
				begin
					hex_sel<=2'b01;
				
					
					if (ms>(5000+random_wait_time)) begin     //(7-5) seconds + random seconds)
						
						next_state<=TIMER_DISPLAY;	
						
					end else if (!KEY[0] && !KEY[3]) begin
						cheater<=2'b00;
						next_state<=CHEAT;
					end else if(!KEY[0] && KEY[3]) begin
						cheater<=2'b01;
						next_state<=CHEAT;
					end else if(!KEY[3] && KEY[0]) begin
						cheater<=2'b10;
						next_state<=CHEAT;
					end else begin	
						next_state<=OFF;
					end
				end
			TIMER_DISPLAY:
				begin
					display_counter_start<=1;
					hex_sel<=2'b00;	
					
				
					if (!KEY[0] && !KEY[3])
					begin
						display_counter_start<=0;
						next_state<=RESUME;
					end else if (!KEY[0] && KEY[3]) begin
						display_counter_start<=0;
						player1_win <= 1;
						next_state<=WINNER_TIME_DISPLAY;
					end else if (!KEY[3] && KEY[0]) begin
						display_counter_start<=0;
						player2_win <= 1;
						next_state<=WINNER_TIME_DISPLAY;
					end else begin
						next_state<=TIMER_DISPLAY;
					end
					
				
				end


			WINNER_TIME_DISPLAY:
				begin
					winner_time<=display_ms;
					display_counter_start<=0;
					hex_sel<=2'b10;

					if (player1_win) begin
						win1<=(win1<<1) | 5'b00001;
						player1_win <= 0;
						next_state<=WAIT;
					end else if (player2_win) begin
						win2<=(win2<<1) | 5'b00001;
						player2_win <= 0;
						next_state<=WAIT;
					end
				end
			
			CHEAT:
				begin
				if (cheater == 2'b00) begin
					winner_time <= 888888;
					hex_sel<=2'b10;
					next_state<=CHEAT;
				end else if (cheater == 2'b01)begin
					winner_time <= 111111;
					hex_sel<=2'b10;
					next_state<=CHEAT;
				end else if (cheater == 2'b10) begin
					winner_time <= 222222;
					hex_sel<=2'b10;
					next_state<=CHEAT;
						
				end	
				end
				
			WAIT: 
				begin
					next_state<=WAIT;
				end
				
			
		endcase	
	
	
	end
	
	
endmodule
