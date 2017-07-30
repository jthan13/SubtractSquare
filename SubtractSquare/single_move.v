/*********************************************** SINGLE MOVE *********************************************/

// Computes a single move of SubtractSquare.

module single_move (
  input clk,
  input reset_n,
  input start,
  input load_input,
  input [3:0] player_input,
  output [7:0] next_game_state
  );

  // Wires connect the datapath and FSM. 
  wire ld_reg0, ld_reg1, ld_reg2, mux0_sel, mux1_sel, mux3_sel, alu_op;
  
  move_control C0 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start),
    .load_input(load_input),
    .ld_reg0(ld_reg0),
    .ld_reg1(ld_reg1),
    .ld_reg2(ld_reg2),
    .mux0_sel(mux0_sel),
    .mux1_sel(mux1_sel),
    .mux3_sel(mux3_sel),
    .alu_op(alu_op)
  );

  move_datapath D0 (
    .clk(clk), 
    .reset_n(reset_n), 
    .ld_reg0(ld_reg0), 
    .ld_reg1(ld_reg1), 
    .ld_reg2(ld_reg2), 
    .mux0_sel(mux0_sel), 
    .mux1_sel(mux1_sel), 
    .mux3_sel(mux3_sel),
    .enable_rand(start),
    .alu_op(alu_op),
    .player_input(player_input),
    .next_game_state(next_game_state)
  );

endmodule
      
/**************************************************** FSM ************************************************/

// Controls move_datapath. START and DISPLAY_INITIAL_GAME_STATE are only visited once after the players press the start key.

module move_control (
  input clk,
  input reset_n,
  input load_input,
  input start,
  output reg ld_reg0, ld_reg1, ld_reg2,
  output reg mux0_sel, mux1_sel, mux3_sel,
  output reg alu_op
  );

  reg [5:0] current_state, next_state; 

  localparam  START                         = 6'd0,
              DISPLAY_INITIAL_GAME_STATE    = 6'd1,
              LOAD_INPUT                    = 6'd2,
              LOAD_INPUT_WAIT               = 6'd3,
              COMPUTE_MOVE                  = 6'd4,
              COMPUTE_NEXT_GAME_STATE       = 6'd5;

  // Next state logic aka our state table
  always@(*)
  begin: state_table
        case (current_state)
          START: next_state = start ? DISPLAY_INITIAL_GAME_STATE: START; // Loops in current state until a player presses "start". 
          DISPLAY_INITIAL_GAME_STATE: next_state = LOAD_INPUT; // Generates a (pseudo-random) starting game state and transitions to the "load" state. 
          LOAD_INPUT: next_state = load_input ? LOAD_INPUT_WAIT : LOAD_INPUT; // Loops in current state until a player's input is "loaded". 
          LOAD_INPUT_WAIT: next_state = load_input ? LOAD_INPUT_WAIT : COMPUTE_MOVE; // Loops in current state until signal goes low. 
          COMPUTE_MOVE: next_state = COMPUTE_NEXT_GAME_STATE; // Computes move (perfect square) and transitions to the state that calculates the next game state. 
          COMPUTE_NEXT_GAME_STATE: next_state = LOAD_INPUT; // Computes the next game state and returns to the "load" state for the next player to play. 
        default:   next_state = START; 
    endcase
  end
  
  // Output logic aka all of our datapath control signals
  always @(*)
  begin: enable_signals
      ld_reg0 = 1'd0;
      ld_reg1 = 1'd1;
      ld_reg2 = 1'd0; 
      mux0_sel = 1'd0;
      mux1_sel = 1'd0;
      mux3_sel = 1'd0; 
      alu_op = 1'd0;
	
      case (current_state) 
      DISPLAY_INITIAL_GAME_STATE: 
        begin
    	  ld_reg2 = 1'd1; // Stores the starting "random" game state. 
	end
	  
      LOAD_INPUT: 
        begin 
    	  ld_reg0 = 1'd1; // Stores player's input. 
        end

      COMPUTE_MOVE: 
        begin 
          mux0_sel = 1'd0; // Select player's input. 
	  mux1_sel = 1'd1; // Selects player's input. 
	  alu_op = 1'd1; // Performs multiplication to get move (move = player's input * player's input). 
          ld_reg1 = 1'd1; // Stores move. 
        end

      COMPUTE_NEXT_GAME_STATE: 
        begin 
          mux0_sel = 1'd1; // Selects current game state. 
    	  mux1_sel = 1'd0; // Selects move. 
          alu_op = 1'd0; // Performs subtraction to get potential next game state (current game state - move). 
	  ld_reg1 = 1'd0; // Prevents infinite subtraction loop.
	  mux3_sel = 1'd1; // Selects result of MUX2 (either a new game state calculated with the player's chosen move or a forced one). 
	  ld_reg2 = 1'd1; // Stores next game state. 
        end 
  endcase
  end // enable signals

  always@(posedge clk)
  begin: state_FFs
    if (reset_n)
      current_state <= START;
    else
      current_state <= next_state;
  end 

