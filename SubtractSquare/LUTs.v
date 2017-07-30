/****************************************** FORCED MOVE LOOK-UP TABLE ***********************************/

/* Outputs a move based on the current game state when a player fails to load a valid move. 

The "forced move" is the greatest valid perfect square possible that will not end the 
game, except in the case that the current game state is 1.

The "forced move" feature does not usually disadvantage the next player. */

module forced_move_LUT (game_state, move);
  input [7:0] game_state;
  reg [7:0] perfect_square;
  output [7:0] move; 
  
  assign move = perfect_square;

  always @(*)
    case(game_state)

      8'd1: perfect_square = 8'd1; // Outputs 1 as the "forced move" when the game_state falls between: 1 & 4. 
      8'd2: perfect_square = 8'd1;
      8'd3: perfect_square = 8'd1; 
      8'd4: perfect_square = 8'd1;
       
      8'd5: perfect_square = 8'd4; // Outputs 4 as the "forced move" when game_state falls between: 5 & 9. 
      8'd6: perfect_square = 8'd4; 
      8'd7: perfect_square = 8'd4; 
      8'd8: perfect_square = 8'd4; 
      8'd9: perfect_square = 8'd4; 

      8'd10: perfect_square = 8'd9; // Outputs 9 as the "forced move" when game_state falls between: 10 & 16. 
      8'd11: perfect_square = 8'd9; 
      8'd12: perfect_square = 8'd9; 
      8'd13: perfect_square = 8'd9; 
      8'd14: perfect_square = 8'd9; 
      8'd15: perfect_square = 8'd9; 
      8'd16: perfect_square = 8'd9;
       
      8'd17: perfect_square = 8'd16; // Outputs 16 as the "forced move" when game_state falls between: 17 & 25. 
      8'd18: perfect_square = 8'd16; 
      8'd19: perfect_square = 8'd16;
      8'd20: perfect_square = 8'd16; 
      8'd21: perfect_square = 8'd16; 
      8'd22: perfect_square = 8'd16; 
      8'd23: perfect_square = 8'd16; 
      8'd24: perfect_square = 8'd16; 
      8'd25: perfect_square = 8'd16; 
      
      8'd26: perfect_square = 8'd25; // Outputs 25 as the "forced move" when game_state falls between: 26 & 36. 
      8'd27: perfect_square = 8'd25; 
      8'd28: perfect_square = 8'd25; 
      8'd29: perfect_square = 8'd25; 
      8'd30: perfect_square = 8'd25; 
      8'd31: perfect_square = 8'd25; 
      8'd32: perfect_square = 8'd25; 
      8'd33: perfect_square = 8'd25; 
      8'd34: perfect_square = 8'd25; 
      8'd35: perfect_square = 8'd25; 
      8'd36: perfect_square = 8'd25;
       
      8'd37: perfect_square = 8'd36; // Outputs 36 as the "forced move" when game_state falls between: 37 & 49. 
      8'd38: perfect_square = 8'd36; 
      8'd39: perfect_square = 8'd36;
      8'd40: perfect_square = 8'd36; 
      8'd41: perfect_square = 8'd36;
      8'd42: perfect_square = 8'd36; 
      8'd43: perfect_square = 8'd36; 
      8'd44: perfect_square = 8'd36; 
      8'd45: perfect_square = 8'd36; 
      8'd46: perfect_square = 8'd36; 
      8'd47: perfect_square = 8'd36; 
      8'd48: perfect_square = 8'd36; 
      8'd49: perfect_square = 8'd36; 

      8'd50: perfect_square = 8'd49; // Outputs 49 as the "forced move" when game_state falls between: 50 & 64. 
      8'd51: perfect_square = 8'd49; 
      8'd52: perfect_square = 8'd49; 
      8'd53: perfect_square = 8'd49; 
      8'd54: perfect_square = 8'd49; 
      8'd55: perfect_square = 8'd49; 
      8'd56: perfect_square = 8'd49; 
      8'd57: perfect_square = 8'd49; 
      8'd58: perfect_square = 8'd49; 
      8'd59: perfect_square = 8'd49; 
      8'd60: perfect_square = 8'd49; 
      8'd61: perfect_square = 8'd49; 
      8'd62: perfect_square = 8'd49; 
      8'd63: perfect_square = 8'd49; 
      8'd64: perfect_square = 8'd49; 
      
      8'd65: perfect_square = 8'd64; // Outputs 64 as the "forced move" when game_state falls between: 65 & 81. 
      8'd66: perfect_square = 8'd64; 
      8'd67: perfect_square = 8'd64; 
      8'd68: perfect_square = 8'd64; 
      8'd69: perfect_square = 8'd64; 
      8'd70: perfect_square = 8'd64; 
      8'd71: perfect_square = 8'd64; 
      8'd72: perfect_square = 8'd64; 
      8'd73: perfect_square = 8'd64;
      8'd74: perfect_square = 8'd64; 
      8'd75: perfect_square = 8'd64; 
      8'd76: perfect_square = 8'd64; 
      8'd77: perfect_square = 8'd64; 
      8'd78: perfect_square = 8'd64; 
      8'd79: perfect_square = 8'd64; 
      8'd80: perfect_square = 8'd64; 
      8'd81: perfect_square = 8'd64; 
      
      8'd82: perfect_square = 8'd81; // Outputs 81 as the "forced move" when game_state falls between: 82 & 100. 
      8'd83: perfect_square = 8'd81; 
      8'd84: perfect_square = 8'd81; 
      8'd85: perfect_square = 8'd81; 
      8'd86: perfect_square = 8'd81; 
      8'd87: perfect_square = 8'd81; 
      8'd88: perfect_square = 8'd81; 
      8'd89: perfect_square = 8'd81; 
      8'd90: perfect_square = 8'd81; 
      8'd91: perfect_square = 8'd81; 
      8'd92: perfect_square = 8'd81; 
      8'd93: perfect_square = 8'd81; 
      8'd94: perfect_square = 8'd81; 
      8'd95: perfect_square = 8'd81; 
      8'd96: perfect_square = 8'd81; 
      8'd97: perfect_square = 8'd81; 
      8'd98: perfect_square = 8'd81; 
      8'd99: perfect_square = 8'd81; 
      8'd100: perfect_square = 8'd81; 
      
      8'd101: perfect_square = 8'd100; // Outputs 100 as the "forced move" when game_state falls between: 101 & 121. 
      8'd102: perfect_square = 8'd100; 
      8'd103: perfect_square = 8'd100; 
      8'd104: perfect_square = 8'd100; 
      8'd105: perfect_square = 8'd100; 
      8'd106: perfect_square = 8'd100; 
      8'd107: perfect_square = 8'd100; 
      8'd108: perfect_square = 8'd100; 
      8'd109: perfect_square = 8'd100; 
      8'd110: perfect_square = 8'd100; 
      8'd111: perfect_square = 8'd100; 
      8'd112: perfect_square = 8'd100; 
      8'd113: perfect_square = 8'd100; 
      8'd114: perfect_square = 8'd100; 
      8'd115: perfect_square = 8'd100; 
      8'd116: perfect_square = 8'd100; 
      8'd117: perfect_square = 8'd100; 
      8'd118: perfect_square = 8'd100; 
      8'd119: perfect_square = 8'd100; 
      8'd120: perfect_square = 8'd100; 
      8'd121: perfect_square = 8'd100; 
      
      8'd122: perfect_square = 8'd121; // Outputs 121 as the "forced move" when game_state falls between: 122 & 144. 
      8'd123: perfect_square = 8'd121; 
      8'd124: perfect_square = 8'd121; 
      8'd125: perfect_square = 8'd121; 
      8'd126: perfect_square = 8'd121; 
      8'd127: perfect_square = 8'd121; 
      8'd128: perfect_square = 8'd121; 
      8'd129: perfect_square = 8'd121; 
      8'd130: perfect_square = 8'd121; 
      8'd131: perfect_square = 8'd121; 
      8'd132: perfect_square = 8'd121; 
      8'd133: perfect_square = 8'd121; 
      8'd134: perfect_square = 8'd121; 
      8'd135: perfect_square = 8'd121; 
      8'd136: perfect_square = 8'd121; 
      8'd137: perfect_square = 8'd121; 
      8'd138: perfect_square = 8'd121; 
      8'd139: perfect_square = 8'd121; 
      8'd140: perfect_square = 8'd121; 
      8'd141: perfect_square = 8'd121; 
      8'd142: perfect_square = 8'd121; 
      8'd143: perfect_square = 8'd121; 
      8'd144: perfect_square = 8'd121; 
      
      8'd145: perfect_square = 8'd144; // Outputs 144 as the "forced move" when game_state falls between: 145 & 169. 
      8'd146: perfect_square = 8'd144; 
      8'd147: perfect_square = 8'd144; 
      8'd148: perfect_square = 8'd144; 
      8'd149: perfect_square = 8'd144; 
      8'd150: perfect_square = 8'd144; 
      8'd151: perfect_square = 8'd144; 
      8'd152: perfect_square = 8'd144; 
      8'd153: perfect_square = 8'd144; 
      8'd154: perfect_square = 8'd144; 
      8'd155: perfect_square = 8'd144; 
      8'd156: perfect_square = 8'd144; 
      8'd157: perfect_square = 8'd144; 
      8'd158: perfect_square = 8'd144; 
      8'd159: perfect_square = 8'd144;
      8'd160: perfect_square = 8'd144; 
      8'd161: perfect_square = 8'd144; 
      8'd162: perfect_square = 8'd144; 
      8'd163: perfect_square = 8'd144; 
      8'd164: perfect_square = 8'd144; 
      8'd165: perfect_square = 8'd144; 
      8'd166: perfect_square = 8'd144; 
      8'd167: perfect_square = 8'd144; 
      8'd168: perfect_square = 8'd144; 
      8'd169: perfect_square = 8'd144; 

      8'd170: perfect_square = 8'd169; // Outputs 169 as the "forced move" when game_state falls between: 170 & 196. 
      8'd171: perfect_square = 8'd169; 
      8'd172: perfect_square = 8'd169; 
      8'd173: perfect_square = 8'd169; 
      8'd174: perfect_square = 8'd169; 
      8'd175: perfect_square = 8'd169; 
      8'd176: perfect_square = 8'd169; 
      8'd177: perfect_square = 8'd169; 
      8'd178: perfect_square = 8'd169; 
      8'd179: perfect_square = 8'd169;
      8'd180: perfect_square = 8'd169; 
      8'd181: perfect_square = 8'd169; 
      8'd182: perfect_square = 8'd169; 
      8'd183: perfect_square = 8'd169; 
      8'd184: perfect_square = 8'd169; 
      8'd185: perfect_square = 8'd169; 
      8'd186: perfect_square = 8'd169; 
      8'd187: perfect_square = 8'd169; 
      8'd188: perfect_square = 8'd169; 
      8'd189: perfect_square = 8'd169; 
      8'd190: perfect_square = 8'd169; 
      8'd191: perfect_square = 8'd169; 
      8'd192: perfect_square = 8'd169; 
      8'd193: perfect_square = 8'd169; 
      8'd194: perfect_square = 8'd169; 
      8'd195: perfect_square = 8'd169; 
      8'd196: perfect_square = 8'd169; 
      
      8'd197: perfect_square = 8'd196; // Outputs 196 as the "forced move" when game_state falls between: 197 & 225. 
      8'd198: perfect_square = 8'd196; 
      8'd199: perfect_square = 8'd196; 
      8'd200: perfect_square = 8'd196; 
      8'd201: perfect_square = 8'd196; 
      8'd202: perfect_square = 8'd196; 
      8'd203: perfect_square = 8'd196; 
      8'd204: perfect_square = 8'd196; 
      8'd205: perfect_square = 8'd196; 
      8'd206: perfect_square = 8'd196; 
      8'd207: perfect_square = 8'd196; 
      8'd208: perfect_square = 8'd196; 
      8'd209: perfect_square = 8'd196; 
      8'd210: perfect_square = 8'd196; 
      8'd211: perfect_square = 8'd196; 
      8'd212: perfect_square = 8'd196; 
      8'd213: perfect_square = 8'd196; 
      8'd214: perfect_square = 8'd196; 
      8'd215: perfect_square = 8'd196; 
      8'd216: perfect_square = 8'd196; 
      8'd217: perfect_square = 8'd196; 
      8'd218: perfect_square = 8'd196; 
      8'd219: perfect_square = 8'd196; 
      8'd220: perfect_square = 8'd196; 
      8'd221: perfect_square = 8'd196; 
      8'd222: perfect_square = 8'd196; 
      8'd223: perfect_square = 8'd196; 
      8'd224: perfect_square = 8'd196; 
      8'd225: perfect_square = 8'd196;
       
      8'd226: perfect_square = 8'd225; // Outputs 225 as the "forced move" when game_state falls between: 226 & 225. 
      8'd227: perfect_square = 8'd225; 
      8'd228: perfect_square = 8'd225; 
      8'd229: perfect_square = 8'd225; 
      8'd230: perfect_square = 8'd225; 
      8'd231: perfect_square = 8'd225; 
      8'd232: perfect_square = 8'd225; 
      8'd233: perfect_square = 8'd225; 
      8'd234: perfect_square = 8'd225; 
      8'd235: perfect_square = 8'd225; 
      8'd236: perfect_square = 8'd225; 
      8'd237: perfect_square = 8'd225; 
      8'd238: perfect_square = 8'd225; 
      8'd239: perfect_square = 8'd225; 
      8'd240: perfect_square = 8'd225; 
      8'd241: perfect_square = 8'd225; 
      8'd242: perfect_square = 8'd225; 
      8'd243: perfect_square = 8'd225; 
      8'd244: perfect_square = 8'd225; 
      8'd245: perfect_square = 8'd225; 
      8'd246: perfect_square = 8'd225;
      8'd247: perfect_square = 8'd225; 
      8'd248: perfect_square = 8'd225; 
      8'd249: perfect_square = 8'd225; 
      8'd250: perfect_square = 8'd225; 
      8'd251: perfect_square = 8'd225; 
      8'd252: perfect_square = 8'd225; 
      8'd253: perfect_square = 8'd225; 
      8'd254: perfect_square = 8'd225; 
      8'd255: perfect_square = 8'd225; 
      
      default: perfect_square = 8'd0; // game_state remains 0 (when player loses the game). 
    endcase
