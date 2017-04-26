module debounce#(
                 )
  (
   input      clk,
   input      reset,
   input      sw,
   output reg db
   );

  // --- Signal Declarations
  localparam DVSR = 1000000;
  localparam N = 24;

  wire [N-1:0] timer_next;
  wire         timer_tick;
  reg [N-1:0]  timer_reg;

  typedef enum logic[8:0]
               {
                ZERO     = 8'b00000001,
                WAIT1_1  = 8'b00000010,
                WAIT1_2  = 8'b00000100,
                WAIT1_3  = 8'b00001000,
                WAIT0_1  = 8'b00010000,
                WAIT0_2  = 8'b00100000,
                WAIT0_3  = 8'b01000000,
                ONE      = 8'b10000000
                } states;

  states next_state;
  states present_state;

  // Index the one-hot codes needed for the case statement
  localparam ZERO_ID     = 0;
  localparam WAIT1_1_ID  = 1;
  localparam WAIT1_2_ID  = 2;
  localparam WAIT1_3_ID  = 3;
  localparam WAIT0_1_ID  = 4;
  localparam WAIT0_2_ID  = 5;
  localparam WAIT0_3_ID  = 6;
  localparam ONE_ID      = 7;

  // Create the 10ms tick we need
  assign timer_next = (timer_reg == DVSR) ? {N{1'b0}} :
                      timer_reg + 1'b1;
  assign timer_tick = (timer_reg == DVSR) ? 1'b1 : 1'b0;

  // --- Combinatorial State Movements
  always @(*) begin

    case (1'b1)

      present_state[ZERO_ID]: begin
        if (sw) begin
          next_state = WAIT1_1;
        end else begin
          next_state = ZERO;
        end
      end

      present_state[WAIT1_1_ID]: begin
        if (sw && !timer_tick) begin
          next_state = WAIT1_1;
        end else if (sw && timer_tick) begin
          next_state = WAIT1_2;
        end else begin
          next_state = ZERO;
        end
      end

      present_state[WAIT1_2_ID]: begin
        if (sw && !timer_tick) begin
          next_state = WAIT1_2;
        end else if (sw && timer_tick) begin
          next_state = WAIT1_3;
        end else begin
          next_state = ZERO;
        end
      end

      present_state[WAIT1_3_ID]: begin
        if (sw && !timer_tick) begin
          next_state = WAIT1_3;
        end else if (sw && timer_tick) begin
          next_state = ONE;
        end else begin
          next_state = ZERO;
        end
      end

      present_state[ONE_ID]: begin
        if (sw) begin
          next_state = ONE;
        end else begin
          next_state = WAIT0_1;
        end
      end

      present_state[WAIT0_1_ID]: begin
        if (!sw && !timer_tick) begin
          next_state = WAIT0_1;
        end else if (!sw && timer_tick) begin
          next_state = WAIT0_2;
        end else begin
          next_state = ONE;
        end
      end

      present_state[WAIT0_2_ID]: begin
        if (!sw && !timer_tick) begin
          next_state = WAIT0_2;
        end else if (!sw && timer_tick) begin
          next_state = WAIT0_3;
        end else begin
          next_state = ONE;
        end
      end

      present_state[WAIT0_3_ID]: begin
        if (!sw && !timer_tick) begin
          next_state = WAIT0_3;
        end else if (!sw && timer_tick) begin
          next_state = ZERO;
        end else begin
          next_state = ONE;
        end
      end

      default: begin
      end

    endcase // case (1'b1)

  end //always @(*)

  // --- Present State Register
  always @(posedge clk) begin
    if (reset) begin
      present_state <= ZERO;
    end else begin
      present_state <= next_state;
    end

    case (1'b1)

      present_state[ZERO_ID]: begin
        db <= 1'b0;
      end

      present_state[WAIT1_1_ID]: begin
        db <= 1'b0;
      end

      present_state[WAIT1_2_ID]: begin
        db <= 1'b0;
      end

      present_state[WAIT1_3_ID]: begin
        db <= 1'b0;
      end

      present_state[ONE_ID]: begin
        db <= 1'b1;
      end

      present_state[WAIT0_1_ID]: begin
        db <= 1'b1;
      end

      present_state[WAIT0_2_ID]: begin
        db <= 1'b1;
      end

      present_state[WAIT0_3_ID]: begin
        db <= 1'b1;
      end

      default: begin
      end
    endcase // case (1'b1)
  end // always @ (posedge clk)

endmodule // debounce
