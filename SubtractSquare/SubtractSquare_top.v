/* 

Project: SubtractSquare
Authors: Wesley Kar-Ho Ma, Perrin Le, Tianhao Yao, Jayatharani Thirugnanasampanthan

Inputs
------
SW[3:0] are used to input a move. 
SW[8] & KEY[3] are used to reset the players' scores on the LEDs. 
SW[10:9] are used to select the speeds for the timer 
(set SW[10:9] low for a slower countdown and high for a faster countdown). 

KEY[0] should be pressed to clear the game state & reset the timer. 
KEY[1] should be pressed to generate a starting game state. 
KEY[2] should be pressed to load a move. 
KEY[3] should be pressed to update the score board of the player opposite to the indicating LED. 

Outputs
-------
HEX[7:6] display the 30-second timer. 
HEX[5:4] display the current player's input.
HEX[2:0] display the current game state. 

LEDR[17:16] are used to display the current player. 
LEDG[8] is used for the warning flashes during the last 10 seconds of the countdown.
LEDG[0:7] and LEDR[7:0] track players' scores. 

*/ 

/******************************************************************************************************/
/*						Top module			                      */
/******************************************************************************************************/

module SubtractSquare(SW, KEY, CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, LEDG, LEDR); 
  input [17:0] SW;
  input [3:0] KEY;
  input CLOCK_50;
  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
  output [17:0] LEDR;
  output [0:8] LEDG;

/********************* Compute next game state after a single move has been made ***********************/

  wire [7:0] next_game_state;
   
  single_move SINGLE_MOVE (
    .clk(CLOCK_50),
    .reset_n(~KEY[0]),
    .load_input(~KEY[2] || time_up), // Signal to load player's input is high when player presses key to "load" or timer hits zero. 
    .start(~KEY[1]),
    .player_input(SW[3:0]),
    .next_game_state(next_game_state)
   );

/***************************** Display current game state on HEX 0, 1 & 2  *****************************/
  
  wire [11:0] display_game_state;    

  // Converts 8-bit binary string to decimal.
  bcd_LUT LUT0 (
    .binary_string(next_game_state),
    .display_output(display_game_state)
  );
  
  // Hundreds
  binary_decoder H2 (
    .dec_digit(display_game_state[11:8]),
    .segments(HEX2)
  );
  
  // Tens
  binary_decoder H1 (
    .dec_digit(display_game_state[7:4]),
    .segments(HEX1)
  );
  
  // Ones
  binary_decoder H0 (
    .dec_digit(display_game_state[3:0]),
    .segments(HEX0) 
  );
  
/**************************************** Blank display on HEX3  **************************************/
 
  binary_decoder H3 (
    .dec_digit(4'd15),
    .segments(HEX3) 
  );

/******************************** Display player's input on HEX 4 & 5  ********************************/

  wire [11:0] display_player_input;

  // Converts 8-bit binary string to decimal.
  bcd_LUT LUT1 (
    .binary_string({4'd0, SW[3:0]}),
    .display_output(display_player_input)
  );

  // Tens
  binary_decoder H5 (
    .dec_digit(display_player_input[7:4]),
    .segments(HEX5)
  );

  // Ones 
  binary_decoder H4 (
    .dec_digit(display_player_input[3:0]),
    .segments(HEX4)
  );

/************************************** Display timer on HEX 6 & 7  ***********************************/  
  
  wire time_up;
  wire [4:0] countdown;
  wire [11:0] display_countdown;

  timer TIMER (
    .clk(CLOCK_50),
    .reset_n(~KEY[0] || ~KEY[2]), // Resets timer either by hitting the "reset" key or after a player makes their move. 
    .frequency(SW[10:9]), // Set low for slower speed and high for faster speed. 
    .time_up(time_up), // Outputs 1 iff timer hits zero, and 0 otherwise. 
    .out(countdown),
    .warning(LEDG[8])
  );

  // Converts 8-bit binary string to decimal.
  bcd_LUT LUT2 (
    .binary_string({3'd0, countdown}),
    .display_output(display_countdown)
  );

  // Tens
  binary_decoder H7 (
    .dec_digit(display_countdown[7:4]),
    .segments(HEX7)
  );

  // Ones
  binary_decoder H6 (
    .dec_digit(display_countdown[3:0]),
    .segments(HEX6)
  );

/***************************** Display scores and current players on LEDs ******************************/    

  wire current_player;  
  assign LEDR[17] = current_player; // p1
  assign LEDR[16] = !current_player; // p2

  switch_player CURRENT_PLAYER (
    .activate_switch(1'd1), 
    .reset(KEY[0]),
    .clk(~KEY[2] || ~time_up), // Switches player when it receives a signal (either by key or timer) that a player's input has been loaded. 
    .player(current_player)
  );
	
  update_score SCORE_BOARD (
    .reset_n(~SW[8]),
    .update_score(~KEY[3]),
    .game_state(next_game_state),
    .player(current_player),
    .p1_score(LEDR[7:0]),
    .p2_score(LEDG[0:7])
  );

 endmodule 
