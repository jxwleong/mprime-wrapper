#!/usr/bin/expect

proc read_file {filepath} {
	set fp [open $filepath r]
	set file_data [read $fp]
	close $fp
	puts $file_data
}

read_file "local.txt"

proc remove_list_element {list element} {
	set idx [lsearch $list $element]
	if {$idx >= 0} {
		set list [lreplace $list $idx $idx]
	}
	return $list
}


# Split the file line via '\n'
proc file_to_list {filepath} {
    set fp [open $filepath r]
    set file_data [read $fp]
    close $fp

	set data [split $file_data "\n"]
	return $data
}

proc list_to_file {filepath list} {
	set fp [open $filepath w+]

	set list [join $list "\n"]
	puts $list
	puts -nonewline $fp $list	

}



proc update_list_data {list variable new_value} {
    set idx [lsearch $list "$variable=*"]
	if {$idx >= 0} {
		set updated_data [regsub "$variable=." [lindex $list $idx] "$variable=$new_value"]
		set updated_list [lreplace $list $idx $idx $updated_data]
		return $updated_list
	}
}

proc get_list_variable_value {list variable delim} {
	set idx [lsearch $list "$variable$delim*"]
	if {$idx >= 0} {
		# {...} Group expression together can't use variable
		# "..." Use this if got variable, but remember to escape
		# '\' for character with special meaning for tcl
		set variable_re "\[^$delim\]+$"
		regexp $variable_re [lindex $list $idx] value	
		return $value
	}
}

proc remove_ansi_code_in_string {string} {
	# \x1b - ESCAPE
	# [^m]* - Beginning till 'm'
	# m - Remove 'm'
	set clean_string [regsub -all {\x1b[^m]*m} $string {}]
	return $clean_string
}

set list [file_to_list "local.txt"]
set list [update_list_data $list "NewCpuSpeed" 10]
set value [get_list_variable_value $list "NewCpuSpeed" "="]
puts $value
list_to_file "temp.txt" $list

puts [remove_ansi_code_in_string "\033\[01;31mLOL\033\[01;0m\n\r"]


