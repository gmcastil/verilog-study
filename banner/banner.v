module banner (
               input wire clk,
               input wire reset,
               input wire enable,
               input wire dir,
               output reg [3:0] dig_0,
               output reg [3:0] dig_1,
               output reg [3:0] dig_2,
               output reg [3:0] dig_3
               );
