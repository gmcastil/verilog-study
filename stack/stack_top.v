module stack_top (
   input wire       clk,
   input wire       reset,
   input wire       push_sw,
   input wire       pop_sw,
   input wire [7:0] data_in,

   output wire [7:0] data_out,
   output wire       error_out
   );

   stack u_stack(
                 .clk       (clk),        /* input  */
                 .reset     (reset),      /* input  */
                 .push      (push_db),    /* input  */
                 .pop       (pop_db),     /* input  */
                 .data_in   (data_in),    /* input  */
                 .data_out  (data_out),   /* output */
                 .error     (error_out)   /* output */
                 );

  db_fsm u_debounced_push(
                          .clk    (clk),        /* input  */
                          .reset  (reset),      /* input  */
                          .sw     (push_sw),    /* input  */
                          .db     (push_db)     /* output */
                          );

   db_fsm u_debounced_pop(
                         .clk    (clk),         /* input  */
                         .reset  (reset),       /* input  */
                         .sw     (pop_sw),      /* input  */
                         .db     (pop_db)       /* output */
                         );


endmodule
