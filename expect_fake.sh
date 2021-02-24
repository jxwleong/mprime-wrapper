#!/usr/bin/expect
spawn ./fake.sh

expect {
		"Number of torture test threads to run (8):"{
	    send -- "\r"; expect "\r"; log_user 0;
   		 expect -re "\[0-9\]"
  		 log_user 1
   		 set cpu_info $expect_out(buffer)
  	  # remove 2 blank line before print
    	set trimmed_cpu_info [string trim $cpu_info "\r\n"]
    	send_user $trimmed_cpu_info\n\n
    	exit 1;  exp_continue}
	

}
 
#expect -re  "\[0-9\]*" 

log_user 1
send_user $expect_out(buffer)
