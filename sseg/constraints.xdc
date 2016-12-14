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
set_property PACKAGE_PIN U7 [get_ports {digit[0]}]             # CG 
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[0]}]
set_property PACKAGE_PIN V5 [get_ports {digit[1]}]             # 
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[1]}]
set_property PACKAGE_PIN U5 [get_ports {digit[2]}]             #
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[2]}]
set_property PACKAGE_PIN V8 [get_ports {digit[3]}]             #
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[3]}]
set_property PACKAGE_PIN U8 [get_ports {digit[4]}]             #
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[4]}]
set_property PACKAGE_PIN W6 [get_ports {digit[5]}]             #
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[5]}]
set_property PACKAGE_PIN W7 [get_ports {digit[6]}]             # 
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[6]}]
set_property PACKAGE_PIN V7 [get_ports {digit[7]}]             # DP 
    set_property IOSTANDARD LVCMOS33 [get_ports {digit[7]}]

## switches
set_property PACKAGE_PIN V17 [get_ports {hex_digits[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[0]}]
set_property PACKAGE_PIN V16 [get_ports {hex_digits[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[1]}]
set_property PACKAGE_PIN W16 [get_ports {hex_digits[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[2]}]
set_property PACKAGE_PIN W17 [get_ports {hex_digits[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[3]}]
set_property PACKAGE_PIN W15 [get_ports {hex_digits[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[4]}]
set_property PACKAGE_PIN V15 [get_ports {hex_digits[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[5]}]
set_property PACKAGE_PIN W14 [get_ports {hex_digits[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[6]}]
set_property PACKAGE_PIN W13 [get_ports {hex_digits[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[7]}]
set_property PACKAGE_PIN V2 [get_ports {hex_digits[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[8]}]
set_property PACKAGE_PIN T3 [get_ports {hex_digits[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[9]}]
set_property PACKAGE_PIN T2 [get_ports {hex_digits[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[10]}]
set_property PACKAGE_PIN R3 [get_ports {hex_digits[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[11]}]
set_property PACKAGE_PIN W2 [get_ports {hex_digits[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[12]}]
set_property PACKAGE_PIN U1 [get_ports {hex_digits[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[13]}]
set_property PACKAGE_PIN T1 [get_ports {hex_digits[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[14]}]
set_property PACKAGE_PIN R2 [get_ports {hex_digits[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hex_digits[15]}]

