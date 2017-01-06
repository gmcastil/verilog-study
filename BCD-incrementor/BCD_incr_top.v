module BCD_incr_top
  (
   input wire        clk,
   input wire        incr,
   input wire        reset,
   output wire [3:0] an,
   output wire [7:0] digit
   );

   wire [15:0]        data;
   
   BCD_incrementor incr_value 
     (.incr(incr), .reset(reset), .data(data));

   sseg_top display
     (.clk(clk), .hex_digits(data), .an(an), .digit(digit));

endmodule // BCD_incr_top
