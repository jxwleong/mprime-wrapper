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
	set list [lreplace $list $idx $idx]
	return $list
}

proc process_file_data {filepath} {
    set fp [open $filepath r]
    set file_data [read $fp]
    close $fp

	set data [split $file_data "\n"]
	set data [remove_list_element $data "NewCpuSpeed=*"]
	puts $data
	#	foreach line $data {
#		puts "1$data"
#	}

}

process_file_data "local.txt"

