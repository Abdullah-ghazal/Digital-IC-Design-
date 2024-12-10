puts "****Writing Verilog Block Interface****"
set modname "Up_Dn_Counter"
set in_ports "IN Load Up Down CLK"
set in_ports_width "4 1 1 1 1"
set out_ports "High Counter Low"
set out_ports_width "1 4 1"
puts "module $modname ("
puts "input \[ [expr [lindex $in_ports_width 0] - 1]:0 \] [lindex $in_ports 0],"
puts "input [lindex $in_ports 1],"
puts "input [lindex $in_ports 2],"
puts "input [lindex $in_ports 3],"
puts "input [lindex $in_ports 4],"
puts "output [lindex $out_ports 0],"
puts "output \[ [expr [lindex $out_ports_width 1] - 1]:0 \] [lindex $out_ports 0],"
puts "output [lindex $out_ports 0]"
puts ");"


		