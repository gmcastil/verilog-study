module BCD_incrementor
  (
   input wire incr,
   input wire reset,
   output wire [15:0] data
   );

   reg [3:0]         dig_0 = 4'b0000;
   reg [3:0]         dig_1 = 4'b0000;
   reg [3:0]         dig_2 = 4'b0000;
   reg [3:0]         dig_3 = 4'b0000;

   assign data = {dig_3, dig_2, dig_1, dig_0};
   
   always @*
     if (reset == 1'b1)
       begin
          dig_0 = 4'b0000;
          dig_1 = 4'b0000;
          dig_2 = 4'b0000;
       end
     else if (incr == 1'b1)
       begin
          if (dig_0 != 4'b1001)
            dig_0 = dig_0 + 4'b0001;
          else
            begin
               dig_0 = 4'b0000;
               if (dig_1 != 4'b1001)
                 dig_1 = dig_1 + 4'b0001;
               else
                 begin
                    dig_1 = 4'b0000;
                    if (dig_2 != 4'b1001)
                      dig_2 = dig_2 + 4'b0001;
                    else
                      dig_2 = 4'b0000;
                 end
            end // else: !if(dig_0 != 9)
       end // else: !if(reset)

endmodule // BCD_incrementor
