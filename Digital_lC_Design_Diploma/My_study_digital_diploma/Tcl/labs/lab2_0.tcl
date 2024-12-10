puts  "**** List Operations Lab****"
set lst0 [list Jan Mar April May]
set lst1 {June July August}
puts "lst0 = $lst0"
puts "lst1 = $lst1"
puts "length of lst0 : [llength $lst0]"
puts " Third item of lst1 : [lindex $lst1 2]"

puts "[linsert $lst0 1 Feb]"
lappend lst1 Sep Oct Nov Dec
puts "$lst1"
set list2 [concat $lst0 lst1]
puts "[lrange $list2 0 6]"
puts "[join $list2 ","]"	
for {set a 0} {$a < [llength $lst0]} {incr a} {
	puts "[string tolower [lindex $lst0 $a]]"
}

foreach x $lst1 {
	puts "[string toupper $x]"  
}