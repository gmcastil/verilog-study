module heartbeat
   #(
     parameter PULSE_COUNT_MAX = 1.389E6, // this gets us about 72Hz
     parameter HEARTBEAT_COUNT_MAX = 2**18
     )
   (
    input  clk,
    input  resetn,
    output reg [7:0] dig_0,
    output reg [7:0] dig_1,
    output reg [7:0] dig_2,
    output reg [7:0] dig_3
    );

   // -- signal declarations
   reg [20:0] pulse_count_reg;
   reg [20:0] pulse_count_next;
   reg [17:0] heartbeat_count_reg; // may need to tweak this a bit
   reg [17:0] heartbeat_count_next;
   reg [2:0]  stage_reg;
   reg [2:0]  stage_next;

   localparam STAGE_MAX = 4;  // four distinct configs plus null at 0

   // -- next state logic
   always @(*) begin
      if (pulse_count_reg == PULSE_COUNT_MAX) begin // beat!
         if (heartbeat_count_reg == HEARTBEAT_COUNT_MAX) begin // update visual!
            if (stage_reg == STAGE_MAX) begin // next bars or none
               stage_next            = 0;
               pulse_count_next      = 0;
               heartbeat_count_next  = 0;
            end else begin
               stage_next            = stage_reg + 1;
               pulse_count_next      = pulse_count_reg + 1;
               heartbeat_count_next  = heartbeat_count_reg + 1;
            end
         end else begin
            heartbeat_count_next = heartbeat_count_reg + 1;
         end
      end else begin
         pulse_count_next = pulse_count_reg + 1;
      end
   end // always @ (*)

   // -- sequential logic
   always @(posedge clk) begin
      if (!resetn) begin
         pulse_count_reg     <= 0;
         heartbeat_count_reg <= 0;
         stage_reg           <= 0;
      end else begin
         pulse_count_reg     <= pulse_count_next;
         heartbeat_count_reg <= heartbeat_count_next;
         stage_reg           <= stage_next;
      end
   end // always @ (posedge clk)

   // -- output logic
   always @(*) begin

      case (stage_reg)

         3'b000:
            begin
               dig_0  = 8'b1111_1111;
               dig_1  = 8'b1111_1111;
               dig_2  = 8'b1111_1111;
               dig_3  = 8'b1111_1111;
            end

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

         default: begin end
      endcase
   end

endmodule
