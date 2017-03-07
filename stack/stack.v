module stack
  #(
    parameter WIDTH = 8,
    parameter ADDR_WIDTH = 4
    )
   (
    input              clk,
    input              reset,
    input              push,
    input              pop,
    input [WIDTH-1:0]  data_in,

    output [WIDTH-1:0] data_out,
    output             full
    );

   localparam DEPTH = 2**ADDR_WIDTH;

   // signal declarations
   reg                 push_reg;
   reg                 pop_reg;

   reg [WIDTH-1:0]     register_file [DEPTH-1:0];
   reg [WIDTH-1:0]     data_reg;                  // incoming data
   reg                 full_reg;                  // stack is full
   reg                 full_next;
   reg [WIDTH-1:0]     read_data_reg;             // store popped data
   reg                 out_enable;                // this might not be needed

   reg [DEPTH-1:0]     stack_ptr_reg;
   reg [DEPTH-1:0]     stack_ptr_next;

   wire [DEPTH-1:0]    stack_bottom;
   wire [DEPTH-1:0]    stack_top;

   // --- Next State Logic

   // --- Output Logic
   always @(*) begin
      full = full_reg;
      data_out = read_data_reg;
   end

   // --- Sequential Logic
   always @(posedge clk) begin
      if (reset) begin
         read_data_reg <= {(WIDTH-1){1'b0}};


   end
