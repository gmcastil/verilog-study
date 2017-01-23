`timescale 1 ns/10 ps

module univ_bin_counter_tb ();

   // declaration
   localparam T=20;  // clock period
   reg clk;
   reg reset;
   reg syn_clear;
   reg load;
   reg en;
   reg up;
   reg [2:0] d;
   wire max_tick;
   wire min_tick;
   wire [2:0] q;

   // code under test
   univ_bin_counter #(.N(3)) uut
     (.clk(clk), .reset(reset), .syn_clear(syn_clear),
      .load(load), .en(en), .up(up), .d(d),
      .max_tick(max_tick), .min_tick(min_tick), .q(q));

   // 50 MHz clock
   always begin
      clk = 1'b1;
      #(T/2);
      clk = 1'b0;
      #(T/2);
   end

   // hold in reset for the first half cycle
   initial begin
      reset = 1'b1;
      #(T/2);
      reset = 1'b0;
   end

   // other stimulus
   initial begin
      // ========= initial input
      syn_clear = 1'b0;
      load = 1'b0;
      en = 1'b0;
      up = 1'b1;  // count up
      d = 3'b000;
      @(negedge reset);  // wait reset to to deassert
      @(negedge clk);    // wait one clock
      // ========= test load
      load = 1'b1;
      d = 3'b011;
      @(negedge clk);    // wait one clock
      load = 1'b0;
      repeat(2) @(negedge clk);
      // ========= test syn_clear
      syn_clear = 1'b1;
      @(negedge clk);
      syn_clear = 1'b0;
      // ========= test up counter
      en = 1'b1;
      up = 1'b1;
      repeat(10) @(negedge clk);
      en = 1'b0;  // pause
      repeat(2) @(negedge clk);
      en = 1'b1;
      repeat(2) @(negedge clk);
      // ========= test down counter
      up = 1'b0;
      repeat(10) @(negedge clk);
      // ========= wait statement
      // continue until q = 2
      wait(q == 2);
      @(negedge clk);
      up = 1'b1;
      // continue until min_tick becomes 1
      @(negedge clk);
      wait(min_tick);
      @(negedge clk);
      up = 1'b0;
      // ========= absolute delay
      #(4*T);               // wait for 80 ns
      en = 1'b0;            // pause
      #(4*T);               // wait for 80 ns
      // ========= stop simulation
      // return to interactive simulation mode
      $stop;
   end // initial begin
endmodule // univ_bin_counter_tb
