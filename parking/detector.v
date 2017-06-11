module detector
  #(
    )
  (
   input  clk,
   input  reset,
   input  a,
   input  b,
   output reg inc,
   output reg dec
   );

  localparam IDLE = 0;
  localparam IN_10 = 1;
  localparam IN_11 = 2;
  localparam IN_01 = 3;
  localparam IN_00 = 4;
  localparam OUT_01 = 5;
  localparam OUT_11 = 6;
  localparam OUT_10 = 7;
  localparam OUT_00 = 8;

  reg [8:0] state;
  reg [8:0] next;

  // -- State register
  always @(posedge clk) begin
    if (reset == 1'b1) begin
      state = 9'b0;
      state[IDLE] = 1'b1;
    end else begin
      state <= next;
    end
  end

  // -- Combinatorial state machine movements
  always @(*) begin

    next = 9'b0;

    case (1'b1)

      state[IDLE]: begin
        if (a == 1'b1) begin
          next[IN_10] = 1'b1;
        end else if (b == 1'b1) begin
          next[OUT_01] = 1'b1;
        end else begin
          next[IDLE] = 1'b1;
        end
      end

      state[IN_10]: begin
        if (b == 1'b1) begin
          next[IN_11] = 1'b1;
        end else if (a == 1'b0) begin
          next[IDLE] = 1'b1;
        end else begin
          next[IN_10] = 1'b1;
        end
      end

      state[IN_11]: begin
        if (a == 1'b0) begin
          next[IN_01] = 1'b1;
        end else if (b == 1'b0) begin
          next[IN_10] = 1'b1;
        end else begin
          next[IN_11] = 1'b1;
        end
      end

      state[IN_01]: begin
        if (b == 1'b0) begin
          next[IN_00] = 1'b1;
        end else if (a == 1'b1) begin
          next[IN_11] = 1'b1;
        end else begin
          next[IN_01] = 1'b1;
        end
      end

      state[IN_00]: begin
        next[IDLE] = 1'b1;
      end

      state[OUT_01]: begin
        if (a == 1'b1) begin
          next[OUT_11] = 1'b1;
        end else if (b == 1'b0) begin
          next[IDLE] = 1'b1;
        end else begin
          next[OUT_01] = 1'b1;
        end
      end

      state[OUT_11]: begin
        if (b == 1'b0) begin
          next[OUT_10] = 1'b1;
        end else if (a == 1'b0) begin
          next[OUT_01] = 1'b1;
        end else begin
          next[OUT_11] = 1'b1;
        end
      end

      state[OUT_10]: begin
        if (a == 1'b0) begin
          next[OUT_00] = 1'b1;
        end else if (b == 1'b1) begin
          next[OUT_11] = 1'b1;
        end else begin
          next[OUT_10] = 1'b1;
        end
      end

      state[OUT_00]: begin
        next[IDLE] = 1'b1;
      end

    endcase // case (1'b1)
  end // always @ (*)

  // -- Signal assigments
  always @(posedge clk) begin

    case (1'b1)

      next[IDLE]: begin
        inc = 1'b0;
        dec = 1'b0;
      end
      next[IN_10]: begin
        inc = 1'b0;
        dec = 1'b0;
      end
      next[IN_11]: begin
        inc = 1'b0;
        dec = 1'b0;
      end
      next[IN_01]: begin
        inc = 1'b0;
        dec = 1'b0;
      end
      next[IN_00]: begin
        inc = 1'b1;
        dec = 1'b0;
      end
      next[OUT_01]: begin
        inc = 1'b0;
        dec = 1'b0;
      end
      next[OUT_11]: begin
        inc = 1'b0;
        dec = 1'b0;
      end
      next[OUT_10]: begin
        inc = 1'b0;
        dec = 1'b0;
      end
      next[OUT_00]: begin
        inc = 1'b0;
        dec = 1'b1;
      end

    endcase // case (state)
  end // always @ (posedge clk)

endmodule // detector
