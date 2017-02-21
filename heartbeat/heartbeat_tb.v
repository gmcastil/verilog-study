`timescale 1ns/10ps             // unit_time / precision

module heartbeat_tb ();

   reg clk;
   reg resetn;
   reg [7:0] dig_0;
   reg [7:0] dig_1;
   reg [7:0] dig_2;
   reg [7:0] dig_3;

   localparam T = 10;           // 10ns clock period

   initial begin
      clk <= 1'b1;
      forever begin
         #(T/2) clk  = ~clk;
      end
   end

   heartbeat
      #(
        .PULSE_COUNT_MAX (1.389E6),
        .HEARTBEAT_COUNT_MAX (2**18)
        ) code_under_test(
                          .clk (clk),
                          .resetn (resetn),
                          .dig_0 (dig_0),
                          .dig_1 (dig_1),
                          .dig_2 (dig_2),
                          .dig_3 (dig_3)
                          );
endmodule // heartbeat_tb
