module stopwatch_top(

   input wire clk,
   input wire clr,
   input wire go,

   output wire [3:0] an,
   output wire [7:0] digit
);

   wire [3:0] d2, d1, d0;             // BCD coded time values
   wire [7:0] led0, led1, led2;       // decoded SSEG representations
   wire [7:0] fixed_point;            // manually insert decimal point for led1

   assign fixed_point = {1'b0, led1[6:0]};

   stopwatch counter
     (.clk(clk), .go(go), .clr(clr),
      .d2(d2), .d1(d1), .d0(d0));
   
   dec_to_sseg sseg_dig_0
        (.dec(d0), .dp(1'b1), .sseg(led0));
   
      dec_to_sseg sseg_dig_1
        (.dec(d1), .dp(1'b1), .sseg(led1));
   
      dec_to_sseg sseg_dig_2
        (.dec(d2), .dp(1'b1), .sseg(led2));

   // instantiate 7-segment decoder
   disp_mux disp_unit
     (.clk(clk), .reset(1'b0),
      .in3(8'b11111111), .in2(led2), .in1(fixed_point), .in0(led0),
      .an(an), .sseg(digit));

endmodule
