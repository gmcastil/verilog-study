module BCD_counter
  (
   input        clk,
   input        reset,
   input        inc,
   input        dec,
   output [7:0] count
   );

  localparam ZERO  = 4'b0000;
  localparam ONE   = 4'b0001;
  localparam TWO   = 4'b0010;
  localparam THREE = 4'b0011;
  localparam FOUR  = 4'b0100;
  localparam FIVE  = 4'b0101;
  localparam SIX   = 4'b0110;
  localparam SEVEN = 4'b0111;
  localparam EIGHT = 4'b1000;
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

    end
  end


endmodule // BCD_counter
