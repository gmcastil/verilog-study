module mux_wrap
  (
   input       clk,
   input [7:0] in,
   input [2:0] select,
   output reg  out_reg
   );

   reg [7:0]   in_reg;
   reg [2:0]   select_reg;
   wire        out;

   mux_example_1 mux_8to1
     (.in(in_reg), .select(select_reg), .out(out));
 
   always @(posedge clk) begin
      in_reg <= in;
      select_reg <= select;
      out_reg <= out;
   end

endmodule // mux_wrap

   
