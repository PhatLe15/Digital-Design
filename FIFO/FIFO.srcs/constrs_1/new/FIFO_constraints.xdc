# Clock signal
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33}           [get_ports {clk100MHz}];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk100MHz}];

# input switches
#D_in
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {D_in[0]}]; 
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {D_in[1]}];
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {D_in[2]}];
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {D_in[3]}];

#rst
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {rst}]; 
#en
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {en}]; 
#rnw
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {wnr}]; 

#clock button
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {clk_button}];

#D_out
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {D_out[0]}]; 
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports {D_out[1]}]; 
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {D_out[2]}]; 
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33} [get_ports {D_out[3]}];

#empty
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {empty}]; 

#full
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {full}];