`timescale 1ns/10ps             // unit_time / precision

module heartbeat_tb ();

   reg clk;
   reg reset;
   wire [7:0] dig_0;
   wire [7:0] dig_1;
   wire [7:0] dig_2;
   wire [7:0] dig_3;

   localparam T=10;           // 10ns clock period

   initial begin
      clk <= 1'b1;
      forever begin
         #(T/2) clk  = ~clk;
      end
   end

   initial begin
      reset <= 1'b0;
      #(2*T)
      reset <= 1'b1;
      #(2*T)
      reset <= 1'b0;
   end

   heartbeat
      #(
        .PULSE_COUNT_MAX (32),
        .DURATION_MAX (2)
        ) code_under_test(
                          .clk (clk),
                          .reset (reset),
                          .dig_0 (dig_0),
                          .dig_1 (dig_1),
                          .dig_2 (dig_2),
                          .dig_3 (dig_3)
                          );
endmodule // heartbeat_tb
