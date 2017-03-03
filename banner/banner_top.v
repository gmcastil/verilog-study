module banner_top
  #(
    )(
      input wire clk,
      input wire reset,
      input wire enable,
      input wire dir,
      output reg [3:0] an,
      output reg [7:0] digit
      );

   // signal declaration
   reg [3:0]           bcd_0;
   reg [3:0]           bcd_1;
   reg [3:0]           bcd_2;
   reg [3:0]           bcd_3;

   reg [7:0]           in0;
   reg [7:0]           in1;
   reg [7:0]           in2;
   reg [7:0]           in3;

   // instantiate the banner module
   banner u_banner
     (
      /* input  */     .clk         (clk),
      /* input  */     .reset       (reset),
      /* input  */     .enable      (enable),
      /* input  */     .dir         (dir),
      /* output */     .bcd_0_reg   (bcd_0),
      /* output */     .bcd_1_reg   (bcd_1),
      /* output */     .bcd_2_reg   (bcd_2),
      /* output */     .bcd_3_reg   (bcd_3)
      );

   // instantiate four copies of the BCD to SSEG decoder
   bcd_decoder dig_0
     (
      .bcd_digit    (bcd_0),
      .dp           (1'b1),
      .sseg_digit   (in0)
                     );

   bcd_decoder dig_1
     (
      .bcd_digit    (bcd_1),
      .dp           (1'b1),
      .sseg_digit   (in1)
      );

   bcd_decoder dig_2
     (
      .bcd_digit    (bcd_2),
      .dp           (1'b1),
      .sseg_digit   (in2)
      );

   bcd_decoder dig_3
     (
      .bcd_digit    (bcd_3),
      .dp           (1'b1),
      .sseg_digit   (in3)
      );

   // mux them all together and route to the SSEG display
   disp_mux disp_unit(
      /* input */     .clk       (clk),
      /* input */     .reset     (reset),
      /* input */     .in3       (in3),
      /* input */     .in2       (in2),
      /* input */     .in1       (in1),
      /* input */     .in0       (in0),
      /* output */    .an        (an),
      /* output */    .sseg      (digit)
                      );

endmodule // banner_top
