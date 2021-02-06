#!/usr/bin/expect -f

# Script to run mprime using expect
set stress_type [lindex $argv 0]
set user_input_timeout [lindex $argv 1]

set timeout $user_input_timeout
set stress_type [string toupper $stress_type]

set default_timeout 60

##spawn -ignore HUP bash
#spawn bash
#send "apt-get update\r"
#catch wait result
#after 30000

proc get_stress_selection {stress_arg} {
    if { $stress_arg == "SMALL" } {
      return 1
    } elseif { $stress_arg == "INPLACE" } {
        return 2
    } else {
        return 3
    }
}

proc is_integer {value} {
    set is_digit [string is digit $value]
    if { $is_digit } {
        return true
    } else {
        return false
    }
}

proc set_timeout {user_input} {
    global timeout
    global default_timeout
    # Remove parenthesis for user_input
    # No idea why the argument encapsulated in
    # parenthesis, maybe due to the language
    set user_input [string map {{(} "" {)} ""} $user_input]
    puts $user_input
    if { [is_integer $user_input] } {
        set timeout $user_input
        puts "Timeout configured: $timeout seconds"
    } else {
        set timeout $default_timeout
      puts "Default timeout: $timeout seconds"
    }
}

set stress_selection [get_stress_selection $stress_type]
set_timeout ($user_input_timeout)

spawn mprime

expect {
 # Choose Just stress testing
    "Join Gimps? (Y=Yes, N=Just stress testing) (Y):" {
    send -- "N\r"; exp_continue }

    # Select 8 threads
    "Number of torture test threads to run (8):" {
    send -- "8\r"; exp_continue }

    # 1 = Small
    # 2 = In-place large
    # 3 = Blend
    "Type of torture test to run (3):" {
    send -- "$stress_selection\r"; exp_continue}

    "Accept the answers above? (Y):" {
    send -- "Y\r"; exp_continue}

    # At main menu
    # Select Options/Torture Test
    "Your choice: " {
    send -- "15\r"; exp_continue}

    timeout {
    puts "$timeout seconds is UP"
    exit 1}

}
