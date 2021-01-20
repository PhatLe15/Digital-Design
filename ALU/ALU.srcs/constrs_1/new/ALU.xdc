#Switches
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { A[0] }];
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { A[1] }];
set_property -dict { PACKAGE_PIN W16 IOSTANDARD LVCMOS33 } [get_ports { A[2] }];
set_property -dict { PACKAGE_PIN W17 IOSTANDARD LVCMOS33 } [get_ports { A[3] }];
set_property -dict { PACKAGE_PIN W15 IOSTANDARD LVCMOS33 } [get_ports { B[0] }];
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports { B[1] }];
set_property -dict { PACKAGE_PIN W14 IOSTANDARD LVCMOS33 } [get_ports { B[2] }];
set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports { B[3] }];

#control
set_property -dict { PACKAGE_PIN V2 IOSTANDARD LVCMOS33 } [get_ports { ctrl[0] }];
set_property -dict { PACKAGE_PIN T3 IOSTANDARD LVCMOS33 } [get_ports { ctrl[1] }];
set_property -dict { PACKAGE_PIN T2 IOSTANDARD LVCMOS33 } [get_ports { ctrl[2] }];

# LEDs
set_property -dict { PACKAGE_PIN U16  IOSTANDARD LVCMOS33 } [get_ports { out[0] }]; 
set_property -dict { PACKAGE_PIN E19  IOSTANDARD LVCMOS33 } [get_ports { out[1] }]; 
set_property -dict { PACKAGE_PIN U19  IOSTANDARD LVCMOS33 } [get_ports { out[2] }]; 
set_property -dict { PACKAGE_PIN V19  IOSTANDARD LVCMOS33 } [get_ports { out[3] }]; 
set_property -dict { PACKAGE_PIN U15  IOSTANDARD LVCMOS33 } [get_ports { zero }]; 
set_property -dict { PACKAGE_PIN U14  IOSTANDARD LVCMOS33 } [get_ports { overflow }];
