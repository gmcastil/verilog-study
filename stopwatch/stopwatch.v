module stopwatch
  (
   input wire clk,
   input wire enable,
   input wire up,
   input wire reset,
   output wire [15:0] digits
   );

   localparam DVSR = 10000000;  // this produces a desired tick every 100ms

   localparam ZERO   = 4'b0000;
   localparam ONE    = 4'b0001;
   localparam TWO    = 4'b0010;
   localparam THREE  = 4'b0011;
   localparam FOUR   = 4'b0100;
   localparam FIVE   = 4'b0101;
   localparam SIX    = 4'b0110;
   localparam SEVEN  = 4'b0111;
   localparam EIGHT  = 4'b1000;
   localparam NINE   = 4'b1001;

   // signal declarations
   wire [23:0]        timer_next;
   wire [3:0]         bcd_0_next;
   wire [3:0]         bcd_1_next;
   wire [3:0]         bcd_2_next;
   wire [3:0]         bcd_3_next;

   reg [23:0]         timer_reg;
   reg [3:0]          bcd_0_reg;
   reg [3:0]          bcd_1_reg;
   reg [3:0]          bcd_2_reg;
   reg [3:0]          bcd_3_reg;

   // next state logic

   // sequential logic
   always @(posedge clk) begin
      if (reset) begin
         bcd_0_reg <= ZERO;
         bcd_1_reg <= ZERO;
         bcd_2_reg <= ZERO;
         bcd_3_reg <= ZERO;
         timer_reg <= ZERO;
      end else begin
         bcd_0_reg <= bcd_0_next;
         bcd_1_reg <= bcd_1_next;
         bcd_2_reg <= bcd_2_next;
         bcd_3_reg <= bcd_3_next;
         timer_reg <= timer_next;
      end // else: !if(reset)
   end // always @ (posedge clk)


   // output logic
