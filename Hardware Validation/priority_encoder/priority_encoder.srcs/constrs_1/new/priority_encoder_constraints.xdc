#Set inputs
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {A[0]}];
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {A[1]}];
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {A[2]}];
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {A[3]}];
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports {A[4]}];
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {A[5]}];
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {A[6]}];
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {A[7]}];    
#Set outputs
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports {Y[0]}];
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {Y[1]}];
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33} [get_ports {Y[2]}];
#Valid button
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {valid}];



