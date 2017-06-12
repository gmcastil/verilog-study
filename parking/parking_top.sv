module parking_top
  (
   input  sw1,
   input  sw2,
   input  clk,
   input  async_reset,
   output [3:0] an,
   output [7:0] digit
   );

  wire    db1;
  wire    db2;
  wire    db_reset;

  reg     inc;
  reg     dec;

  wire [3:0] bcd_0;
  wire [3:0] bcd_1;
  wire [3:0] bcd_2;
  wire [3:0] bcd_3;

  wire [7:0] in0;
  wire [7:0] in1;
  wire [7:0] in2;
  wire [7:0] in3;

  // Debounce switch #1
  debounce db_sw_1
    (
     .clk   (clk),
     .reset (sync_reset),
     .sw    (sw1),
     .db    (db1)
     );

  // Debounce switch #2
  debounce db_sw_2
    (
     .clk   (clk),
     .reset (sync_reset),
     .sw    (sw2),
     .db    (db2)
     );

  debounce db_reset
    (
     .clk   (clk),
     .reset (async_reset),
     .sw    (async_reset),
     .db    (db_reset)

  // Synchronize the assertion and deassertion of the global reset
  porf porf_gen
    (
     .async_reset  (db_reset),
     .clk          (clk),
     .clk_enable   (1'b1),
     .sync_reset   (sync_reset)
     );

  // Parking lot detector
  detector u_detector
    (
     .a      (db1),
     .b      (db2),
     .clk    (clk),
     .inc    (inc),
     .dec    (dec),
     );

  // BCD counter
  counter u_counter
    (
     .clk   (clk),
     .reset (sync_reset),
     .inc   (inc),
     .dec   (dec),
     .count (count)
     );

  // BCD to SSEG display
  bcd_decoder dig_1
    (
     .bcd_digit (count[3:0])
     .dp (1'b1),
     .sseg_digit (in0)
     );

  bcd_decoder dig_2
    (
     .bcd_digit (count[7:4]),
     .dp (1'b1),
     .sseg_digit (in1)
     );

  disp_mux disp_unit
    (
     .clk               (clk),
     .reset             (reset),
     .in3               (8'hFF),
     .in2               (8'hFF),
     .in1               (in1),
     .in0               (in0),
     .an                (an),
     .sseg              (digit)
     );

endmodule // parking_top
