module mux_example_1
  (
   input wire       in_0,
   input wire       in_1,
   input wire       in_2,
   input wire       in_3,
   input wire       in_4,
   input wire       in_5,
   input wire       in_6,
   input wire       in_7,
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

   assign out = (select == 3'b000) ? in_0 :
                (select == 3'b001) ? in_1 :
                (select == 3'b010) ? in_2 :
                (select == 3'b011) ? in_3 :
                (select == 3'b100) ? in_4 :
                (select == 3'b101) ? in_5 :
                (select == 3'b110) ? in_6 : in_7;

endmodule // mux_example_1

                
