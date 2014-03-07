##read -format verilog -hierarchy -out netlist/$design_name.syn.v ;

# Writing Standard Delay Format (SDF) back-annotation file.
# This delay information can be used for post-synthesis simulation.
#write_sdf sdf/$design_name.sdf;
#reset_design 

############################################################
### scan chain generation                                ###
############################################################

# SCAN SETUP

set hdlin_enable_rtldrc_info true
set test_dft_drc_ungate_internal_clocks true

# setup the view
create_port -direction "in"  {I_SCAN_IN };
#create_port -direction "in"  {I_SCAN_MODE} ;
create_port -direction "in"  {I_SE} ;
#create_port -direction "in"  {I_SCAN_RST} ;
create_port -direction "out" {O_SCAN_OUT} ;
##create_port -direction "in" {I_SCAN_CLK};

set_auto_disable_drc_nets -scan true
#set_ideal_network -no_propagate I_SE
#set_ideal_network -no_propagate I_SCAN_MODE

#set_ideal_network -no_propagate I_SCAN_RST
# RTL-LEVEL DRC (DESIGN RULE CHECK)
set test_enable_dft_drc true
##100.00
set test_default_period 100.00	
set test_default_delay 0.00
set test_default_bidir_delay 0.00
set test_default_strobe 40.00
set test_default_strobe_width 1.00

#set_dft_configuration -fix_clock enable
#set_dft_configuration -fix_reset  enable
#set_dft_configuration -fix_set enable

# Defining Test Signals 
set_dft_signal -view existing_dft -type Reset -active_state 1 -port [get_ports I_SCAN_RST]
##set_dft_signal -view spec -type Reset -active_state 1 -port [get_ports I_SCAN_RST]

##set_dft_signal -view existing_dft -type Reset -active_state 0 -port [get_ports I_SCAN_RST]

set_dft_signal -view existing_dft -type ScanClock -port clk  -timing [list 45 55] 	

##set_dft_signal -view existing_dft -type ScanEnable -active_state 1 -port [get_ports I_SE]
set_dft_signal -view spec -type ScanEnable -active_state 1 -port [get_ports I_SE]

set_dft_signal -view existing_dft -type TestMode -active_state 1 -port [get_ports I_SCAN_MODE]	
set_dft_signal -view spec -type TestMode -active_state 1 -port [get_ports I_SCAN_MODE]

set_dft_signal -view spec -type ScanDataIn -port [get_ports I_SCAN_IN]
set_dft_signal -view spec -type ScanDataOut -port [get_ports O_SCAN_OUT]

define_test_mode Internal_scan -encoding {I_SCAN_MODE 1}

##set_test_assume 1 [get_ports I_SCAN_MODE]

# Test Attributes
set_scan_configuration -style multiplexed_flip_flop -chain_count 1 -add_lockup true -test_mode Internal_scan 
##-clock_mixing mix_edges 

##set_test_assume 1 reset 

##current_scan_mode Internal_scan
##current_scan_mode Internal_scan
create_test_protocol 

##current_scan_mode Internal_scan
# rtl-level drc
dft_drc

# SCAN SYNTHESIS
compile -scan

#set_scan_configuration -chain_count 1 

set_scan_configuration -style multiplexed_flip_flop -chain_count 1 -add_lockup true -test_mode Internal_scan 
##-clock_mixing mix_edges 
# scan insertion
preview_dft
insert_dft 

write_test_protocol -out src/$design_name.spf 

#compile -scan -incremental

# post-scan drc
#dft_drc -coverage_estimate 
dft_drc -coverage_estimate > report/$design_name.coverage ;

####################REPORT PRINTING ########################################################################################################
report_qor						> report/$design_name.overall ;

report_timing 					> report/$design_name.timing ;

report_area 					> report/$design_name.area ;

report_power 					> report/$design_name.power ; # can be asked to report power

#report_net 						> report/$design_name.net ;
#report_cell 					> report/$design_name.cell ;
#report_port -v 					> report/$design_name.port ;

error_info 						> report/$design_name.errors ; # important

report_constraint               > report/$design_name.constraint

report_constraint -all_violators > report/$design_name.violations

##############################################################################################################################################

# SCAN EXTRACTION AND REPORT
# Writing synthesized gate-level verilog netlist.
# This verilog netlist will be used for post-synthesis gate-level simulation.
change_names -rules verilog -hierarchy ;
write -format verilog -hierarchy -out netlist/$design_name.syn.v ;

###################################################
write_scan_def -output ./dft/$design_name.scandef ;
write_test_protocol -o ./dft/$design_name.stil ;
#write_test_protocol –out > ./dft/$design_name.spf ;

# Writing Standard Delay Format (SDF) back-annotation file.
# This delay information can be used for post-synthesis simulation.
write_sdf sdf/$design_name.sdf;
