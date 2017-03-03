module bcd_decoder (
                    input wire [3:0] bcd_digit,
                    input wire dp,
                    output reg [7:0] sseg_digit
                    );

   always @(*) begin
      case (bcd_digit)

        4'b0000 :
          begin
             sseg_digit[6:0] = 7'b0000001;
          end

        4'b0001 :
          begin
             sseg_digit[6:0] = 7'b1001111;
          end

        4'b0010 :
          begin
             sseg_digit[6:0] = 7'b0010010;
          end

        4'b0011 :
          begin
             sseg_digit[6:0] = 7'b0000110;
          end

        4'b0100 :
          begin
             sseg_digit[6:0] = 7'b1001100;
          end

        4'b0101 :
          begin
             sseg_digit[6:0] = 7'b0100100;
          end

        4'b0110 :
          begin
             sseg_digit[6:0] = 7'b0100000;
          end

        4'b0111 :
          begin
             sseg_digit[6:0] = 7'b0001111;
          end

        4'b1000 :
          begin
             sseg_digit[6:0] = 7'b0000000;
          end

        default :
          begin
             sseg_digit[6:0] = 7'b0000110;
          end
      endcase // case (bcd_digit)
      sseg_digit[7] = ~dp;

   end // always @ (*)

endmodule // bcd_decoder
