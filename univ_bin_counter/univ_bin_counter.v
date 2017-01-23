module univ_bin_counter
  #(parameter N=8)
   (
    input wire clk,
    input wire reset,
    input wire syn_clear,
    input wire [N-1:0] d,
    input wire en,
    input wire load,
    input wire up,
    output wire max_tick,
    output wire min_tick,
    output wire [N-1:0] q
    );

   // signal declarations
   reg [N-1:0]          r_reg;
   reg [N-1:0]          r_next;

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
   always @*
     if (syn_clear) begin
        r_next = 0;
     end
     else if (load) begin
        r_next = d;
     end
     else if (en) begin
        if (up) begin
           r_next = r_reg + 1;
        end
        else begin
           r_next = r_reg - 1;
        end
     end
     else begin
        r_next = r_reg;
     end // else: !if(en)

   // output logic
   assign q = r_reg;
   assign max_tick = (r_reg == 2**N-1) ? 1'b1 : 1'b0;
   assign min_tick = (r_reg == 0) ? 1'b1 : 1'b0;

endmodule // univ_bin_counter
