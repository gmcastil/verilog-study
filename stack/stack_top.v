module stack_top (
   input wire       clk,
   input wire       reset,
   input wire       push,
   input wire       pop,
   input wire [7:0] data_in,

   output wire [7:0] data_out,
   output wire       error_out
   );

   stack u_stack(
                 .clk       (clk),        /* input  */
                 .reset     (reset),      /* input  */
                 .push      (push),       /* input  */
                 .pop       (pop),        /* input  */
                 .data_in   (data_in),    /* input  */
                 .data_out  (data_out),   /* output */
                 .error     (error_out)   /* output */
                 );

endmodule
