
/**************************************************** 30-SECOND TIMER *******************************************/

// Combines the following modules to create a 30-timer that is displayed, resets under game conditions, and has multiple speeds.

module timer (
  input clk,
  input reset_n,
  input [1:0] frequency, 
  output time_up,
  output [4:0] out,
  output reg warning
  );
  
  reg pulse;
  wire [27:0] rd0_out, rd1_out;

  // Slower speed
  rate_divider RD0 (
    .enable(1'd1), 
    .clk(clk), 
    .reset_n(!reset_n), 
    .d(28'd49_999_999), 
    .counter(rd0_out)
  );

  // Faster speed
  rate_divider RD1 (
    .enable(1'd1), 
    .clk(clk), 
    .reset_n(!reset_n), 
    .d(28'd19_999_999),
    .counter(rd1_out)
  );

  // Choose between speeds. 
  always @(*)
  begin
    case(frequency)
      2'b00: pulse = (rd0_out == 28'd0) ? 1'b1 : 1'b0;  // Slower speed
      2'b11: pulse = (rd1_out == 28'd0) ? 1'b1 : 1'b0; // Faster speed
      default: pulse = 1'd0; // Stops the timer from ticking. 
    endcase
  end

  display_counter DC0 (
    .clk(clk),
    .reset_n(reset_n),
    .pulse(pulse), 
    .time_up(time_up), // Outputs a signal when the timer hits zero, which is used to simulate "loading" in top module.
    .out(out)
  );
  
  always @(*)
  begin 
  warning = ((out <= 5'd10) && (out % 2 == 1'd0)) ? 1'd1 : 1'd0; // Signals warning flashes to activate during the last ten seconds. 
  end 

endmodule

/*************************************************** RATE DIVIDER ***********************************************/

// Changes the speed of the timer.

module rate_divider (
  input enable, 
  input clk, 
  input reset_n, 
  input [27:0] d, 
  output reg [27:0] counter
  );

  always @(posedge clk)
  begin
    if (reset_n == 1'd0) 
      counter <= 28'd0; 
    else if (counter == 28'd0) 
      counter <= d; 
    else 
    begin                           
      if (enable)
        counter <= counter - 1'd1;
      else 
        counter <= counter;
    end
  end
endmodule

/************************************************** DISPLAY COUNTER *********************************************/

// Modified for a 30-second timer. 

module display_counter (
  input clk, 
  input pulse, 
  input reset_n, 
  output reg time_up,
  output [4:0] out
  );

  reg [4:0] counter;
  assign out = counter;

  always @(posedge clk)
  begin: display_counter
    if (reset_n || counter == 5'd0) begin
      time_up = 1'd1; // Outputs a signal when the timer hits zero, which is used to simulate "loading" in top module. 
      counter = 5'd30; // Reset counter
    end
    else begin
    if (pulse) 
      if (counter != 5'd0)
        counter <= counter - 1'd1; // While the counter has not reached zero, continue the count down. 
      else 
	counter <= counter; 
	time_up <= 1'd0;  
    end
  end
endmodule
