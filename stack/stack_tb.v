`timescale 1ns/10ps

module stack_tb ();

   reg       clk;
   reg       reset;
   reg       push;
   reg       pop;
   reg [7:0] data_in;

   wire [7:0] data_out;
   wire       error;

   localparam T = 10;  // 10ns clock period

   initial begin
      clk = 1'b1;
      forever begin
         #(T/2)
         clk = ~clk;
      end
   end

   integer i;

   initial begin
      reset = 1'b0;
      #(2*T);
      reset = 1'b1;
      pop = 1'b0;
      push = 1'b0;
      #(2*T);
      // Fill up the stack and make sure to try to generate an overflow and
      // make sure that it correctly identifies stack overflows.
      reset = 1'b0;
      #T;
      $display("Testing push behavior...");
      for (i=0; i<=8; i=i+1) begin
         $display("Pushing to stack location %d", i);
         data_in = 8'b10101010;
         push = 1'b1;
         #T;
         push = 1'b0;
         #T;
         data_in = 8'b01010101;
         push = 1'b1;
         #T;
         push = 1'b0;
         #T;
      end
      #(2*T);
      // Now try to empty the stack and then generate an underflow afterwards
      $display("Testing pop behavior...");
      for (i=0; i<=16; i=i+1) begin
         pop = 1'b1;
         push = 1'b0;
         $display("Popping position %0d...value is...%h", i, data_out);
         #T;
         pop = 1'b0;
         push = 1'b0;
         #T;
      end
//      $display("Testing stack underflow...");
//      pop = 1'b1;
//      push = 1'b0;
//      #(2*T);
 end

   stack
     #(
       /* parameters */
       ) code_under_test
       (
        .clk         (clk),       /* input  */
        .reset       (reset),     /* input  */
        .push        (push),      /* input  */
        .pop         (pop),       /* input  */
        .data_in     (data_in),   /* input  */
        .data_out    (data_out),  /* output */
        .error       (error)      /* outupt */
        );

endmodule // stack_tb
