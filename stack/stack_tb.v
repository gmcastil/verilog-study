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
      for (i=0; i<=15; i=i+1) begin
         data_in = i[7:0];
         $display("Pushing value 0x%h to stack", data_in);
         pop = 1'b0;
         push = 1'b1;
         #T;
         pop = 1'b0;
         push = 1'b0;
         #T;
      end
      data_in = 8'b0;
      #(2*T);
      
      // Now try to trigger an overflow
      push = 1'b1;
      pop = 1'b0;
      #T;
      push = 1'b0;
      pop = 1'b0;
      #T;
      if (error) begin
        $display("Stack overflow detected correctly.");
      end else begin
        $display("Stack overflow occurred.");
      end

      // Now try to empty the stack and then generate an underflow afterwards
      $display("Testing pop behavior...");
      for (i=0; i<=15; i=i+1) begin
         pop = 1'b1;
         push = 1'b0;
         #T;
         pop = 1'b0;
         push = 1'b0;
         #T;
         $display("Popping value 0x%h from the stack", data_out);
      end

      // Now try to trigger an underflow
      $display("Testing stack underflow...");
      push = 1'b0;
      pop = 1'b1;
      #T;
      push = 1'b0;
      pop = 1'b0;
      #T;
      if (error) begin
        $display("Stack underflow detected correctly.");
      end else begin
        $display("Stack underflow occurred.");
      end
      
      // Reset the DUT
      reset = 1'b0;
      #(2*T);
      reset = 1'b1;
      pop = 1'b0;
      push = 1'b0;
      #(2*T);
      reset = 1'b0;
      #(2*T);

      // Now try a single push / pop operation 
      $display("Testing atomic push and pop operations...");
      data_in = 8'hFF;
      $display("Pushing value 0x%h to stack", data_in);
      pop = 1'b0;
      push = 1'b1;
      #T;
      pop = 1'b0;
      push = 1'b0;
      #T;
      pop = 1'b1;
      push = 1'b0;
      #T;
      pop = 1'b0;
      push = 1'b0;
      // #T;
      $display("Popping value 0x%h from the stack", data_out);
            
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
