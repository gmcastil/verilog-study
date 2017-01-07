# bias settings	
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
    set_property IOSTANDARD LVCMOS33 [get_ports clk]
    #create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# common anodes
set_property PACKAGE_PIN U2 [get_ports {an[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]

# SSEG display LEDs
set_property PACKAGE_PIN U7 [get_ports {digit[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[0]}]
set_property PACKAGE_PIN V5 [get_ports {digit[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[1]}]
set_property PACKAGE_PIN U5 [get_ports {digit[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[2]}]
set_property PACKAGE_PIN V8 [get_ports {digit[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[3]}]
set_property PACKAGE_PIN U8 [get_ports {digit[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[4]}]
set_property PACKAGE_PIN W6 [get_ports {digit[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[5]}]
set_property PACKAGE_PIN W7 [get_ports {digit[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[6]}]
set_property PACKAGE_PIN V7 [get_ports {digit[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[7]}]

## switches
set_property PACKAGE_PIN V17 [get_ports incr]
	set_property IOSTANDARD LVCMOS33 [get_ports incr]

## push buttons
# we'll use a push button switch after making a debouncer in the next chapter
set_property PACKAGE_PIN W19 [get_ports reset]
	set_property IOSTANDARD LVCMOS33 [get_ports reset]

# the pushbutton switch is preferable, but come back after we make a switch
# debouncer
# set_property PACKAGE_PIN U17 [get_ports incr]
#	 set_property IOSTANDARD LVCMOS33 [get_ports incr]

# this appears to be necessary because the router was trying to minimize the
# skew across the design and, due to the location of the IBUFG on the spine of
# the part and the location of the input and output IOB, it was warning us
# during route that the path was not optimal - normally, we would not want to
# disable this, but for this application it is fine since the clock is just
# being used to multiplex the output digits
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets incr_IBUF]