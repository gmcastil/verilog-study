module mux_wrap
  (
   input       clk,
   input [7:0] in,
   input [2:0] select,
   output      out
   );

   reg [7:0]   in_reg;
   reg [2:0]   select_reg;
   reg         out;

   mux_example_1 8to1_mux
     (.in(in_reg), .select(select_reg), .out(out_reg));
   
   always @(posedge clk) begin
      in_reg <= in;
      sel_reg <= sel;
      out_reg <= out;
   end

endmodule // mux_wrap

   