endmodule

/********************************************** BCD LOOK-UP TABLE *****************************************/

/* A binary-coded decimal converter. 

Given a binary number, seperate it into three 1 digit binary numbers to be displayed using binary_decoder module. */ 

module bcd_LUT (binary_string, display_output);
  input [7:0] binary_string;
  reg [11:0] out;
  output [11:0] display_output; 
  
  assign display_output = out;

  always @(*)
    case(binary_string)
      8'd0: out = 12'b0000_0000_0000; // 000
      8'd1: out = 12'b0000_0000_0001; // 001
      8'd2: out = 12'b0000_0000_0010; // 002
      8'd3: out = 12'b0000_0000_0011; // 003
      8'd4: out = 12'b0000_0000_0100; // 004
      8'd5: out = 12'b0000_0000_0101; // 005
      8'd6: out = 12'b0000_0000_0110; // 006
      8'd7: out = 12'b0000_0000_0111; // 007
      8'd8: out = 12'b0000_0000_1000; // 008
      8'd9: out = 12'b0000_0000_1001; // 009

      8'd10: out = 12'b0000_0001_0000; // 010
      8'd11: out = 12'b0000_0001_0001; // 011
      8'd12: out = 12'b0000_0001_0010; // 012
      8'd13: out = 12'b0000_0001_0011; // 013
      8'd14: out = 12'b0000_0001_0100; // 014
      8'd15: out = 12'b0000_0001_0101; // 015
      8'd16: out = 12'b0000_0001_0110; // 016
      8'd17: out = 12'b0000_0001_0111; // 017
      8'd18: out = 12'b0000_0001_1000; // 018
      8'd19: out = 12'b0000_0001_1001; // 019

      8'd20: out = 12'b0000_0010_0000; // 020
      8'd21: out = 12'b0000_0010_0001; // 021
      8'd22: out = 12'b0000_0010_0010; // 022
      8'd23: out = 12'b0000_0010_0011; // 023
      8'd24: out = 12'b0000_0010_0100; // 024
      8'd25: out = 12'b0000_0010_0101; // 025
      8'd26: out = 12'b0000_0010_0110; // 026
      8'd27: out = 12'b0000_0010_0111; // 027
      8'd28: out = 12'b0000_0010_1000; // 028
      8'd29: out = 12'b0000_0010_1001; // 029

      8'd30: out = 12'b0000_0011_0000; // 030
      8'd31: out = 12'b0000_0011_0001; // 031
      8'd32: out = 12'b0000_0011_0010; // 032
      8'd33: out = 12'b0000_0011_0011; // 033
      8'd34: out = 12'b0000_0011_0100; // 034
      8'd35: out = 12'b0000_0011_0101; // 035
      8'd36: out = 12'b0000_0011_0110; // 036
      8'd37: out = 12'b0000_0011_0111; // 037
      8'd38: out = 12'b0000_0011_1000; // 038
      8'd39: out = 12'b0000_0011_1001; // 039
  
      8'd40: out = 12'b0000_0100_0000; // 040
      8'd41: out = 12'b0000_0100_0001; // 041
      8'd42: out = 12'b0000_0100_0010; // 042
      8'd43: out = 12'b0000_0100_0011; // 043
      8'd44: out = 12'b0000_0100_0100; // 044
      8'd45: out = 12'b0000_0100_0101; // 045
      8'd46: out = 12'b0000_0100_0110; // 046
      8'd47: out = 12'b0000_0100_0111; // 047
      8'd48: out = 12'b0000_0100_1000; // 048
      8'd49: out = 12'b0000_0100_1001; // 049

      8'd50: out = 12'b0000_0101_0000; // 050
      8'd51: out = 12'b0000_0101_0001; // 051
      8'd52: out = 12'b0000_0101_0010; // 052
      8'd53: out = 12'b0000_0101_0011; // 053
      8'd54: out = 12'b0000_0101_0100; // 054
      8'd55: out = 12'b0000_0101_0101; // 055
      8'd56: out = 12'b0000_0101_0110; // 056
      8'd57: out = 12'b0000_0101_0111; // 057
      8'd58: out = 12'b0000_0101_1000; // 058
      8'd59: out = 12'b0000_0101_1001; // 059

      8'd60: out = 12'b0000_0110_0000; // 060
      8'd61: out = 12'b0000_0110_0001; // 061
      8'd62: out = 12'b0000_0110_0010; // 062
      8'd63: out = 12'b0000_0110_0011; // 063
      8'd64: out = 12'b0000_0110_0100; // 064
      8'd65: out = 12'b0000_0110_0101; // 065
      8'd66: out = 12'b0000_0110_0110; // 066
      8'd67: out = 12'b0000_0110_0111; // 067
      8'd68: out = 12'b0000_0110_1000; // 068
      8'd69: out = 12'b0000_0110_1001; // 069

      8'd70: out = 12'b0000_0111_0000; // 070
      8'd71: out = 12'b0000_0111_0001; // 071
      8'd72: out = 12'b0000_0111_0010; // 072
      8'd73: out = 12'b0000_0111_0011; // 073
      8'd74: out = 12'b0000_0111_0100; // 074
      8'd75: out = 12'b0000_0111_0101; // 075
      8'd76: out = 12'b0000_0111_0110; // 076
      8'd77: out = 12'b0000_0111_0111; // 077
      8'd78: out = 12'b0000_0111_1000; // 078
      8'd79: out = 12'b0000_0111_1001; // 079

      8'd80: out = 12'b0000_1000_0000; // 080
      8'd81: out = 12'b0000_1000_0001; // 081
      8'd82: out = 12'b0000_1000_0010; // 082
      8'd83: out = 12'b0000_1000_0011; // 083
      8'd84: out = 12'b0000_1000_0100; // 084
      8'd85: out = 12'b0000_1000_0101; // 085
      8'd86: out = 12'b0000_1000_0110; // 086
      8'd87: out = 12'b0000_1000_0111; // 087
      8'd88: out = 12'b0000_1000_1000; // 088
      8'd89: out = 12'b0000_1000_1001; // 089

      8'd90: out = 12'b0000_1001_0000; // 090
      8'd91: out = 12'b0000_1001_0001; // 091
      8'd92: out = 12'b0000_1001_0010; // 092
      8'd93: out = 12'b0000_1001_0011; // 093
      8'd94: out = 12'b0000_1001_0100; // 094
      8'd95: out = 12'b0000_1001_0101; // 095
      8'd96: out = 12'b0000_1001_0110; // 096
      8'd97: out = 12'b0000_1001_0111; // 097
      8'd98: out = 12'b0000_1001_1000; // 098
      8'd99: out = 12'b0000_1001_1001; // 099

      8'd100: out = 12'b0001_0000_0000; // 100
      8'd101: out = 12'b0001_0000_0001; // 101
      8'd102: out = 12'b0001_0000_0010; // 102
      8'd103: out = 12'b0001_0000_0011; // 103
      8'd104: out = 12'b0001_0000_0100; // 104
      8'd105: out = 12'b0001_0000_0101; // 105
      8'd106: out = 12'b0001_0000_0110; // 106
      8'd107: out = 12'b0001_0000_0111; // 107
      8'd108: out = 12'b0001_0000_1000; // 108
      8'd109: out = 12'b0001_0000_1001; // 109

      8'd110: out = 12'b0001_0001_0000; // 110
      8'd111: out = 12'b0001_0001_0001; // 111
      8'd112: out = 12'b0001_0001_0010; // 112
      8'd113: out = 12'b0001_0001_0011; // 113
      8'd114: out = 12'b0001_0001_0100; // 114
      8'd115: out = 12'b0001_0001_0101; // 115
      8'd116: out = 12'b0001_0001_0110; // 116
      8'd117: out = 12'b0001_0001_0111; // 117
      8'd118: out = 12'b0001_0001_1000; // 118
      8'd119: out = 12'b0001_0001_1001; // 119

      8'd120: out = 12'b0001_0010_0000; // 120
      8'd121: out = 12'b0001_0010_0001; // 121
      8'd122: out = 12'b0001_0010_0010; // 122
      8'd123: out = 12'b0001_0010_0011; // 123
      8'd124: out = 12'b0001_0010_0100; // 124
      8'd125: out = 12'b0001_0010_0101; // 125
      8'd126: out = 12'b0001_0010_0110; // 126
      8'd127: out = 12'b0001_0010_0111; // 127
      8'd128: out = 12'b0001_0010_1000; // 128
      8'd129: out = 12'b0001_0010_1001; // 129

      8'd130: out = 12'b0001_0011_0000; // 130
      8'd131: out = 12'b0001_0011_0001; // 131
      8'd132: out = 12'b0001_0011_0010; // 132
      8'd133: out = 12'b0001_0011_0011; // 133
      8'd134: out = 12'b0001_0011_0100; // 134
      8'd135: out = 12'b0001_0011_0101; // 135
      8'd136: out = 12'b0001_0011_0110; // 136
      8'd137: out = 12'b0001_0011_0111; // 137
      8'd138: out = 12'b0001_0011_1000; // 138
      8'd139: out = 12'b0001_0011_1001; // 139
  
      8'd140: out = 12'b0001_0100_0000; // 140
      8'd141: out = 12'b0001_0100_0001; // 141
      8'd142: out = 12'b0001_0100_0010; // 142
      8'd143: out = 12'b0001_0100_0011; // 143
      8'd144: out = 12'b0001_0100_0100; // 144
      8'd145: out = 12'b0001_0100_0101; // 145
      8'd146: out = 12'b0001_0100_0110; // 146
      8'd147: out = 12'b0001_0100_0111; // 147
      8'd148: out = 12'b0001_0100_1000; // 148
      8'd149: out = 12'b0001_0100_1001; // 149

      8'd150: out = 12'b0001_0101_0000; // 150
      8'd151: out = 12'b0001_0101_0001; // 151
      8'd152: out = 12'b0001_0101_0010; // 152
      8'd153: out = 12'b0001_0101_0011; // 153
      8'd154: out = 12'b0001_0101_0100; // 154
      8'd155: out = 12'b0001_0101_0101; // 155
      8'd156: out = 12'b0001_0101_0110; // 156
      8'd157: out = 12'b0001_0101_0111; // 157
      8'd158: out = 12'b0001_0101_1000; // 158
      8'd159: out = 12'b0001_0101_1001; // 159

      8'd160: out = 12'b0001_0110_0000; // 160
      8'd161: out = 12'b0001_0110_0001; // 161
      8'd162: out = 12'b0001_0110_0010; // 162
      8'd163: out = 12'b0001_0110_0011; // 163
      8'd164: out = 12'b0001_0110_0100; // 164
      8'd165: out = 12'b0001_0110_0101; // 165
      8'd166: out = 12'b0001_0110_0110; // 166
      8'd167: out = 12'b0001_0110_0111; // 167
      8'd168: out = 12'b0001_0110_1000; // 168
      8'd169: out = 12'b0001_0110_1001; // 169

      8'd170: out = 12'b0001_0111_0000; // 170
      8'd171: out = 12'b0001_0111_0001; // 171
      8'd172: out = 12'b0001_0111_0010; // 172
      8'd173: out = 12'b0001_0111_0011; // 173
      8'd174: out = 12'b0001_0111_0100; // 174
      8'd175: out = 12'b0001_0111_0101; // 175
      8'd176: out = 12'b0001_0111_0110; // 176
      8'd177: out = 12'b0001_0111_0111; // 177
      8'd178: out = 12'b0001_0111_1000; // 178
      8'd179: out = 12'b0001_0111_1001; // 179

      8'd180: out = 12'b0001_1000_0000; // 180
      8'd181: out = 12'b0001_1000_0001; // 181
      8'd182: out = 12'b0001_1000_0010; // 182
      8'd183: out = 12'b0001_1000_0011; // 183
      8'd184: out = 12'b0001_1000_0100; // 184
      8'd185: out = 12'b0001_1000_0101; // 185
      8'd186: out = 12'b0001_1000_0110; // 186
      8'd187: out = 12'b0001_1000_0111; // 187
      8'd188: out = 12'b0001_1000_1000; // 188
      8'd189: out = 12'b0001_1000_1001; // 189

      8'd190: out = 12'b0001_1001_0000; // 190
      8'd191: out = 12'b0001_1001_0001; // 191
      8'd192: out = 12'b0001_1001_0010; // 192
      8'd193: out = 12'b0001_1001_0011; // 193
      8'd194: out = 12'b0001_1001_0100; // 194
      8'd195: out = 12'b0001_1001_0101; // 195
      8'd196: out = 12'b0001_1001_0110; // 196
      8'd197: out = 12'b0001_1001_0111; // 197
      8'd198: out = 12'b0001_1001_1000; // 198
      8'd199: out = 12'b0001_1001_1001; // 199


      8'd200: out = 12'b0010_0000_0000; // 200
      8'd201: out = 12'b0010_0000_0001; // 201
      8'd202: out = 12'b0010_0000_0010; // 202
      8'd203: out = 12'b0010_0000_0011; // 203
      8'd204: out = 12'b0010_0000_0100; // 204
      8'd205: out = 12'b0010_0000_0101; // 205
      8'd206: out = 12'b0010_0000_0110; // 206
      8'd207: out = 12'b0010_0000_0111; // 207
      8'd208: out = 12'b0010_0000_1000; // 208
      8'd209: out = 12'b0010_0000_1001; // 209

      8'd210: out = 12'b0010_0001_0000; // 210
      8'd211: out = 12'b0010_0001_0001; // 211
      8'd212: out = 12'b0010_0001_0010; // 212
      8'd213: out = 12'b0010_0001_0011; // 213
      8'd214: out = 12'b0010_0001_0100; // 214
      8'd215: out = 12'b0010_0001_0101; // 215
      8'd216: out = 12'b0010_0001_0110; // 216
      8'd217: out = 12'b0010_0001_0111; // 217
      8'd218: out = 12'b0010_0001_1000; // 218
      8'd219: out = 12'b0010_0001_1001; // 219

      8'd220: out = 12'b0010_0010_0000; // 220
      8'd221: out = 12'b0010_0010_0001; // 221
      8'd222: out = 12'b0010_0010_0010; // 222
      8'd223: out = 12'b0010_0010_0011; // 223
      8'd224: out = 12'b0010_0010_0100; // 224
      8'd225: out = 12'b0010_0010_0101; // 225
      8'd226: out = 12'b0010_0010_0110; // 226
      8'd227: out = 12'b0010_0010_0111; // 227
      8'd228: out = 12'b0010_0010_1000; // 228
      8'd229: out = 12'b0010_0010_1001; // 229

      8'd230: out = 12'b0010_0011_0000; // 230
      8'd231: out = 12'b0010_0011_0001; // 231
      8'd232: out = 12'b0010_0011_0010; // 232
      8'd233: out = 12'b0010_0011_0011; // 233
      8'd234: out = 12'b0010_0011_0100; // 234
      8'd235: out = 12'b0010_0011_0101; // 235
      8'd236: out = 12'b0010_0011_0110; // 236
      8'd237: out = 12'b0010_0011_0111; // 237
      8'd238: out = 12'b0010_0011_1000; // 238
      8'd239: out = 12'b0010_0011_1001; // 239

      8'd240: out = 12'b0010_0100_0000; // 240
      8'd241: out = 12'b0010_0100_0001; // 241
      8'd242: out = 12'b0010_0100_0010; // 242
      8'd243: out = 12'b0010_0100_0011; // 243
      8'd244: out = 12'b0010_0100_0100; // 244
      8'd245: out = 12'b0010_0100_0101; // 245
      8'd246: out = 12'b0010_0100_0110; // 246
      8'd247: out = 12'b0010_0100_0111; // 247
      8'd248: out = 12'b0010_0100_1000; // 248
      8'd249: out = 12'b0010_0100_1001; // 249

      8'd250: out = 12'b0010_0101_0000; // 250
      8'd251: out = 12'b0010_0101_0001; // 251
      8'd252: out = 12'b0010_0101_0010; // 252
      8'd253: out = 12'b0010_0101_0011; // 253
      8'd254: out = 12'b0010_0101_0100; // 254
      8'd255: out = 12'b0010_0101_0101; // 255
      default: out = 12'b0000_0000_0000; // 000
    endcase
endmodule

/********************************************** DECIMAL DISPLAY ********************************************/

// Takes in a 4-bit binary string and converts it into an decimal output for the seven-segment display.

module binary_decoder(dec_digit, segments);
  input [3:0] dec_digit;
  reg [6:0] out;
  output [6:0] segments;

  assign segments = out;

  always @(*)
    case (dec_digit)
      4'd0: out = 7'b100_0000; // 0
      4'd1: out = 7'b111_1001; // 1
      4'd2: out = 7'b010_0100; // 2
      4'd3: out = 7'b011_0000; // 3
      4'd4: out = 7'b001_1001; // 4
      4'd5: out = 7'b001_0010; // 5
      4'd6: out = 7'b000_0010; // 6
      4'd7: out = 7'b111_1000; // 7
      4'd8: out = 7'b000_0000; // 8
      4'd9: out = 7'b001_1000; // 9
      default: out = 7'b111_1111; // All seven segments are "off"
    endcase
endmodule
