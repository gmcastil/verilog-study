/* verilator lint_off UNUSED */
module stack
  (
   input             clk,
   input             reset,
   input             push,
   input             pop,
   input [7:0]       data_in,

   output wire [7:0] data_out,
   output wire       error
   );

   // Note that the bottom of the stack is at the largest addres
   localparam BOTTOM_ADDR  = 4'b1111;

   // Signal declarations
   reg                    push_reg;
   reg                    pop_reg;

   reg [7:0]              register_file [15:0];
   reg [7:0]              data_reg;                  // incoming data
   reg                    error_reg;                 // stack under or overflow
   reg                    error_next;
   reg [7:0]              read_data_reg;             // store popped data

   reg                    push_enable;
   reg                    pop_enable;

   reg [3:0]              stack_ptr_reg;
   reg [3:0]              stack_ptr_next;

   // --- Next State Logic
   always @(*) begin
      if (push_reg) begin
            error_next <= 1'b0;
            push_enable <= 1'b1;
            pop_enable <= 1'b0;
            stack_ptr_next <= stack_ptr_reg - 4'b0001;  // decreasing addresses
      end else if (pop_reg) begin
         if (stack_ptr_reg == BOTTOM_ADDR) begin
            // Check for stack underflow condition
            error_next <= 1'b1;
            push_enable <= 1'b0;
            pop_enable <= 1'b0;
            stack_ptr_next <= stack_ptr_reg;
         end else begin
            error_next <= 1'b0;
            push_enable <= 1'b0;
            pop_enable <= 1'b1;
            stack_ptr_next <= stack_ptr_reg + 4'b0001;  // again, decreasing addresses
         end
      end else begin
         error_next <= error_reg;
         push_enable <= 1'b0;
         pop_enable <= 1'b0;
         stack_ptr_next <= stack_ptr_reg;
      end
   end

   // --- Output Logic
   assign error = error_reg;
   assign data_out = read_data_reg;

   // --- Sequential Logic
   always @(posedge clk) begin
      stack_ptr_reg <= stack_ptr_next;
      if (reset) begin
         read_data_reg <= 8'b0;
         error_reg <= 1'b0;
         stack_ptr_reg <= BOTTOM_ADDR;
      end else if (push_enable) begin
         register_file[stack_ptr_reg] <= data_reg;
      end else if (pop_enable) begin
         read_data_reg <= register_file[stack_ptr_reg + 1'b1];  // use previous address for pops
      end
   end

   // Register inputs to this module
   always @(posedge clk) begin
      push_reg <= push;
      pop_reg <= pop;
      data_reg <= data_in;
   end

endmodule // stack
