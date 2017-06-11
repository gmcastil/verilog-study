module parking_top
  (
   input  sw1,
   input  sw2,
   input  clk,
   input  async_reset,
   output count
   );

  wire    db1;
  wire    db2;

  reg     inc;
  reg     dec;

  // Debounce switch #1
  debounce db_sw_1
    (
     .clk   (clk),
     .reset (reset),
     .sw    (sw1),
     .db    (db1)
     );

  // Debounce switch #2
  debounce db_sw_2
    (
     .clk   (clk),
     .reset (reset),
     .sw    (sw2),
     .db    (db2)
     );

  // Synchronize the assertion and deassertion of the global reset
  porf porf_gen
    (
     .async_reset  (async_reset),
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

  // BCD to SSEG display
