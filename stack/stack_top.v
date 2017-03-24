module stack_top (
   input wire       clk,
   input wire       reset,
   input wire       push_sw,
   input wire       pop_sw,
   input wire [7:0] data_in,

   output wire [7:0] data_out,
   output wire       error_out
   );

   wire [4:0] debug_stack_ptr_reg;
   wire [4:0] debug_stack_ptr_next;
   wire       debug_push_reg;
   wire       debug_pop_reg;

   stack u_stack(
                 .clk                  (clk),        /* input  */
                 .reset                (reset),      /* input  */
                 .push                 (push_db),    /* input  */
                 .pop                  (pop_db),     /* input  */
                 .data_in              (data_in),    /* input  */
                 .data_out             (data_out),   /* output */
                 .error                (error_out),  /* output */

                 .debug_stack_ptr_reg  (debug_stack_ptr_reg),
                 .debug_stack_ptr_next (debug_stack_ptr_next),
                 .debug_push_reg       (debug_push_reg),
                 .debug_pop_reg        (debug_pop_reg)
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

   ila_0 // #(
     // )
     ila_0_uc (
                  .clk       (clk),
                  .probe0    (debug_stack_ptr_reg),
                  .probe1    (debug_stack_ptr_next),
                  .probe2    (debug_push_reg),
                  .probe3    (debug_pop_reg)
                  ) /* synthesis syn_noprune=1 syn_preserve=1 syn_keep=1 */;

endmodule
