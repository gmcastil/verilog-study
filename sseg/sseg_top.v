module sseg_top
  (
   input wire 	     clk,
   //input wire      reset,
   input wire [15:0] hex_digits,
   output wire [3:0] an,
   output wire [7:0] digit
   );

   wire [7:0] 	     led0, led1, led2, led3;

   // instantiate four instances of the hex to 7-segment decoder
   hex_to_sseg sseg_dig_0
     (.hex(hex_digits[3:0]), .dp(1'b0), .sseg(led0));

   hex_to_sseg sseg_dig_1
     (.hex(hex_digits[7:4]), .dp(1'b0), .sseg(led1));

   hex_to_sseg sseg_dig_2
     (.hex(hex_digits[11:8]), .dp(1'b0), .sseg(led2));

   hex_to_sseg sseg_dig_3
     (.hex(hex_digits[15:12]), .dp(1'b0), .sseg(led3));

   // instantiate 7-segment decoder
   disp_mux disp_unit
     (.clk(clk), .reset(1'b0),
      .in3(led3), .in2(led2), .in1(led1), .in0(led0),
      .an(an), .sseg(digit));
   
endmodule // sseg_top
