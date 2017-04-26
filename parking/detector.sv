module detector
  #(
    )
   (
    input  a,
    input  b,
    input  clk,
    output inc,
    output dec,
    output reset
    );

   typedef enum logic [8:0]
                {
                 IDLE   = 9'b000000001,
                 E_01   = 9'b000000010,
                 E_11   = 9'b000000100,
                 E_10   = 9'b000001000,
                 E_00   = 9'b000010000,
                 X_10   = 9'b000000010,
                 X_11   = 9'b000000100,
                 X_01   = 9'b000001000,
                 X_00   = 9'b000010000
                 } states;

   states present;
   states next;

   localparam IDLE_ID = 1;
   localparam E_01_ID = 2;
   localparam E_11_ID = 3;
   localparam E_10_ID = 4;
   localparam E_00_ID = 5;
   localparam X_10_ID = 6;
   localparam X_11_ID = 7;
   localparam X_01_ID = 8;
   localparam X_00_ID = 9;

   always @(posedge clk) begin
      if (reset) begin
         present <= IDLE;
      end else begin
         present <= next;
      end
   end

   always @(*) begin

      case (present)

        E_00: begin
           inc = 1'b1;
           dec = 1'b0;
        end

        X_00: begin
           inc = 1'b0;
           dec = 1'b1;
        end

        default: begin
           inc = 1'b0;
           dec = 1'b0;
        end
      endcase
   end

   always @(*) begin

      next = present;

      case (1'b1)

        present[IDLE_ID]: begin
           if (a == 1'b1) begin
              next = E_01;
           end else if (b == 1'b1) begin
              next = X_10;
           end else begin
              next = present;
           end
        end

        present[E_01_ID]: begin
           if (a == 1'b1 && b == 1'b1) begin
              next = E_11;
           end else if (a == 1'b0 && b == 1'b0) begin
              next = IDLE;
           end else begin
              next = present;
           end
        end

        present[E_11_ID]: begin
           if (a == 1'b0 && b == 1'b1) begin
              next = E_10;
           end else if (a == 1'b1 && b == 1'b0) begin
              next = E_01;
           end else begin
              next = present;
           end
        end

        present[E_10_ID]: begin
           if (a == 1'b0 && b == 1'b0) begin
              next = E_00;
           end else if (a == 1'b1 && b == 1'b1) begin
              next = E_11;
           end else begin
              next = present;
           end
        end

        present[E_00_ID]: begin
           next = IDLE
        end

        present[X_10_ID]: begin
           if (a == 1'b1 && b == 1'b1) begin
              next = X_11;
           end else if (a == 1'b0 && b == 1'b0) begin
              next = IDLE;
           end else begin
              next = present;
           end
        end

        present[X_11_ID]: begin
           if (a == 1'b1 && b == 1'b0) begin
              next = X_01;
           end else if (a == 1'b0 && b == 1'b1) begin
              next = X_10;
           end else begin
              next = present;
           end
        end

        present[X_01_ID]: begin
           if (a == 1'b0 && b == 1'b0) begin
              next = X_00;
           end else if (a == 1'b1 && b == 1'b1) begin
              next = X_11;
           end else begin
              next = present;
           end
        end

        present[X_00_ID]: begin
           next = IDLE
        end

        default: begin
        end
   end

endmodule
