module mux_example_2
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
   output reg       out
   );
   
   /*
    The purpose of this module is to explore the differences between
    implementing an 8-to-1 multiplexer using case statements, nested assignment
    statements, and nested if-else statements

    This design gets implemented as the same thing as we saw in the the first example
    */

   always @* begin
      case (select)
        3'b000 : out <= in_0;
        3'b001 : out <= in_1;
        3'b010 : out <= in_2;
        3'b011 : out <= in_3;
        3'b100 : out <= in_4;
        3'b101 : out <= in_5;
        3'b110 : out <= in_6;
        default : out <= in_7;
      endcase // case (select)
      end
                
endmodule // mux_example_2
