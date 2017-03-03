module banner
  #(
    parameter POWER = 23
    )(
      input wire       clk,
      input wire       reset,
      input wire       enable,
      input wire       dir,
      output reg [3:0] bcd_0_reg,
      output reg [3:0] bcd_1_reg,
      output reg [3:0] bcd_2_reg,
      output reg [3:0] bcd_3_reg
      );

   // signal declaration
   localparam ZERO  = 4'b0000;
   localparam ONE   = 4'b0001;
   localparam TWO   = 4'b0010;
   localparam THREE = 4'b0011;
   localparam FOUR  = 4'b0100;
   localparam FIVE  = 4'b0101;
   localparam SIX   = 4'b0110;
   localparam SEVEN = 4'b0111;
   localparam EIGHT = 4'b1000;
   localparam NINE  = 4'b1001;

   localparam DVSR = 2**POWER - 1;

   reg [3:0]           bcd_0_next;
   reg [3:0]           bcd_1_next;
   reg [3:0]           bcd_2_next;
   reg [3:0]           bcd_3_next;

   wire [22:0]          timer_next;
   reg  [22:0]          timer_reg;
   wire                 timer_tick;

   // --- Next State Logic
   assign timer_next = (timer_reg == DVSR && enable) ? 23'b0 :
                       (enable) ? timer_reg + 1'b1 :
                       timer_reg;
   assign timer_tick = (timer_reg == DVSR) ? 1'b1 : 1'b0;

   always @(*) begin

      bcd_0_next = bcd_0_reg;
      bcd_1_next = bcd_1_reg;
      bcd_2_next = bcd_2_reg;
      bcd_3_next = bcd_3_reg;

      if (enable && timer_tick) begin
         if (dir) begin  // shift to the left

            bcd_3_next = bcd_2_reg;
            bcd_2_next = bcd_1_reg;
            bcd_1_next = bcd_0_reg;

            // use the leftmost digit to determine the next one
            case (bcd_0_reg)

              ZERO: begin
                 bcd_0_next = ONE;
              end

              ONE: begin
                 bcd_0_next = TWO;
              end

              TWO: begin
                 bcd_0_next = THREE;
              end

              THREE: begin
                 bcd_0_next = FOUR;
              end

              FOUR: begin
                 bcd_0_next = FIVE;
              end

              FIVE: begin
                 bcd_0_next = SIX;
              end

              SIX: begin
                 bcd_0_next = SEVEN;
              end

              SEVEN: begin
                 bcd_0_next = EIGHT;
              end

              EIGHT: begin
                 bcd_0_next = NINE;
              end

              NINE: begin
                 bcd_0_next = ZERO;
              end

              default: begin
              end
            endcase // case (bcd_1_reg)

         end else begin  // shifting to the right

            bcd_0_next = bcd_1_reg;
            bcd_1_next = bcd_2_reg;
            bcd_2_next = bcd_3_reg;

            // use rightmost digit to determine the next one
            case (bcd_3_reg)

              ZERO: begin
                 bcd_3_next = NINE;
              end

              ONE: begin
                 bcd_3_next = ZERO;
              end

              TWO: begin
                 bcd_3_next = ONE;
              end

              THREE: begin
                 bcd_3_next = TWO;
              end

              FOUR: begin
                 bcd_3_next = THREE;
              end

              FIVE: begin
                 bcd_3_next = FOUR;
              end

              SIX: begin
                 bcd_3_next = FIVE;
              end

              SEVEN: begin
                 bcd_3_next = SIX;
              end

              EIGHT: begin
                 bcd_3_next = SEVEN;
              end

              NINE: begin
                 bcd_3_next = EIGHT;
              end

              default: begin end

            endcase // case (bcd_3_reg)
         end // else: !if(dir)
      end // if (enable && timer_tick)
   end // always @ (*)

   // --- Sequential Logic
   always @(posedge clk) begin
      if (reset) begin
         bcd_0_reg <= THREE;
         bcd_1_reg <= TWO;
         bcd_2_reg <= ONE;
         bcd_3_reg <= ZERO;

         timer_reg <= 23'b0;
      end else begin
         bcd_0_reg <= bcd_0_next;
         bcd_1_reg <= bcd_1_next;
         bcd_2_reg <= bcd_2_next;
         bcd_3_reg <= bcd_3_next;

         timer_reg <= timer_next;
      end
   end

endmodule // banner
