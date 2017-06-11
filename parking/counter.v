module counter
  (
   input        clk,
   input        reset,
   input        inc,
   input        dec,
   output [7:0] count
   );

  localparam ZERO  = 4'b0000;
  localparam NINE  = 4'b1001;

  reg [3:0]     dig_1;
  reg [3:0]     dig_2;

  assign count[3:0] = dig_1;
  assign count[7:4] = dig_2;

  always @(posedge clk) begin
    if (reset) begin
      dig_1 <= ZERO;
      dig_2 <= ZERO;
    end else begin
      if (inc == 1'b1) begin
        if (dig_1 == NINE) begin
          dig_1 = ZERO;
          if (dig_2 == NINE) begin
            dig_2 = ZERO;
          end else begin
            dig_2 = dig_2 + 1'b1;
          end
        end else begin
          dig_1 = dig_1 + 1'b1;
        end
      end else if (dec == 1'b1) begin
        if (dig_1 == ZERO) begin
          dig_1 = NINE;
          if (dig_2 == ZERO) begin
            dig_2 = NINE;
          end else begin
            dig_2 = dig_2 - 1'b1;
          end
        end else begin
          dig_1 = dig_1 - 1'b1;
        end
      end
    end
  end

endmodule // BCD_counter
