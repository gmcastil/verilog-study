module mux_example_1
  (
   input wire [7:0] in,
   input wire [2:0] select,
   output wire      out
   );
   
   /*
    The purpose of this module is to explore the differences between
    implementing an 8-to-1 multiplexer using case statements, nested assignment
    statements, and nested if-else statements

    This design ends up being synthesized as a long chain of seven 2-to-1
    multiplexers which is interesting.
    */

   assign out = (select == 3'b000) ? in[0] :
                (select == 3'b001) ? in[1] :
                (select == 3'b010) ? in[2] :
                (select == 3'b011) ? in[3] :
                (select == 3'b100) ? in[4] :
                (select == 3'b101) ? in[5] :
                (select == 3'b110) ? in[6] : in[7];

endmodule // mux_example_1

                
