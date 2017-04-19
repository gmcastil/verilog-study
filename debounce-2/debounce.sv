module debounce #(
                  )
   (
    input      clk,
    input      reset,
    input      sw,
    output reg db
    );

   // --- Signal Declarations
   localparam DVSR = 2E6;  // 20ms / 10ns = 2E6
   localparam N = 24;

   wire [N-1:0] counter_next;
   wire         counter_tick;
   reg [N-1:0]  counter_reg;

   typedef enum logic[2:0]
                {
                 IDLE    = 3'b001,
                 TRIPPED = 3'b010,
                 HIGH    = 3'b100
                 } states;

   states next_state;
   states present_state;

   localparam IDLE_ID    = 0;
   localparam TRIPPED_ID = 1;
   localparam HIGH_ID    = 2;

   assign timer_next = (timer_reg == DVSR) ? {N{1'b0}} :
                       timer_reg + 1'b1;
   assign timer_tick = (timer_reg == DVSR) ? 1'b1 : 1'b0;

   // --- Combinatorial State Movements
   always @(*) begin

      case (1'b1)

        present_state[IDLE_ID]: begin
           if (sw) begin
              next_state = TRIPPED;
           end else begin
              next_state = IDLE;
           end
        end


      endcase // case (1'b1)
   end // always @ (*)

   // --- Present State Register
   always @(*) begin
      if (reset) begin
         present_state <= IDLE;
         timer_reg <= {N{1'b0}};
      end else begin
         present_state <= next_state;
         timer_reg <= timer_next;
      end
