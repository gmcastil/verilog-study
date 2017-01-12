module FP_comp
  (
   input wire        sign_1, sign_2,    // 1 indicates a negative number
   input wire [3:0]  exp_1, exp_2,
   input wire [8:0] frac_1, frac_2,
   output reg        gt                 // 1 if input_1 is greater than input_2
   );

   // interim results
   reg [11:0]        input_1 = {exp_1, frac_1};
   reg [11:0]        input_2 = {exp_2, frac_2);

   always @*
     if (sign_1 > sign_2)
       // implies input_1 < input_2
       begin
          gt = 0;
       end
     else if (sign_1 < sign_2)
       // implies input_1 > input_2
       begin
          gt = 1;
       end
     else
       // depends on relative magnitudes of the two inputs
       if (sign_1 == 1'b0')
         // dealing with positive floating point values
         begin
            if (input_1 > input_2)
              begin
                gt = 1;
              end
            else
              begin
                 gt = 0;
              end
         end // if (sign_1 == 1'b0')
       else
         // dealing with negative floating point values
         begin
            if (input_1 < input_2)
              begin
                 gt = 1
              end
            else
              begin
                 gt = 0;
              end
         end // else: !if(sign_1 == 1'b0')

endmodule // FP_comp
