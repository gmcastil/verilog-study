`timescale 10ns/10ps

module parking_top_tb ();
  
reg sw1;
reg sw2;
reg clk;
reg async_reset;
wire [3:0] an;
wire [7:0] digit;

localparam T=10;

initial begin
  clk <= 1'b1;
  forever begin
    #(T/2) clk = ~clk;
  end
end

initial begin
  async_reset = 1'b0;
  #(1.75*T);
  async_reset = 1'b1;
  #(1.75*T);
  async_reset = 1'b0;
end

initial begin
  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);

  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);


  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);

  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);

  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);

  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);

  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);

  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);

  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);

  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);
  
  sw1 = 1'b0;
  sw2 = 1'b0;
  #(10*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);
  
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  
  sw2 = 1'b1;
  #(5*T);
  sw1 = 1'b1;
  #(5*T);
  sw2 = 1'b0;
  #(5*T);
  sw1 = 1'b0;
  #(5*T);
  
end

parking_top uut_parking_top
  (
   .sw1 (sw1),
   .sw2 (sw2),
   .clk (clk),
   .async_reset (async_reset),
   .an (an),
   .digit (digit)
   );

endmodule
