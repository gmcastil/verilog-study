module barrel_shifter
  (
   input wire [7:0] data,
   input wire [2:0] amt,
   input wire lr,          // 1 indicates a left to right shift
   output reg [7:0] out
   );

   // locations to store the interim results before muxing it
   wire [7:0] 	     lr_out, rl_out;
   
   // define the left to right shifter
   wire [7:0] 	     lr_stg_0, lr_stg_1;

   assign lr_stg_0 = amt[0] ? {data[0], data[7:1]} : data;
   assign lr_stg_1 = amt[1] ? {lr_stg_0[1:0], lr_stg_0[7:2]} : lr_stg_0;
   assign lr_out = amt[2] ? {lr_stg_1[3:0], lr_stg_1[7:4]} : lr_stg_1;

   // define the right to left shifter
   wire [7:0] 	     rl_stg_0, rl_stg_1;

   assign rl_stg_0 = amt[0] ? {data[6:0], data[7]} : data;
   assign rl_stg_1 = amt[1] ? {rl_stg_0[5:0], rl_stg_0[7:6]} : rl_stg_0;
   assign rl_out = amt[2] ? {rl_stg_1[3:0], rl_stg_1[7:4]} : rl_stg_1;

   always @*
   begin
     if (lr == 1)
       out = lr_out;
     else
	   out = rl_out;
   end

endmodule // barrel_shifter
