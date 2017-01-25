This directory contains the following:

* mux_example_1.v - 8-to-1 multiplexer implemented as nested assign statements
* mux_example_2.v - 8-to-1 multiplexer implemented in a case statement
* mux_example_3.v - 8-to-1 multiplexer implemented in a sequence of if-else statements
* mux_example_tb.v - Testbench for verifying behavior of each of the other three modules\\

* constraints.xdc - Constraints file to instantiate any of these three modules on the BASYS3 evaluation board

I had a discussion with a coworker this afternoon about the different ways to
implement a particular design and it occurred to me it might be interesting
to see how the Vivado synthesis engine generated an implementation for the three
types of logical structures.  Interesting that, while logically equivalent,
there are differences in the final synthesized product.

The `mux_wrap.v` module registers the input and output of `mux_example_1.v`.
I was going to use this to learn how to perform a timing analysis, but I
haven't gotten to it yet.
