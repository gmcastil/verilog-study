module rotate
  #(
  parameter POWER = 23
  )
  (
   input wire       clk,
   input wire       reset,
   input wire       enable,
   input wire       clockwise,

   output reg [7:0] in0,
   output reg [7:0] in1,
   output reg [7:0] in2,
   output reg [7:0] in3
   );

   // constant declarations
   localparam DVSR = 2**POWER - 1;

   localparam LOW_PATTERN   = 8'b10100011;  // lower square of a SSEG digit
   localparam HIGH_PATTERN  = 8'b10011100;  // upper square of a SSEG digit
   localparam BLANK_PATTERN = 8'b11111111;  // blank SSEG digit

   // signal declarations
   wire [22:0]      timer_next;
   reg [22:0]       timer_reg;
   wire             timer_tick;  // true when time to switch positions

   reg [2:0]        count_next;  // square positions to mux and decode for output
   reg [2:0]        count_reg;

   // -- Next State Logic
   assign timer_next = (timer_reg == DVSR && enable) ? 23'b0 :
                       (enable) ? timer_reg + 1'b1 :
                       timer_reg;
   assign timer_tick = (timer_reg == DVSR) ? 1'b1 : 1'b0;

   always @(*) begin
     count_next = count_reg;
     if (enable) begin
        if (timer_tick == 1'b1) begin
           if (clockwise) begin
              count_next = count_reg + 1'b1;
           end else begin
              count_next = count_reg - 1'b1;
           end
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

        3'b000:
          begin
             in0 = LOW_PATTERN;
             in1 = BLANK_PATTERN;
             in2 = BLANK_PATTERN;
             in3 = BLANK_PATTERN;
          end
        3'b001:
          begin
             in0 = BLANK_PATTERN;
             in1 = LOW_PATTERN;
             in2 = BLANK_PATTERN;
             in3 = BLANK_PATTERN;
          end
        3'b010:
          begin
             in0 = BLANK_PATTERN;
             in1 = BLANK_PATTERN;
             in2 = LOW_PATTERN;
             in3 = BLANK_PATTERN;
          end
        3'b011:
          begin
             in0 = BLANK_PATTERN;
             in1 = BLANK_PATTERN;
             in2 = BLANK_PATTERN;
             in3 = LOW_PATTERN;
          end
        3'b100:
          begin
             in0 = BLANK_PATTERN;
             in1 = BLANK_PATTERN;
             in2 = BLANK_PATTERN;
             in3 = HIGH_PATTERN;
          end
        3'b101:
          begin
             in0 = BLANK_PATTERN;
             in1 = BLANK_PATTERN;
             in2 = HIGH_PATTERN;
             in3 = BLANK_PATTERN;
          end
        3'b110:
          begin
             in0 = BLANK_PATTERN;
             in1 = HIGH_PATTERN;
             in2 = BLANK_PATTERN;
             in3 = BLANK_PATTERN;
          end
        3'b111:
          begin
             in0 = HIGH_PATTERN;
             in1 = BLANK_PATTERN;
             in2 = BLANK_PATTERN;
             in3 = BLANK_PATTERN;
          end
        default:
          begin
             in0 = BLANK_PATTERN;
             in1 = BLANK_PATTERN;
             in2 = BLANK_PATTERN;
             in3 = BLANK_PATTERN;
          end

      endcase // case (count_reg)
   end // always @ (*)

endmodule // rotate
