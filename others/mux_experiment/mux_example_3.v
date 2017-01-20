module mux_example_3
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
   output reg      out
   );
   
   /*
    The purpose of this module is to explore the differences between
    implementing an 8-to-1 multiplexer using case statements, nested assignment
    statements, and nested if-else statements

    */

   always @* begin
      if (select == 3'b000) begin
         out = in_0;
      end
      else if (select == 3'b001) begin
         out = in_1;
      end
      else if (select == 3'b010) begin
         out = in_2;
      end
      else if (select == 3'b011) begin
         out = in_3;
      end
      else if (select == 3'b100) begin
         out = in_4;
      end
      else if (select == 3'b101) begin
         out = in_5;
      end
      else if (select == 3'b110) begin
         out = in_6;
      end
      else begin
         out = in_7;
      end
   end // always @ *
                
endmodule // mux_example_3

