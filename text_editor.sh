#!/usr/bin/expect

proc read_file {filepath} {
	set fp [open $filepath r]
	set file_data [read $fp]
	close $fp
	puts $file_data
}

read_file "local.txt"
