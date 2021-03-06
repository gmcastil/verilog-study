module heartbeat
   #(
     parameter PULSE_COUNT_MAX = 33554432 - 1,
     parameter DURATION_MAX    = 7500000
     )
   (
    input  clk,
    input  reset,
    output reg [7:0] dig_0,
    output reg [7:0] dig_1,
    output reg [7:0] dig_2,
    output reg [7:0] dig_3
    );

   // -- signal declarations
   reg [24:0] pulse_count_reg;
   reg [24:0] pulse_count_next;
   reg [24:0] duration_reg; // may need to tweak this a bit
   reg [24:0] duration_next;
   reg [2:0]  stage_reg;
   reg [2:0]  stage_next;

   localparam STAGE_MAX = 3'b100;  // four distinct configs plus null at 0

   // -- next state logic
   always @(*) begin
      pulse_count_next = pulse_count_reg;
      duration_next = duration_reg;
      stage_next = stage_reg;
      if (pulse_count_reg == PULSE_COUNT_MAX) begin
         if (stage_reg == STAGE_MAX && duration_reg == DURATION_MAX) begin
            pulse_count_next = 20'd0;
            stage_next = 2'b00;
         end else begin
            if (duration_reg == DURATION_MAX) begin
               stage_next = stage_reg + 1'b1;
               duration_next = 17'd0;
            end else begin
               duration_next = duration_reg + 1'b1;
            end
         end
      end else begin
         pulse_count_next = pulse_count_reg + 1'b1;
      end
   end

   // -- sequential logic
   always @(posedge clk) begin
      if (reset) begin
         pulse_count_reg      <= 20'd0;
         duration_reg         <= 17'd0;
         stage_reg            <= 2'b00;
      end else begin
         pulse_count_reg     <= pulse_count_next;
         duration_reg        <= duration_next;
         stage_reg           <= stage_next;
      end
   end // always @ (posedge clk)

   // -- output logic
   always @(*) begin

      case (stage_reg)

         3'b001:
            begin
               dig_0  = 8'b1111_1111;
               dig_1  = 8'b1100_1111;
               dig_2  = 8'b1111_1001;
               dig_3  = 8'b1111_1111;
            end

         3'b010:
            begin
               dig_0  = 8'b1111_1111;
               dig_1  = 8'b1111_1001;
               dig_2  = 8'b1100_1111;
               dig_3  = 8'b1111_1111;
            end

         3'b011:
            begin
               dig_0  = 8'b1100_1111;
               dig_1  = 8'b1111_1111;
               dig_2  = 8'b1111_1111;
               dig_3  = 8'b1111_1001;
            end

         3'b100:
            begin
               dig_0  = 8'b1111_1001;
               dig_1  = 8'b1111_1111;
               dig_2  = 8'b1111_1111;
               dig_3  = 8'b1100_1111;
            end

         default:
            begin
               dig_0  = 8'b1111_1111;
               dig_1  = 8'b1111_1111;
               dig_2  = 8'b1111_1111;
               dig_3  = 8'b1111_1111;
            end
      endcase
   end

endmodule
