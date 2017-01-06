`timescale 1 ns/10 ps

module BCD_incr_tb ();

   reg clk;
   reg incr;
   reg reset;

   wire [3:0] an;
   wire [7:0] digit;

   BCD_incr_top code_under_test
     (.clk(clk), .incr(incr), .reset(reset), .an(an), .digit(digit));

   initial
     begin
        clk = 1'b0;
        incr = 1'b0;
        reset = 1'b0;
   end

   always
     #5 clk = !clk;

   always
     #5 incr = !incr;

endmodule // BCD_incr_tb

        

   
