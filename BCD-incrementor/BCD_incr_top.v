module BCD_incr_top
  (
   input wire        clk,
   input wire        incr,
   input wire        reset,
   output wire [3:0] an,
   output wire [7:0] digit
   );

   wire [15:0]        data;
   
   incr_value BCD_incrementor
     (.incr(incr), .reset(reset), .data(data));

   display sseg_top
     (.clk(clk), .hex_digits(data), .an(an), .digit(digit));

endmodule // BCD_incr_top
