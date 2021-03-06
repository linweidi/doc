####################################################################################
# EE-577b - Fall 2012
# Lab 6
# DesignCompiler synthesis script for any Design with Scan Cells
#
# use this script as a template for synthesis
# 
# Developed by - Biraja Dash, Akash Jain
# Date: 12/5/2012
####################################################################################

# Setting variables for synthesis
set design_name Digital_Timer ;


set clk_period 10.0;
set posedge 0.0;
set negedge [expr $clk_period * 0.5];

# Reading source verilog file.
# Copy your verilog file into ./src/ before synthesis.
read_verilog ./src/Digital_Timer.v ;

# Setting $design_name as current working design.
# Use this command before setting any constraints.
current_design $design_name ;

# If you have multiple instances of the same module,
# use this so that DesignCompiler optimizea each instance separately
uniquify ;

# Linking your design into the cells in standard cell libraries.
# This command checks whether your design can be compiled
# with the target libraries specified in the .synopsys_dc.setup file.
link ;

# Setting timing constraints for sequential logic.
# => clock period, input delay, output delay

# (1) Setting clock period.
create_clock -name "clk" -period $clk_period -waveform [list $posedge $negedge] [get_ports clk];

# (2) Setting addtional constraints for clock signal,
# so that clock network should be ideal network without any buffers.
set_dont_touch_network {"clk"  "rst"} ;
set_ideal_network {"clk" "rst"} ;

# (3) Setting input path delays on input ports(except clock) relative to a clock edge .
# Input signals will arrive after this delay.
set_input_delay 0.2 -max -clock clk [remove_from_collection [all_inputs] [get_ports {"clk" "rst"}]] ;

# (4) Setting output path delays on output ports relative to a clock edge.
# output signals should be generated before this delay.
set_output_delay 0.2 -clock clk [all_outputs] ;

# "check_design" checks the internal representation of the
# current design for consistency and issues error and
# warning messages as appropriate.
check_design > report/$design_name.check_design ;

# Perforing synthesis and optimization on the current_design.
compile ;

# For better synthesis result, use "compile_ultra" command.
# compile_ultra is doing automatic ungrouping during optimization,
# therefore sometimes it's hard to figure out the critical path 
# from the synthesized netlist.
# So, use "compile" command for HW#5.

# Writing the synthesis result into Synopsys db format
# You can read the saved db file into DesignCompiler later using
# "read_db" command for further analysis (timing, area...).
#write -xg_force_db -format db -hierarchy -out db/$design_name.db ;

# Generating timing and are report of the synthezied design.
#report_timing > report/$design_name.timing ;
#report_area > report/$design_name.area ;

