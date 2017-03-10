`timescale 1 ns/10 ps

module waveform_generator_tb();

   localparam T=10;  // clock period of 10ns
   reg [3:0]  m;
   reg [3:0]  n;
   reg        clk;
   reg        reset;
   wire        state;

   // instantiate code under test
   waveform_generator uut
     (.m(m), .n(n), .clk(clk), .reset(reset), .state(state));


   // need a 10ns clock
   always begin
      clk = 1'b1;
      #(T/2);
      clk = 1'b0;
      #(T/2);
   end

   // hold in reset for 1 clock cycle
   initial begin
      reset = 1'b1;
      #(T)
      reset = 1'b0;
   end

   // lets see if it works
   initial begin
      m = 4'b0011;  // let first high period be 300ns
      n = 4'b0010;  // let first low period be 200ns
      #(T*250);
      m = 4'b0010;
      n = 4'b0011;
      #(T*250);
   end

endmodule // waveform_generator_tb
