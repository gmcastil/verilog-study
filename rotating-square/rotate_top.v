module rotate_top(
                  input wire clk,
                  input wire reset,
                  input wire enable,
                  input wire clockwise,

                  output wire [3:0] an,
                  output wire [7:0] digit
                  );

   wire [7:0]                       in0;
   wire [7:0]                       in1;
   wire [7:0]                       in2;
   wire [7:0]                       in3;

   rotate rotating_box
     (.clk(clk),
      .reset(reset),
      .enable(enable),
      .clockwise(clockwise),
      .in0(in0),
      .in1(in1),
      .in2(in2),
      .in3(in3));

   disp_mux disp_unit
     (.clk(clk),
      .reset(reset),
      .in0(in0),
      .in1(in1),
      .in2(in2),
      .in3(in3),
      .an(an),
      .sseg(digit));

endmodule // rotate_top
