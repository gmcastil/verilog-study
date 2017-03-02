`timescale 1ns/10ps

module banner_tb ();

   wire       clk;
   wire       reset;
   wire       enable;
   wire       dir;
   reg [3:0]  dig_0;
   reg [3:0]  dig_1;
   reg [3:0]  dig_2;
   reg [3:0]  dig_3;

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
      #(100*T);
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
       /* parameters */
       ) code_under_test(
                         /* input  */     .clk      (clk),
                         /* input  */     .reset    (reset),
                         /* input  */     .enable   (enable),
                         /* input  */     .dir      (dir),
                         /* output */     .dig_0    (dig_0),
                         /* output */     .dig_1    (dig_1),
                         /* output */     .dig_2    (dig_2),
                         /* output */     .dig_3    (dig_3)
                         );

endmodule
