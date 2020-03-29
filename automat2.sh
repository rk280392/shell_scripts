#!/usr/bin/expect
#
#

set timeout 60
set prompt "(%|#|\\$|%\]) $"
set fid [open ./hosts.list r]
set contents [read -nonewline $fid]
close $fid
stty echo
send_user "\nUsername for SSH connection: "
expect_user -re "(.*)\n" {set sshname $expect_out(1,string)}
send_user "\nPassword for SSH user: "
stty -echo
expect_user -re "(.*)\n" {set sshpassword $expect_out(1,string)}
stty echo
foreach host [split $contents "\n"] {
spawn ssh -o StrictHostKeyChecking=no $sshname@$host
expect {
  "assword:" { send -- "$sshpassword\r"
  }
  "you sure you want to continue connecting" {
  send -- "yes\r"
  expect "assword:"
  send -- "$sshpassword\r"
  }
}
expect -re "$prompt"
send -- "sudo su -\r"
expect {
  "assword:" { send -- "$sshpassword\r"
  expect -re "$prompt"
  }
  -re "$prompt"
}
# execute commands
send -- "apt-get update -y\r"
expect -re "$prompt"

send -- "apt-get install expect -y\r"
expect -re "$prompt"
send -- "echo '*/7 * * * * /tmp/rajeh.txt &> /dev/null' >> /etc/crontab\r"
expect -re "$prompt"
send -- "exit\r"

}
