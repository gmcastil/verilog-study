module FP_comp
  (
   input wire        sign_1, sign_2,    // 1 indicates a negative number
   input wire [3:0]  exp_1, exp_2,
   input wire [7:0]  frac_1, frac_2,
   output reg        gt                 // 1 if input_1 is greater than input_2
   );

   // interim results
   wire [11:0]       input_1;
   wire [11:0]       input_2;

   assign input_1 = {exp_1, frac_1};
   assign input_2 = {exp_2, frac_2};

   always @* begin
      if (sign_1 == sign_2) begin
         if (sign_1 == 1'b0) begin               // positive inputs
            if (input_1 > input_2) begin
               gt = 1'b1;
            end
            else begin
               gt = 1'b0;
            end
         end
         else begin                              // negative inputs
            if (input_1 < input_2) begin
               gt = 1'b1;
            end
            else begin
               gt = 1'b0;
            end
         end // else: !if(sign_1 == 1'b0)
      end // if (sign_1 == sign_2)
      else begin                                 // opposite signed inputs
        $display("the value of sign_1 is: %b", sign_1);
         if (sign_1 == 1'b1) begin
            gt = 1'b0;
         end
         else if (sign_2 == 1'b1) begin
            gt = 1'b1;
         end
      end // else: !if(sign_1 == sign_2)
   end // always @ *

endmodule // FP_comp
