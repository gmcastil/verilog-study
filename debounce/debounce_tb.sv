module debounce_tb
  (
   input wire        clk,
   input wire [1:0]  btn,
   output wire [3:0] an,
   output wire [7:0] sseg
   );

  // signal declaration
  reg [7:0]          b_reg;
  reg [7:0]          d_reg;
  wire [7:0]         b_next;
  wire [7:0]         d_next;
  reg                btn_reg;
  reg                db_reg;
  wire               db_level;
  wire               db_tick;
  wire               btn_tick;
  wire               clr;

  disp_mux disp_unit
    (
     .clk           (clk),          /* input  */
     .reset         (reset),        /* input  */
     .in0           (d_reg[3:0]),   /* input  */
     .in1           (d_reg[7:4]),   /* input  */
     .in2           (b_reg[3:0]),   /* input  */
     .in3           (b_reg[7:4]),   /* input  */
     .an            (an),           /* output */
     .sseg          (sseg)          /* output */
     );

  debounce debounce_unit
    (
     .clk           (clk),          /* input  */
     .reset         (reset),        /* input  */
     .sw            (btn[1]),       /* input  */
     .db            (db_level)      /* output */
     );

  always @(posedge clk) begin
    btn_reg <= btn[1];0
    db_reg <= db_level;
  end

  assign btn_tick = ~btn_reg & btn[1];
  assign db_tick = ~db_reg & db_level;

  // two counters
  assign clr = btn[0];

  always @(posedge clk) begin
    b_reg <= b_next;
    d_reg <= d_next;
  end

  assign b_next = (clr)       ? 8'b0 :
                  (btn_tick)  ? b_reg + 1 : b_reg;
  assign d_next = (clr)       ? 8'b0 :
                  (db_tick)   ? d_reg + 1 : d_reg;

endmodule // debounce_tb
