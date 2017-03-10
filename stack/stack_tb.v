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
      clk <= 1'b1;
      forever begin
         #(T/2) clk = ~clk;
      end
   end

   initial begin
      reset = 1'b0;
      #(2*T);
      reset = 1'b1;
      pop = 1'b0;
      push = 1'b0;
      #(2*T);
      for (i=15; i<=0; i--) begin
      reset = 1'b0;
      data_in = 8'b10101010;
      pop = 1'b0;
      push = 1'b1;
      #T;
      pop = 1'b0;
      push = 1'b0;
      #(2*T);
      pop = 1'b1;
      push = 1'b0;
      #T;
      pop = 1'b0;
      push = 1'b0;
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
