This directory contains the following:

* heartbeat.v - Creates a heartbeat pattern on the SSEG display
* heartbeat_tb.v - Testbench for the `heartbeat.v` module
* heartbeat_top.v - Top level module for the design
* disp_mux.v - Necessary for driving four digits with one input
* constraints.xdc - Constraints file for the BASYS3 evaluation board

This module produces a periodic strobe pattern on the seven-segment
display of the BASYS3 board.
