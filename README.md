Overview
========
I have been teaching myself FPGA and digital hardware design, primarily
targeting the Xilinx 7-series family of FPGAs.  This repository contains some
of the modules I have developed for the [Digilient Basys3 Artix-7 FPGA
evaluation board](https://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,1288&Prod=BASYS3).
These are relatively trivial, but as my knowledge increases, I assume that the
complexity will increase accordingly.

The evaluation board I am working with is based on the Artix-7
(XC7A35T-1CPG236C) FPGA from Xilinx and has the following specs:

* 33,280 logic cells in 5200 slices (each slice contains four 6-input LUTs and 8
flip-flops)
* 1,800Kb of fast BRAM
* Five clock management tiles, each having a PLL
* 90 DSP slices
* Internal clock speeds greater than 450MHz
* On-chip analog-to-digital converter (XADC)

The board also has a lot of ports and other peripherals:

* 16 switches and LEDs
* 5 user push-buttons
* 4-digit 7-segment display
* 4 PMOD connectors
* 12-bit VGA output

I will probably design a daughtercard to carry some other peripherals to
interface with using those PMOD connectors.  I'm thinking something like a
thermal sensor with a SPI interface, something similar with an I2C interface,
and an LCD display module.

Progress
========
I have been working through a textbook on introductory digital design using
VHDL for the past month or so.  The first half of the book focuses on
combinational logic and I am mostly finished that.  The rest of
the book is dedicated to sequential circuit design, state machines, etc.

Useful Links
============
As I encounter documentation and other information that I find helpful, I will
add them to this section.

[Basys3 reference manual](https://www.digilentinc.com/Data/Products/BASYS3/Basys3_rm.pdf)

[Basys3 board schematics](https://www.digilentinc.com/Data/Products/BASYS3/basys_3_sch_public.pdf)

[Xilinx 7-series family overview](http://www.xilinx.com/support/documentation/data_sheets/ds180_7Series_Overview.pdf)

The Xilinx documentation for this FPGA is extensive and can be found [here](http://www.xilinx.com/products/silicon-devices/fpga/artix-7.html#documentation).
