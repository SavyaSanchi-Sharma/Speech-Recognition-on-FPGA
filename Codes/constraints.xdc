## Clock (100 MHz onboard oscillator)
set_property PACKAGE_PIN K17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 20.000 -name sys_clk -waveform {0.000 10.000} [get_ports clk]

## Reset button (BTN0)
set_property PACKAGE_PIN D19 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

## RGB LED 0 (LD4) - Use these for LED output
set_property PACKAGE_PIN M14 [get_ports led_r]   
set_property IOSTANDARD LVCMOS33 [get_ports led_r]

set_property PACKAGE_PIN N15 [get_ports led_g]   
set_property IOSTANDARD LVCMOS33 [get_ports led_g]

set_property PACKAGE_PIN L14 [get_ports led_b]  
set_property IOSTANDARD LVCMOS33 [get_ports led_b]

## keyword_id[3:0] outputs (clearly assigned on PMOD JB pins, no conflicts)
set_property PACKAGE_PIN Y19 [get_ports {keyword_id[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keyword_id[0]}]

set_property PACKAGE_PIN Y16 [get_ports {keyword_id[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keyword_id[1]}]

set_property PACKAGE_PIN Y17 [get_ports {keyword_id[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keyword_id[2]}]

set_property PACKAGE_PIN W14 [get_ports {keyword_id[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keyword_id[3]}]
