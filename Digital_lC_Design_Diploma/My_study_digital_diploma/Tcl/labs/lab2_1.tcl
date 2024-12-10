puts  " **** Arrays & Procedures **** "
array set Mohamed {Waves 70 Electronics 85 Control 65 Comm 78}
array set Ahmed {Waves 66 Electronics 80 Control 88 Comm 69}
array set Mostafa {Waves 72 Electronics 77 Control 70 Comm 88}

proc Avg{gpa} {
	upvar $gpa arr
	
	set sum 0
	set num [array size arr]
	
	set arr_keys [array names arr]
	
	for x $arr_keys{
		set sum [expr $sum + $arr(x)]
	}
	
	return [expr $sum/$num]
	

}
set v [Avg Ahmed]
puts $v



