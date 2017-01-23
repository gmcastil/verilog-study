module mod_m_counter
  #(
    parameter N=4,  // number of bits in counter
              M=10  // mod-M
    )
   (
    input wire          clk,
    input wire          reset,
    output wire [N-1:0] q,
    output reg          max_tick
    );

   // signal declaration
   reg [N-1:0]          r_reg;  // this is the counter
   reg [N-1:0]         r_next; // output of next state logic

   // body
   always @(posedge clk, posedge reset) begin
      if (reset) begin
         r_reg <= 0;
      end
      else begin
         r_reg <= r_next;
      end
   end

   // next state logic
   always @* begin
      if (r_reg == 4'b1111) begin
         r_next = 4'b0000;
      end
      else begin
         r_next = r_reg + 1;
      end
   end

   // output logic
   assign q = r_reg;
   always @* begin
      if (q == 4'b1111) begin
         max_tick = 1'b1;
      end
      else begin
         max_tick = 1'b0;
      end
   end

endmodule // mod_m_counter
