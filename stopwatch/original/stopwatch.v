module stopwatch
  (
   input wire clk,
   input wire go,
   input wire clr,
   output wire [3:0] d2, d1, d0
   );

   // signal declarations
   localparam DVSR = 10000000;

   wire [3:0]        d2_next;
   wire [3:0]        d1_next;
   wire [3:0]        d0_next;

   reg [3:0]         d2_reg;
   reg [3:0]         d1_reg;
   reg [3:0]         d0_reg;

   wire               d2_tick;
   wire               d1_tick;
   wire               d0_tick;
   wire               ms_tick;

   wire               d2_en;
   wire               d1_en;
   wire               d0_en;


   wire [23:0]       ms_next;
   reg [23:0]        ms_reg;

   // body
   // register
   always @(posedge clk) begin
      d2_reg <= d2_next;
      d1_reg <= d1_next;
      d0_reg <= d0_next;
      ms_reg <= ms_next;
   end

   // next state logic
   assign ms_next = (clr || (ms_reg == DVSR && go)) ? 4'b0 :
                    (go) ? ms_reg + 1 :
                    ms_reg;

   assign ms_tick = (ms_reg == DVSR) ? 1'b1 : 1'b0;

   // 0.1 sec counter
   assign d0_en = ms_tick;
   assign d0_next = (clr || (d0_reg == 9 && d0_en)) ? 4'b0 :
                    (d0_en) ? d0_reg + 1 :
                    d0_reg;

   assign d0_tick = (d0_reg == 9) ? 1'b1 : 1'b0;

   // 1 sec counter
   assign d1_en = ms_tick & d0_tick;
   assign d1_next = (clr || (d1_reg == 9 && d1_en)) ? 4'b0 :
                    (d1_en) ? d1_reg + 1 :
                    d1_reg;
   assign d1_tick = (d1_reg == 9) ? 1'b1 : 1'b0;

   // 10 sec counter
   assign d2_en = ms_tick & d0_tick & d1_tick;
   assign d2_next = (clr || (d2_reg == 9 && d2_en)) ? 4'b0 :
                    (d2_en) ? d2_reg + 1 :
                    d2_reg;

   // output logic
   assign d0 = d0_reg;
   assign d1 = d1_reg;
   assign d2 = d2_reg;

endmodule // stopwatch
