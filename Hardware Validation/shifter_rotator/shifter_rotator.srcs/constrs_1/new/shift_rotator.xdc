# Input signals
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { x[0] }];
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { x[1] }];
set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS33 } [get_ports { x[2] }];
set_property -dict { PACKAGE_PIN W17 IOSTANDARD LVCMOS33 } [get_ports { x[3] }];

#control signals
set_property -dict { PACKAGE_PIN W15 IOSTANDARD LVCMOS33 } [get_ports { control[0] }];
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports { control[1] }];
set_property -dict { PACKAGE_PIN W14 IOSTANDARD LVCMOS33 } [get_ports { control[2] }];

# LEDs
set_property -dict { PACKAGE_PIN U16  IOSTANDARD LVCMOS33 } [get_ports { y[0] }]; 
set_property -dict { PACKAGE_PIN E19  IOSTANDARD LVCMOS33 } [get_ports { y[1] }]; 
set_property -dict { PACKAGE_PIN U19  IOSTANDARD LVCMOS33 } [get_ports { y[2] }]; 
set_property -dict { PACKAGE_PIN V19  IOSTANDARD LVCMOS33 } [get_ports { y[3] }]; 
