`timescale 1ns/10ps

module stopwatch_tb ();

   reg        clk;
   reg        enable;
   reg        up;
   reg        reset;

   wire [15:0]  digits;

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
      up = 1'b1;
      // run for 100 cycles to the left
      #(98*T);
      // hold in reset for 1.5 clock cyles
      reset = 1'b1;
      #(3*T/2);
      reset = 1'b0;
      up = 1'b0;
      // run 100 cycles to the right
      #(100*T);
   end



   stopwatch
     #(
       /* parameters */                    .DVSR        (10),
                                           .N           (24)
       ) code_under_test(
                         /* input  */     .clk          (clk),
                         /* input  */     .reset        (reset),
                         /* input  */     .enable       (enable),
                         /* input  */     .up           (up),
                         /* output */     .digits       (digits)
                         );

endmodule
