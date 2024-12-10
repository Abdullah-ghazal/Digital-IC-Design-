puts  " **** String Manipulation Lab **** "
set str1 MahmoudAhmed@gmail.com
set str2 MostafaAli@hotmail.com
puts "The length of str1 is [string length $str1]"
set str1upp = [string first @ $str1]
set "str1 Email Name is [string range $str1 0 $str1upp-1  ]"
puts "Domain Name of str2 is [String range $str2  10 22]"
append str3 {$str1}{}{hotmail.com}

