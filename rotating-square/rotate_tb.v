`timescale 1ns/10ps

module rotate_tb ();

   reg clk_100m;
   reg reset;
   reg enable;
   reg clockwise;

   localparam T=10;  // 10ns clock period

   initial begin
      clk_100m <= 1'b1;
      forever begin
         #(T/2) clk_100m = ~clk_100m;
      end
   end

   rotate
     #(
       .POWER       (1)
       ) code_under_test(
         /* input  */    .clk          (clk_100m),
         /* input  */    .reset        (reset),
         /* input  */    .enable       (enable),
         /* input  */    .clockwise    (clockwise),
         /* output */    .sseg_pattern (),
         /* output */    .an           ()
                         );

   initial begin
      enable = 1'b1;
      clockwise = 1'b1;
      // hold in reset for 2 clock periods
      reset = 1'b1;
      #(2*T);
      reset = 1'b0;
      // run for 100 cycles counting clockwise
      #(100*T);
      // hold in reset for 1.5 clock periods
      reset = 1'b1;
      #(3*T/2);
      reset = 1'b0;
      // now try the disable signal for 10 clock cycles
      enable = 1'b0;
      #(100*T);
      enable = 1'b1;
      clockwise = 1'b0;
      // hold in reset for 2 clock periods
      reset = 1'b1;
      #(2*T);
      reset = 1'b0;
      // run for 100 cycles counting counterclockwise
      #(100*T);
      reset = 1'b1;
   end // initial begin

endmodule // rotate_tb
