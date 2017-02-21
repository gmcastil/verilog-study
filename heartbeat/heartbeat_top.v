module heartbeat_top(

   input wire clk,
   input wire resetn,

   output wire [3:0] an,
   output wire [7:0] digit
);

   wire [7:0]        dig_0;
   wire [7:0]        dig_1;
   wire [7:0]        dig_2;
   wire [7:0]        dig_3;

   heartbeat heartbeat_signal
     (.clk(clk), .resetn(resetn),
      .dig_0(dig_0), .dig_1(dig_1), .dig_2(dig_2), .dig_3(dig_3));

   // instantiate 7-segment decoder
   disp_mux disp_unit
     (.clk(clk), .reset(1'b0),
      .in3(dig_3), .in2(dig_2), .in1(dig_1), .in0(dig_0),
      .an(an), .sseg(digit));

endmodule
