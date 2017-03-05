module dec_to_sseg
  (
   input wire [3:0] dec,
   input wire dp,
   output reg [7:0] sseg  // output active low
   );

   always @*
     begin
	case(dec)
	  4'h0: sseg[6:0] = 7'b0000001;
	  4'h1: sseg[6:0] = 7'b1001111;
	  4'h2: sseg[6:0] = 7'b0010010;
	  4'h3: sseg[6:0] = 7'b0000110;
	  4'h4: sseg[6:0] = 7'b1001100;
	  4'h5: sseg[6:0] = 7'b0100100;
	  4'h6: sseg[6:0] = 7'b0100000;
	  4'h7: sseg[6:0] = 7'b0001111;
	  4'h8: sseg[6:0] = 7'b0000000;
	  default: sseg[6:0] = 7'b0000100;
	endcase // case (dec)
	sseg[7] = dp;
    end // always @ *

endmodule // dec_to_sseg
