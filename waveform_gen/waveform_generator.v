module waveform_generator
  (
   input [3:0] m,
   input [3:0] n,
   input clk,
   input reset,
   output state
   );


   // signal declaration
   localparam DVSR = 9;
   wire [3:0] timer_next;
   reg [3:0]  timer_reg = 0;   // want to count to 10 and then set timer_tick
   wire       timer_tick;
   reg [3:0]  m_count = 0;
   reg [3:0]  m_reg = 0;
   reg [3:0]  n_count = 0;
   reg [3:0]  n_reg = 0;
   reg        high;
   reg        high_reg;


   // register
   always @(posedge clk, posedge reset) begin
      if (reset) begin
         m_count <= 0;
         n_count <= 0;
         high <= 0;
      end else begin
         timer_reg <= timer_next;
         m_reg <= m_count;
         n_reg <= n_count;
         high_reg <= high;
      end
   end

   // next state logic

   // 100ns tick generator
   assign timer_next = (timer_reg == DVSR) ? 3'b0 : timer_reg + 1;
   assign timer_tick = (timer_reg == 9) ? 1'b1 : 1'b0;

   // m and n counters
   always @(*) begin
      if (timer_tick) begin
         if (high_reg) begin
            if (m_reg < m - 1) begin
               m_count = m_reg + 1;
               high = 1'b1;
            end else begin
               m_count = 0;
               high = 1'b0;
            end
         end else begin
            if (n_reg < n - 1) begin
               n_count = n_reg + 1;
               high = 1'b0;
            end else begin
               n_count = 0;
               high = 1'b1;
            end
         end // else: !if(high)
      end // if (timer_tick)
   end // always @ (*)

   // output logic
   assign state = high_reg;

endmodule // waveform_generator
