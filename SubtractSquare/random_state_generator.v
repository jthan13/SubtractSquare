/****************************************************** PSEUDO RANDOM GAME STATE GENERATOR *****************************************/

// Uses the LFSR and reg_random_num modules to generate a random number for the starting game state.

 module random_game_state (
  input clk,
  input reset_n,
  input enable_rand,
  output [7:0] next_game_state
  );
  
  wire [7:0] random_num;

  // Outputs the 8-bit "random" number. 
  lfsr L0 (
    .enable(1'b1), 
    .clk(clk), 
    .reset_n(reset_n),
    .out(random_num)  
  );

  // Stores the 8-bit "random" number to be used as the initial game state. 
  reg_random_num R0 (
    .clk(clk),
    .enable(enable_rand),
    .random(random_num),
    .out(next_game_state)
  );

endmodule 

/****************************************************** LINEAR FEEDBACK SHIFT REGISTER *********************************************/

// Retrieved from: http://www.asic-world.com/examples/verilog/lfsr.html. 

module lfsr (enable, clk, reset_n, out);
  input enable, clk, reset_n;
  reg [7:0] out;
  output [7:0] out;
  wire linear_feedback;
  assign linear_feedback =! (out[4] ^ out[2]);

  always @(posedge clk)
    if (reset_n) begin
      out <= 8'b0;
    end
    else if (enable) begin
      out <= {out[6], out[5],
	      out[4], out[3],
	      out[2], out[1],
              out[0], linear_feedback};
    end    
endmodule

/************************************* 8-BIT REGISTER (designed specifically for the LFSR) ********************************************/

// Stores a pseudo-random number from the LFSR in a register when enabled.

module reg_random_num (
  input enable, 
  input clk,
  input [7:0] random,
  output [7:0] out
  );

  reg [7:0] store;
  assign out = store;
  
  always @(posedge clk)
    if (enable) begin
      if(random == 8'd0) begin // Initial game state for SubtractSquare should never be zero. 
        store <= 8'd17; 
      end
      else begin
	store <= random;
      end
    end
endmodule
