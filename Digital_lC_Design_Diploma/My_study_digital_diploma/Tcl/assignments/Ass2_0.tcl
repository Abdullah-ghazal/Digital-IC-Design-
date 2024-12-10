puts "****Assignment 2.0****"
set cities {cairo alexandria damietta dakahlia faiyum sohag aswan}
set Cities_New [list]
foreach x $cities {
	set tit [string totitle $x]
	lappend Cities_New $tit	
}

puts $Cities_New


