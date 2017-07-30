
/**************************************************** SCORE BOARD  *********************************************/

// Both shift registers perform logical right shift (loading 1s in the most significant bits) to track the scores.
  
module update_score (
  input reset_n,
  input update_score,
  input player,
  input [7:0] game_state, 
  output [7:0] p1_score,
  output [7:0] p2_score
  );

  wire update_p1_score;
  wire update_p2_score;  

  // Tracks p1's score.
  shifter P1_SCORE_BOARD (
    .clk(update_score && !player && !game_state), // Updates p1's score when game state is zero and whoever is about to play at that point is p2. 
    .reset_n(reset_n),
    .ASR(1'd0), 
    .load_n(1'd1), 
    .shift_right(1'd1), 
    .load_val(8'd0),
    .out(p1_score)
  );
   
  // Tracks p2's score. 
  shifter P2_SCORE_BOARD (
    .clk(update_score && player && !game_state), // Updates p2's score when game state is zero and whoever is about to play at that point is p1. 
    .reset_n(reset_n),
    .ASR(1'd0),  
    .load_n(1'd1), 
    .shift_right(1'd1), 
    .load_val(8'd0),
    .out(p2_score)
  );

 endmodule

/************************************************* SHIFT REGISTER  **********************************************/

module shifter (
  input clk, 
  input reset_n,
  input load_n, 
  input shift_right, 
  input ASR, 
  input [7:0] load_val,
  output [7:0] out
  );
  
  wire mux0out_to_shifter_bit7;

  mux2to1_1bit MUX (
    .input0(1'b1), // Selected when ASR is 0 (performs logical right shift).
    .input1(out[7]), // Selected when ASR is 1 (performs arithmetic right shift). Most significant bit is replicated.  
    .select(ASR), // Shift operation select signal
    .out(mux0out_to_shifter_bit7) // Wired to the input of SB7. 
  );
    
  shifter_bit SB7 (
    .out(out[7]), 
    .in(mux0out_to_shifter_bit7), // Input is wired to the output of MUX. 
    .shift(shift_right), 
    .load_val(load_val[7]), 
    .load_n(load_n), 
    .clk(clk), 
    .reset_n(reset_n)
  );

  shifter_bit SB6 (
    .out(out[6]),
    .in(out[7]), // Input is wired to the output of SB7. 
    .shift(shift_right), 
    .load_val(load_val[6]), 
    .load_n(load_n), 
    .clk(clk), 
    .reset_n(reset_n)
  );

  shifter_bit SB5 (
    .out(out[5]),
    .in(out[6]), // Input is wired to the output of SB6.
    .shift(shift_right), 
    .load_val(load_val[5]), 
    .load_n(load_n), 
    .clk(clk), 
    .reset_n(reset_n)
  );

  shifter_bit SB4 (
    .out(out[4]),
    .in(out[5]), // Input is wired to the output of SB5.
    .shift(shift_right), 
    .load_val(load_val[4]), 
    .load_n(load_n), 
    .clk(clk), 
    .reset_n(reset_n)
  );

  shifter_bit SB3 (
    .out(out[3]),
    .in(out[4]), // Input is wired to the output of SB4.
    .shift(shift_right), 
    .load_val(load_val[3]), 
    .load_n(load_n), 
    .clk(clk), 
    .reset_n(reset_n)
  );

  shifter_bit SB2 (
    .out(out[2]),
    .in(out[3]), // Input is wired to the output of SB3.
    .shift(shift_right), 
    .load_val(load_val[2]), 
    .load_n(load_n), 
    .clk(clk), 
    .reset_n(reset_n)
 );

  shifter_bit SB1 (
    .out(out[1]),
    .in(out[2]), // Input is wired to the output of SB2.
    .shift(shift_right), 
    .load_val(load_val[1]), 
    .load_n(load_n), 
    .clk(clk), 
    .reset_n(reset_n)
  );

  shifter_bit SB0 (
    .out(out[0]),
    .in(out[1]), // Input is wired to the output of SB1.
    .shift(shift_right), 
    .load_val(load_val[0]), 
    .load_n(load_n), 
    .clk(clk), 
    .reset_n(reset_n)
  );
  
endmodule

/*************************************************** SHIFTER BIT  **********************************************/

module shifter_bit (
  input clk, 
  input reset_n, 
  input in, 
  input shift, 
  input load_val, 
  input load_n,
  output out
  );
  
  wire mux0_out;
  wire mux1_out;
  
  mux2to1_1bit MUX0 (
    .input0(out), // Selected when shift is 0. Wired to output of FF. 
    .input1(in), // Selected when shift is 1. 
    .select(shift), // Selects between loading value from its own input or the previous flip flop output. 
    .out(mux0_out) // Wired to input1 of MUX1. 
  );
  
  mux2to1_1bit MUX1 ( 
    .input0(load_val), // Selected when load_n is 0. 
    .input1(mux0_out), // Selected when load_n is 1. 
    .select(load_n), // Selects between loading its own load value or the output of MUX0. 
    .out(mux1_out) // Wired to the input of FF. 
  );

  flip_flop FF ( 
    .clk(clk),
    .reset_n(reset_n),
    .d(mux1_out), // Wired to the output of MUX1. 
    .out(out) // Wired to input0 of MUX0. 
  );
  
endmodule

/***************************************************** D FLIP FLOP  ***********************************************/

module flip_flop (
  input clk, 
  input reset_n, 
  input d,
  output out
  );

  reg q;
  assign out = q;

  always @(posedge clk) 
    begin
      if (reset_n == 1'd0) 
        q <= 1'd0; 
      else 
        q <= d; // Value of d passes through to output q. 
  end
endmodule

/************************************************** 1-BIT 2 TO 1 MUX ********************************************/

module mux2to1_1bit (
  input input0, // Chosen when select is 0. 
  input input1, // Chosen when select is 1.
  input select, // Select signal
  output out // Output
  ); 
  
  assign out = select ? input1 : input0;

endmodule 

/**************************************************** T FLIP FLOP ************************************************/

// Tracks the current player using a T flip flop.
 
module switch_player (
  input activate_switch, 
  input clk, 
  input reset,
  output player
  );

  reg out;
  assign player = out;
  
  always @(posedge clk, negedge reset) 
  begin
    if (reset == 1'b0) 
      out <= 1'b0; 
    else 
      out <= out ^ activate_switch; // If activate_switch is high, the value of out is inverted. Otherwise, the value of out remains unchanged. 
  end 
endmodule 
