`timescale 1 ns/10 ps

module mux_example_tb ();

   reg       in_0;
   reg       in_1;
   reg       in_2;
   reg       in_3;
   reg       in_4;
   reg       in_5;
   reg       in_6;
   reg       in_7;
   reg [2:0] select;
   wire      out;

   // modify this instantiation to test the other two modules
   mux_example_1 code_under_test
     (.in_0(in_0), .in_1(in_1), .in_2(in_2), .in_3(in_3),
      .in_4(in_4), .in_5(in_5), .in_6(in_6), .in_7(in_7),
      .select(select), .out(out));
      
   initial begin
      // set up these to be alternating signals to make it easy to test
      in_0 = 1;
      in_1 = 0;
      in_2 = 1;
      in_3 = 0;
      in_4 = 1;
      in_5 = 0;
      in_6 = 1;
      in_7 = 0;
      select <= 3'b000;
      #20 select <= 3'b001;
      #20 select <= 3'b010;
      #20 select <= 3'b011;
      #20 select <= 3'b100;
      #20 select <= 3'b101;
      #20 select <= 3'b110;
      #20 select <= 3'b111;
   end // initial begin

endmodule // mux_example_tb


      
