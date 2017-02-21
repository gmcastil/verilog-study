module rotate
  #(
    parameter POWER = 8
    )
  (
   input wire       clk,
   input wire       reset,
   input wire       enable,
   input wire       clockwise,
   output reg [7:0] sseg_pattern,
   output reg [3:0] an
   );

   // constant declarations
   localparam DVSR = 10**POWER;  // default is a 100MHz clock with 1s transition
   localparam LOW_PATTERN  = 8'b1010_0001;  // lower square of a SSEG digit
   localparam HIGH_PATTERN = 8'b1101_1110;  // upper square of a SSEG digit

   // signal declarations
   wire [23:0]       timer_next;
   reg [23:0]        timer_reg;
   wire              timer_tick;

   reg [2:0]         count_next;
   reg [2:0]         count_reg;

   // -- Next State Logic

   // generate the following:
   //   - tick every second for managing state transitions
   //   - pause everything when not enabled
   assign timer_next = (!enable) ? timer_reg :
                       (enable && timer_reg == DVSR) ? 0 :
                       timer_reg + 1;

   assign timer_tick = (enable && timer_reg == DVSR) ? 1'b1 :
                       1'b0;

   always @(*) begin
      // default is to keep the same unless there is a tick or the system
      // is not enabled
      count_next = count_reg;
      if (!enable) begin
         count_next = count_reg;
      end else if (timer_tick) begin
         if (clockwise) begin
            count_next = count_reg + 1;
         end else begin
            count_next = count_reg - 1;
         end
      end
   end // always @ (*)

   // -- Sequential Logic
   always @(posedge clk) begin
      if (reset) begin
         count_reg <= 0;
         timer_reg <= 0;
      end else begin
         count_reg <= count_next;
         timer_reg <= timer_next;
      end
   end // always @ (posedge clk)

   // -- Output Logic
   always @(*) begin

      case (count_reg)

        0:
          begin
             sseg_pattern = LOW_PATTERN;
             an = 4'b1110;
          end
        1:
          begin
             sseg_pattern = LOW_PATTERN;
             an = 4'b1101;
          end
        2:
          begin
             sseg_pattern = LOW_PATTERN;
             an = 4'b1011;
          end
        3:
          begin
             sseg_pattern = LOW_PATTERN;
             an = 4'b0111;
          end
        4:
          begin
             sseg_pattern = HIGH_PATTERN;
             an = 4'b0111;
          end
        5:
          begin
             sseg_pattern = HIGH_PATTERN;
             an = 4'b1011;
          end
        6:
          begin
             sseg_pattern = HIGH_PATTERN;
             an = 4'b1101;
          end
        7:
          begin
             sseg_pattern = HIGH_PATTERN;
             an = 4'b1110;
          end
      endcase // case (count_reg)
   end // always @ (*)

endmodule // rotate
