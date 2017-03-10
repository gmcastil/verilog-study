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

   int i;

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
      $display("Testing push behavior...");
      for (i=0; i<=8; i++) begin
         data_in = 8'b10101010;
         pop = 1'b0;
         push = 1'b1;
         #T;
         data_in = 8'b01010101;
         pop = 1'b0;
         push = 1'b1;
         #(2*T);
      end
      $display("Testing stack overflow...");
      data_in = 8'b11111111;
      pop = 1'b0;
      push = 1'b1;
      #(2*T);
      // Now try to empty the stack and then generate an underflow afterwards
      $display("Testing pop behavior...");
      for (i=0; i<=16; i++) begin
         pop = 1'b1;
         push = 1'b0;
         #T;
         pop = 1'b0;
         push = 1'b0;
         #(2*T);
      end
      $display("Testing stack underflow...");
      pop = 1'b1;
      push = 1'b0;
      #(2*T);
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
