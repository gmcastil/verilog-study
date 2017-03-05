module stopwatch
  #(
    parameter POWER = 23
    )(
      input wire         clk,
      input wire         enable,
      input wire         up,
      input wire         reset,
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
   wire [23:0]        timer_tick;
   reg  [3:0]         bcd_0_next;
   reg  [3:0]         bcd_1_next;
   reg  [3:0]         bcd_2_next;
   reg  [3:0]         bcd_3_next;

   reg [23:0]         timer_reg;
   reg [3:0]          bcd_0_reg;
   reg [3:0]          bcd_1_reg;
   reg [3:0]          bcd_2_reg;
   reg [3:0]          bcd_3_reg;

   // next state logic

   // work out the 100ms tick that everything else is driven by
   assign timer_next = (timer_reg == DVSR && enable) ? {POWER{1'b0}} :
                       (enable) ? timer_reg + 1'b1 :
                       timer_reg;
   assign timer_tick = (timer_reg == DVSR) ? 1'b1 : 1'b0;

   always @(*) begin
      if (enable && timer_tick) begin
         if (up) begin  // for counting upwards
            if (bcd_0_reg == NINE) begin
               bcd_0_next = ZERO;
               if (bcd_1_reg == NINE) begin
                  bcd_1_next = ZERO;
                  if (bcd_2_reg == NINE) begin
                     bcd_2_next = ZERO;
                     if (bcd_3_reg == NINE) begin
                        bcd_3_next = ZERO;
                     end else begin
                        bcd_3_next = bcd_3_reg + 1'b1;
                     end
                  end else begin
                     bcd_2_next = bcd_2_reg + 1'b1;
                  end
               end else begin
                  bcd_1_next = bcd_1_reg + 1'b1;
               end
            end else begin
               bcd_0_next = bcd_0_reg +1'b1;
            end
         end else begin // now we're counting downwards
            if (bcd_0_reg == ZERO) begin
               bcd_0_next = NINE;
               if (bcd_1_reg == ZERO) begin
                  bcd_1_next = NINE;
                  if (bcd_2_reg == ZERO) begin
                     bcd_2_next = NINE;
                     if (bcd_3_reg == ZERO) begin
                        bcd_3_next = NINE;
                     end else begin
                        bcd_3_next = bcd_3_reg - 1'b1;
                     end
                  end else begin
                     bcd_2_next = bcd_2_reg - 1'b1;
                  end
               end else begin // if (bcd_1_reg == ZERO)
                  bcd_1_next = bcd_1_reg - 1'b1;
               end // else: !if(bcd_1_reg == ZERO)
            end else begin // if (bcd_0_reg == ZERO)
               bcd_0_next = bcd_0_reg - 1'b1;
            end // else: !if(bcd_0_reg == ZERO)
         end // else: !if(up)
      end // if (enable && timer_tick)
   end // always @ (*)

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
   assign digits = {bcd_3_reg, bcd_2_reg, bcd_1_reg, bcd_0_reg};

endmodule // stopwatch