endmodule

/**************************************************** DATAPATH ********************************************/

/* A series of registers, muxes, and an ALU that, with signals from the move_control module, computes the next game state given a player input and the previous game state.
Checking the validity of the player's chosen move is implemented here. Also, the "forced move" module is instantiated here. */

module move_datapath (
  input clk, 
  input reset_n, 
  input ld_reg0, 
  input ld_reg1, 
  input ld_reg2, 
  input mux0_sel, 
  input mux1_sel, 
  input mux3_sel,
  input alu_op,
  input enable_rand,
  input [3:0] player_input, 
  output [7:0] next_game_state
  );

  wire comparator_out;
  wire [7:0] reg0_out, reg1_out, reg2_out;
  wire [7:0] mux0_out, mux1_out, mux2_out, mux3_out, alu_out;
  wire [7:0] random_game_state, buffer, forced_move, game_state;

  // Generates a pseudo-random game state. 
  random_game_state R0 (
    .clk(clk),
    .reset_n(reset_n),
    .enable_rand(enable_rand),
    .next_game_state(random_game_state)
  );

  // Stores a player's input. 
  reg_8bit REG0 (
    .clk(clk),
    .reset_n(reset_n), 
    .load_n(ld_reg0), 
    .load_val({4'd0, player_input}), 
    .out(reg0_out)
  );
  
  // Selects the player's input or the current game state. 
  mux2to1_8bit MUX0 (
    .input0(reg0_out), 
    .input1(reg2_out), 
    .select(mux0_sel),
    .out(mux0_out) 
  );
  
  // Selects the player's move or mux0_out. Note: move = player's input * player's input. 
  mux2to1_8bit MUX1 (
    .input0(buffer), 
    .input1(mux0_out),  
    .select(mux1_sel),
    .out(mux1_out)
  ); 
  
  // Computes player's move (perfect square) or the potential next game state (current game state - move).
  mux2to1_8bit ALU (
    .input0(mux0_out - mux1_out), 
    .input1(mux1_out * mux0_out), 
    .select(alu_op),
    .out(alu_out)
    ); 

  // Checks whether the player's input is a valid move based on the current game state. 
  assign comparator_out = (8'd0 <= alu_out) && (alu_out < mux0_out);

  // Stores the output of the ALU.
  reg_8bit REG1 (
    .clk(clk),
    .reset_n(reset_n), 
    .load_n(ld_reg1), 
    .load_val(alu_out), 
    .out(buffer)
  );

  // Determines a "forced move" based on the current game state. 
  forced_move_LUT FM (
    .game_state(mux0_out),
    .move(forced_move)
  );

  // Selects the next game state that's either computed using the player's input or the "forced move". 
  mux2to1_8bit MUX2 (
    .input0(mux0_out - forced_move), // Game state computer using "forced move". 
    .input1(alu_out), // Game state computed using player's input. 
    .select(comparator_out), // 1 iff player's input is valid and 0 otherwise. 
    .out(mux2_out)
  );  

  // Selects the initial "random" game state or the game state in an ongoing match. 
  mux2to1_8bit MUX3 (
    .input0(random_game_state), 
    .input1(mux2_out), 
    .select(mux3_sel),
    .out(mux3_out)
  ); 

  // Stores the next game state to be used for the next player's turn. 
  reg_8bit REG2 (
    .clk(clk),
    .reset_n(reset_n), 
    .load_n(ld_reg2), 
    .load_val(mux3_out), 
    .out(reg2_out)
  );

  // Outputs the next game state. 
  assign next_game_state = reg2_out;
endmodule

/********************************************** 8-BIT REIGSTER *******************************************/

module reg_8bit (
  input clk, 
  input reset_n, 
  input load_n, 
  input [7:0] load_val,
  output [7:0] out
  );
  
  reg [7:0] store;
  assign out = store;

  always @(posedge clk)
  begin: register
    if (reset_n)
      store <= 8'd0;
    else if (load_n)
      store <= load_val;
  end 
 endmodule

/******************************************** 8-BIT 2 TO 1 MUX ******************************************/

module mux2to1_8bit (
  input [7:0] input0, // Chosen when "select" is 0. 
  input [7:0] input1, // Chosen when "select" is 1. 
  input select, // Select signal
  output [7:0] out // Output
  ); 
  
  assign out = select ? input1 : input0;

endmodule 
