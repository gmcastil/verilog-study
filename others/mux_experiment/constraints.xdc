## This file is a general .xdc for the Basys3 rev B board
## Switches
set_property PACKAGE_PIN V17 [get_ports in_0]					
	set_property IOSTANDARD LVCMOS33 [get_ports in_0]
set_property PACKAGE_PIN V16 [get_ports in_1]
        set_property IOSTANDARD LVCMOS33 [get_ports in_1]
set_property PACKAGE_PIN W16 [get_ports in_2]					
	set_property IOSTANDARD LVCMOS33 [get_ports in_2]
set_property PACKAGE_PIN W17 [get_ports in_3]					
	set_property IOSTANDARD LVCMOS33 [get_ports in_3]
set_property PACKAGE_PIN W15 [get_ports in_4]					
	set_property IOSTANDARD LVCMOS33 [get_ports in_4]
set_property PACKAGE_PIN V15 [get_ports in_5]					
	set_property IOSTANDARD LVCMOS33 [get_ports in_5]
set_property PACKAGE_PIN W14 [get_ports in_6]					
	set_property IOSTANDARD LVCMOS33 [get_ports in_6]
set_property PACKAGE_PIN W13 [get_ports in_7]					
	set_property IOSTANDARD LVCMOS33 [get_ports in_7]

set_property PACKAGE_PIN V2 [get_ports {select[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {select[0]}]
set_property PACKAGE_PIN T3 [get_ports {select[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {select[1]}]
set_property PACKAGE_PIN T2 [get_ports {select[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {select[2]}]

## LEDs
set_property PACKAGE_PIN U16 [get_ports out]
        set_property IOSTANDARD LVCMOS33 [get_ports out]
