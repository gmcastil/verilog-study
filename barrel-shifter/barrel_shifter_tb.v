`timescale 1 ns/10 ps

module barrel_shifter_tb ();
  
   reg [2:0] btn;
   reg [7:0] sw;
   reg 	     lr;
   wire [7:0] led;

   barrel_shifter code_under_test
     (.data(sw), .amt(btn), .lr(lr), .out(led));

   // test for proper left to right shift
   initial begin
      sw = 8'b11110000;
      lr = 1;
      btn = 3'b000;
      #20 btn <= 3'b001;
      #20 btn <= 3'b010;
      #20 btn <= 3'b011;
      #20 btn <= 3'b100;
      #20 btn <= 3'b101;
      #20 btn <= 3'b110;
      #20 btn <= 3'b111;
      #20 btn <= 3'b000;

   // test for proper right to left shift      
      lr = 0;
      btn = 3'b000;
      #20 btn <= 3'b001;
      #20 btn <= 3'b010;
      #20 btn <= 3'b011;
      #20 btn <= 3'b100;
      #20 btn <= 3'b101;
      #20 btn <= 3'b110;
      #20 btn <= 3'b111;
      #20 btn <= 3'b000;
   end
   
endmodule // multi_barrel_shifter_tb
