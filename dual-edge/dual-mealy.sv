module dual_mealy
  (
   input wire clk,
   input wire reset,
   input wire in,
   input wire out
   );

   typedef enum logic [3:0]
                {
                 IDLE_LOW   = 4'b0001,
                 HIGH       = 4'b0010,
                 IDLE_HIGH  = 4'b0100,
                 LOW        = 4'b1000
                 } states;

   states next_state;
   states present_state;

   localparam IDLE_LOW_ID   = 0;
   localparam HIGH_ID       = 1;
   localparam IDLE_HIGH_ID  = 2;
   localparam LOW_ID        = 3;

   // --- Combinatorial State Movements
   always @(*) begin

      case (1'b1)

        present_state[IDLE_LOW_ID]: begin
           if (in == 1'b1) begin
              next_state  = HIGH;
           end else begin
              next_state  = IDLE_LOW;
           end
        end

        present_state[HIGH_ID]: begin
           next_state  = IDLE_HIGH;
        end

        present_state[IDLE_HIGH_ID]: begin
           if (in == 1'b0) begin
              next_state  = LOW;
           end else begin
              next_state  = IDLE_HIGH;
           end
        end

        present_state[LOW_ID]: begin
           next_state  = IDLE_LOW;
        end
      endcase // case (1'b1)
   end // always @ (*)

   // --- Present State Register
   always @(posedge clk) begin
      if (reset) begin
         present_state <= IDLE_LOW;
      end else begin
         present_state <= next_state;
      end

      case (1'b1)

        present_state[IDLE_LOW_ID]: begin
           out <= 1'b0;
        end

        present_state[HIGH_ID]: begin
           out <= 1'b1;
        end

        present_state[IDLE_HIGH_ID]: begin
           out <= 1'b0;
        end

        present_state[LOW_ID]: begin
           out <= 1'b1;
        end

        default begin end
      endcase // case (1'b1)
   end // always @ (posedge clk)
