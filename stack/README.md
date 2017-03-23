This directory contains the following:

* constraints.xdc - Pin constraints for a BASYS3 evaluation board
* db_fsm.v - Debouncing circuit for push button switches
* stack.v - Stack data structure
* stack_tb.v - Testbench for the stack module
* stack_top.v - Top module for tying switches, LED, and stack together

The testbench is fairly thorough and tests for stack underflow, overflow, and
the capability of pulling and pushing arbitrary values off and onto the stack
respectively.  However, synthesis and implementation in the actual FPGA
generates a rather significant divergence between the synthesized and simulated
behavior.  Once I figure out how ChipScope and the ILA work in Vivado, I'll come
back to this to try and get the synthesized circuit to perform the same as it
does in simulation.
