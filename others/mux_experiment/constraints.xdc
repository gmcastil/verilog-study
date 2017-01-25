## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports {in[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {in[0]}]
set_property PACKAGE_PIN V16 [get_ports {in[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {in[1]}]
set_property PACKAGE_PIN W16 [get_ports {in[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {in[2]}]
set_property PACKAGE_PIN W17 [get_ports {in[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {in[3]}]
set_property PACKAGE_PIN W15 [get_ports {in[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {in[4]}]
set_property PACKAGE_PIN V15 [get_ports {in[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {in[5]}]
set_property PACKAGE_PIN W14 [get_ports {in[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {in[6]}]
set_property PACKAGE_PIN W13 [get_ports {in[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {in[7]}]
set_property PACKAGE_PIN V2 [get_ports {select[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {select[0]}]
set_property PACKAGE_PIN T3 [get_ports {select[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {select[1]}]
set_property PACKAGE_PIN T2 [get_ports {select[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {select[2]}]


## LEDs
set_property PACKAGE_PIN U16 [get_ports out_reg]					
	set_property IOSTANDARD LVCMOS33 [get_ports out_reg]
