module sseg_top
  (
   input wire 	     clk,
   //input wire      reset,
   input wire [15:0] dec_digits,  // these are binary coded decimals
   output wire [3:0] an,
   output wire [7:0] digit
   );

   wire [7:0] 	     led0, led1, led2, led3;

   // instantiate four instances of the dec to 7-segment decoder with
   // no decimal points
   dec_to_sseg sseg_dig_0
     (.dec(dec_digits[3:0]), .dp(1'b1), .sseg(led0));

   dec_to_sseg sseg_dig_1
     (.dec(dec_digits[7:4]), .dp(1'b1), .sseg(led1));

   dec_to_sseg sseg_dig_2
     (.dec(dec_digits[11:8]), .dp(1'b1), .sseg(led2));

   dec_to_sseg sseg_dig_3
     (.dec(dec_digits[15:12]), .dp(1'b1), .sseg(led3));

   // instantiate 7-segment decoder
   disp_mux disp_unit
     (.clk(clk), .reset(1'b0),
      .in3(led3), .in2(led2), .in1(led1), .in0(led0),
      .an(an), .sseg(digit));
   
endmodule // sseg_top
