module BCD_incrementor
  (
   input wire incr,
   input wire reset,
   output reg [15:0] data
   );

   reg [3:0]         dig_0 = 8'b00000000;
   reg [3:0]         dig_1 = 8'b00000000;
   reg [3:0]         dig_2 = 8'b00000000;
   reg [3:0]         dig_3 = 8'b00000000;

   assign data = {dig_3, dig_2, dig_1, dig_0}
   
   always @(posedge incr, posedge reset)
     if (reset)
       begin
          dig_0 = 8'b00000000;
          dig_1 = 8'b00000000;
          dig_2 = 8'b00000000;
       end
     else
       begin
          if (dig_0 != 9)
            dig_0 = dig_0 + 4'b0001;
          else
            begin
               dig_0 = 4'b0000;
               if (dig_1 != 9)
                 dig_1 = dig_1 + 4'b0001;
               else
                 begin
                    dig_1 = 4'b0000;
                    if (dig_2 != 9)
                      dig_2 = dig_2 + 4'b0001;
                    else
                      dig_2 = 4'b0000;
                 end
            end // else: !if(dig_0 != 9)
       end // else: !if(reset)

endmodule // BCD_incrementor
