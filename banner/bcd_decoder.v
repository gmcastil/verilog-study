module bcd_decoder (
                    input wire [3:0] bcd_digit,
                    output reg [6:0] sseg_digit
                    );

   case (bcd_digit)

     4'b0000 :
       begin
       end

     4'b0001 :
       begin
       end

     4'b0010 :
       begin
       end

     4'b0011 :
       begin
       end

     4'b0100 :
       begin
       end

     4'b0101 :
       begin
       end

     4'b0110 :
       begin
       end

     4'b0111 :
       begin
       end

     4'b1000 :
       begin
       end

     4'b1001 :
       begin
       end

     4'b1010 :
       begin
       end

     default :
       begin
       end

   endcase // case (bcd_digit)

endmodule // bcd_decoder
