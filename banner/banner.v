module banner
  #(
    parameter foo
    )(
      input wire       clk,
      input wire       reset,
      input wire       enable,
      input wire       dir,
      output reg [3:0] dig_0,
      output reg [3:0] dig_1,
      output reg [3:0] dig_2,
      output reg [3:0] dig_3
      );

   // signal declaration
   localparam NULL  = 4'b1111;
   localparam ZERO  = 4'b0000;
   localparam ONE   = 4'b0001;
   localparam TWO   = 4'b0010;
   localparam THREE = 4'b0011;
   localparam FOUR  = 4'b0100;
   localparam FIVE  = 4'b0101;
   localparam SIX   = 4'b0110;
   localparam SEVEN = 4'b0111;
   localparam EIGHT = 4'b1000;
   localparam NINE  = 4'b1001;

   reg [3:0]                    dig_0_reg;
   reg [3:0]                    dig_1_reg;
   reg [3:0]                    dig_2_reg;
   reg [3:0]                    dig_3_reg;

   reg [3:0]                    dig_0_next;
   reg [3:0]                    dig_1_next;
   reg [3:0]                    dig_2_next;
   reg [3:0]                    dig_3_next;

   reg [18:0]                   timer_next;
   reg [18:0]                   timer_reg;

   // next state logic
   always @(*) begin
      if (!enable) begin
         dig_0_next = dig_0_reg;
         dig_1_next = dig_1_reg;
         dig_2_next = dig_2_reg;
         dig_3_next = dig_3_reg;
         timer_next = timer_reg;
      end else begin
         if (dir) begin
            if (dig_0_reg == NULL && dig_1_reg == NULL &&
                dig_2_reg == NULL && dig_3_reg == NULL) begin

               dig_0_next = ZERO;
               dig_1_next = NULL;
               dig_2_next = NULL;
               dig_3_next = NULL;

            end else if (dig_0_reg == ZERO && dig_1_reg == NULL &&
                         dig_2_reg == NULL && dig_3_reg == NULL) begin

               dig_0_next = ONE;
               dig_1_next = ZERO;
               dig_2_next = NULL;
               dig_3_next = NULL;

            end else if (dig_0_reg == ONE && dig_1_reg == ZERO &&
                         dig_2_reg == NULL && dig_3_reg == NULL) begin

               dig_0_next = TWO;
               dig_1_next = ONE;
               dig_2_next = ZERO;
               dig_3_next = NULL;

            end else if (dig_0_reg == TWO && dig_1_reg == ONE &&
                         dig_2_reg == ZERO && dig_3_reg == NULL) begin

               dig_0_next = THREE;
               dig_1_next = TWO;
               dig_2_next = ONE;
               dig_3_next = ZERO;

            end else begin

               dig_3_next = dig_2_reg;
               dig_2_next = dig_1_reg;
               dig_1_next = dig_0_reg;

               // need to determine the next value for the rightmost digit

               case (dig_1_reg)

                 ZERO: begin
                   dig_0_next = ONE;
                 end

                 ONE: begin
                   dig_0_next = TWO;
                 end

                 TWO: begin
                   dig_0_next = THREE;
                 end

                 THREE: begin
                   dig_0_next = FOUR;
                 end

                 FOUR: begin
                   dig_0_next = FIVE;
                 end

                 FIVE: begin
                   dig_0_next = SIX;
                 end

                 SIX: begin
                   dig_0_next = SEVEN;
                 end

                 SEVEN: begin
                   dig_0_next = EIGHT;
                 end

                 EIGHT: begin
                   dig_0_next = NINE;
                 end

                 NINE: begin
                   dig_0_next = ZERO;
                 end

                 default: begin
                    end

               endcase // case (dig_1_reg)

   // register
   always @(posedge clk) begin
      if (reset) begin
         dig_0_reg = NULL;
         dig_1_reg = NULL;
         dig_2_reg = NULL;
         dig_3_reg = NULL;
         timer_reg = 18'd0;
      end else begin
         dig_0_reg = dig_0_next;
         dig_1_reg = dig_1_next;
         dig_2_reg = dig_2_next;
         dig_3_reg = dig_3_next;
         timer_reg = timer_next;
      end // else: !if(reset)
   end // always @ (posedge clk)

   // output logic
