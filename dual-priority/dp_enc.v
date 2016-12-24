module dp_enc
  (
   input wire [11:0] req,
   output reg [3:0] first, second
   );
   
   reg [11:0] 	     interim;
   
   always @*
     begin
     // to store the result after removing the highest priority signal

	 // find the highest priority signal and then 
	 casez (req)
	  12'b1???????????:
	    begin
	       interim = {1'b0, req[10:0]};
	       first = 12;
	    end
	  12'b01??????????:
	    begin
	       interim = {2'b00, req[9:0]};
	       first = 11;
	    end
	  12'b001?????????:
	    begin
	       interim = {3'b000, req[8:0]};
	       first = 10;
	    end
	  12'b0001????????:
	    begin
	       interim = {4'b0000, req[7:0]};
	       first = 9;
	    end
	  12'b00001???????:
	    begin
	       interim = {5'b00000, req[6:0]};
	       first = 8;
	    end
	  12'b000001??????:
	    begin
	       interim = {6'b000000, req[5:0]};
	       first = 7;
	    end
	  12'b0000001?????:
	    begin
	       interim = {7'b0000000, req[4:0]};
	       first = 6;
	    end
	  12'b00000001????:
	    begin
	       interim = {8'b00000000, req[3:0]};
	       first = 5;
	    end
	  12'b000000001???:
	    begin
	       interim = {9'b000000000, req[2:0]};
	       first = 4;
	    end
	  12'b0000000001??:
	    begin
	       interim = {10'b0000000000, req[1:0]};
	       first = 3;
	    end
	  12'b00000000001?:
	    begin
	       interim = {11'b00000000000, req[0]};
	       first = 2;
	    end
	  12'b000000000001:
	    begin
	       interim = 12'b000000000000;
	       first = 1;
	    end
	  default:
	    begin
	       interim = 12'b000000000000;
	       first = 0;
	    end
	endcase // casez (req)
	
	casez (interim)
	  12'b01??????????:
	    second = 11;
	  12'b001?????????:
	    second = 10;
	  12'b0001????????:
	    second = 9;
	  12'b00001???????:
	    second = 8;
	  12'b000001??????:
	    second = 7;
	  12'b0000001?????:
	    second = 6;
	  12'b00000001????:
	    second = 5;
	  12'b000000001???:
	    second = 4;
	  12'b0000000001??:
	    second = 3;
	  12'b00000000001?:
	    second = 2;
	  12'b000000000001:
	    second = 1;
	  default:
	    second = 0;
	endcase // casez (interim)
  end // always @ *

endmodule // dp_enc
