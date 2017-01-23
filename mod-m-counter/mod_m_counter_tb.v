`timescale 1 ns/10 ps

module mod_m_counter_tb ();

   localparam T=20;
   reg reset;
   reg clk;
   wire [3:0] q;
   wire      max_tick;

   // define code under test
   mod_m_counter uut
     (.clk(clk), .reset(reset), .q(q), .max_tick(max_tick));

   always begin
      clk = 1'b1;
      #(T/2);
      clk = 1'b0;
      #(T/2);
   end

   // hold in reset for the first half clock
   initial begin
      reset = 1'b1;
      #(T/2);
      reset = 1'b0;
   end

   initial begin
      #(20*T);
      reset = 1'b1;
      #(4*T);
      reset = 1'b0;
      #(20*T);
   end

endmodule
