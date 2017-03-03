`timescale 1ns/10ps

module banner_tb ();

   reg        clk;
   reg        reset;
   reg        enable;
   reg        dir;
   wire [3:0]  dig_0;
   wire [3:0]  dig_1;
   wire [3:0]  dig_2;
   wire [3:0]  dig_3;

   localparam T=10;  // 10ns clock period

   initial begin
      clk <= 1'b1;
      forever begin
         #(T/2) clk = ~clk;
      end
   end

   initial begin
      enable = 1'b1;
      // hold in reset for two periods
      reset = 1'b1;
      #(2*T);
      reset = 1'b0;
      dir = 1'b1;
      // run for 100 cycles to the left
      #(98*T);
      // hold in reset for 1.5 clock cyles
      reset = 1'b1;
      #(3*T/2);
      reset = 1'b0;
      dir = 1'b0;
      // run 100 cycles to the right
      #(100*T);
   end



   banner
     #(
       /* parameters */                    .POWER       (1)
       ) code_under_test(
                         /* input  */     .clk          (clk),
                         /* input  */     .reset        (reset),
                         /* input  */     .enable       (enable),
                         /* input  */     .dir          (dir),
                         /* output */     .bcd_0_reg    (dig_0),
                         /* output */     .bcd_1_reg    (dig_1),
                         /* output */     .bcd_2_reg    (dig_2),
                         /* output */     .bcd_3_reg    (dig_3)
                         );

endmodule
