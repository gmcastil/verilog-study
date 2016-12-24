`timescale 1 ns/10 ps

module dp_enc_tb ();

   reg [11:0] req;
   wire [3:0]  first, second;

   dp_enc code_under_test
     (.req(req), .first(first), .second(second));

   initial begin
      // test for fixed first priority
      req <= 12'b110000000000;  /* first = 1100, second = 1011 */
      #20 req <= 12'b101000000000;  /* first = 1100, second = 1010 */
      #20 req <= 12'b100100000000;  /* first = 1100, second = 1001 */
      #20 req <= 12'b100010000000;  /* first = 1100, second = 1001 */
      #20 req <= 12'b100001000000;  /* first = 1100, second = 1001 */
      #20 req <= 12'b100000100000;  /* first = 1100, second = 1001 */
      #20 req <= 12'b100000010000;  /* first = 1100, second = 1001 */
      #20 req <= 12'b100000001000;  /* first = 1100, second = 1001 */
      #20 req <= 12'b100000000100;  /* first = 1100, second = 1001 */
      #20 req <= 12'b100000000010;  /* first = 1100, second = 0010 */
      #20 req <= 12'b100000000001;  /* first = 1100, second = 0001 */
      #20 req <= 12'b100000000000;  /* first = 1100, second = 0000 */

      // test for fixed second priority
      #20 req <= 12'b100000000001;  /* first = 1100, second = 0001 */
      #20 req <= 12'b010000000001;  /* first = 1011, second = 0001 */
      #20 req <= 12'b001000000001;  /* first = 1010, second = 0001 */
      #20 req <= 12'b000100000001;  /* first = 1001, second = 0001 */
      #20 req <= 12'b000010000001;  /* first = 1000, second = 0001 */
      #20 req <= 12'b000001000001;  /* first = 0111, second = 0001 */
      #20 req <= 12'b000000100001;  /* first = 0110, second = 0001 */
      #20 req <= 12'b000000010001;  /* first = 0101, second = 0001 */
      #20 req <= 12'b000000001001;  /* first = 0100, second = 0001 */
      #20 req <= 12'b000000000101;  /* first = 0011, second = 0001 */
      #20 req <= 12'b000000000011;  /* first = 0010, second = 0001 */
      #20 req <= 12'b000000000001;  /* first = 0001, second = 0000 */
      
   // test for edge cases
      #20 req <= 12'b111111111111;  /* first = 1100, second = 1011 */
      #20 req <= 12'b000000000000;  /* first = 0000, second = 0000 */
      #20 req <= 12'b101010101010;  /* first = 1100, second = 1010 */
   end // initial begin

endmodule // dp_enc_tb
