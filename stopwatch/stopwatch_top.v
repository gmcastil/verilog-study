module stopwatch_top
     (
      input wire clk,
      input wire enable,
      input wire up,
      input wire reset,
      output wire [3:0] an,
      output wire [7:0] digit
      );

   // signal declaration
   wire [3:0]           bcd_0;
   wire [3:0]           bcd_1;
   wire [3:0]           bcd_2;
   wire [3:0]           bcd_3;

   wire [7:0]           in0;
   wire [7:0]           in1;
   wire [7:0]           in2;
   wire [7:0]           in3;

   stopwatch u_stopwatch
     (
      /* input  */     .clk              (clk),
      /* input  */     .enable           (enable),
      /* input  */     .up               (up),
      /* input  */     .reset            (reset),
      /* output */     .digits           ({bcd_3, bcd_2, bcd_1, bcd_0})
      );

   bcd_decoder dig_0
     (
      /* input  */     .bcd_digit        (bcd_0),
      /* input  */     .dp               (1'b1),
      /* output */     .sseg_digit       (in0)
      );

   bcd_decoder dig_1
     (
      /* input  */     .bcd_digit        (bcd_1),
      /* input  */     .dp               (1'b0),
      /* output */     .sseg_digit       (in1)
      );

   bcd_decoder dig_2
     (
      /* input  */     .bcd_digit        (bcd_2),
      /* input  */     .dp               (1'b1),
      /* output */     .sseg_digit       (in2)
      );

   bcd_decoder dig_3
     (
      /* input  */     .bcd_digit        (bcd_3),
      /* input  */     .dp               (1'b0),
      /* output */     .sseg_digit       (in3)
      );

   // mux them all together and route to the SSEG display
   disp_mux disp_unit
     (
      /* input */     .clk               (clk),
      /* input */     .reset             (reset),
      /* input */     .in3               (in3),
      /* input */     .in2               (in2),
      /* input */     .in1               (in1),
      /* input */     .in0               (in0),
      /* output */    .an                (an),
      /* output */    .sseg              (digit)
     );

endmodule
