`timescale 1 ns/10 ps

module FP_comp_tb ();

   reg          sign_1, sign_2;
   reg [3:0]    exp_1, exp_2;
   reg [7:0]    frac_1, frac_2;

   FP_comp code_under_test
     (.sign_1(sign_1), .sign_2(sign_2),
      .exp_1(exp_1), .exp_2(exp_2),
      .frac_1(frac_1), .frac_2(frac));

   always
     #5 clk = !clk;

   always
     // start with some positive numbers
     begin
     #5
       // input_1 > input_2 => output should be 1
       sign_1 = 0;
        sign_2 = 0;
        exp_1 = 1;
        exp_2 = 0;
        frac_1 = 0.314;
        frac_2 = 0.314;

        // input_2 > input_1 => output should be 0
       sign_1 = 0;
        sign_2 = 0;
        exp_1 = 0;
        exp_2 = 1;
        frac_1 = 0.314;
        frac_2 = 0.314;

        // input_2 == input_1 => output should be 0
       sign_1 = 0;
        sign_2 = 0;
        exp_1 = 2;
        exp_2 = 2;
        frac_1 = 0.314;
        frac_2 = 0.314;

     #5
       // now for some negative numbers
       sign_1 = 1;
        sign_2 = 1;
        exp_1 = 1;
        exp_2 = 0;
        frac_1 = 0.314;
        frac_2 = 0.314;
