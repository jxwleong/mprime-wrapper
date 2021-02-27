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
set list [file_to_list "local.txt"]
set list [update_list_data $list "NewCpuSpeed" 10]
list_to_file "temp.txt" $list
