# Clock signal
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33}           [get_ports {clk100mHz}];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk100mHz}];

# input switches
#input1
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {in1[0]}]; 
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {in1[1]}]; 
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {in1[2]}]; 
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {in1[3]}]; 
#input2
set_property -dict {PACKAGE_PIN W2 IOSTANDARD LVCMOS33} [get_ports {in2[0]}]; 
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {in2[1]}]; 
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {in2[2]}]; 
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {in2[3]}];

#clock button
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {CLK_db}];
#go button
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {go}];
#reset button
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports {rst}];

#op switches
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {op[1]}];
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {op[0]}];

set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {done}]; # output LED


#LED selection
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[0]}]; # AN0
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[1]}]; # AN1
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[2]}]; # AN2
set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[3]}]; # AN3

#LED output
set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[0]}]; # CA
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[1]}]; # CB
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[2]}]; # CC
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[3]}]; # CD
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[4]}]; # CE
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[5]}]; # CF
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[6]}]; # CG
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[7]}]; # DP


