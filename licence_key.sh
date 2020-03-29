#!/usr/bin/expect


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
spawn ssh -p2223 -o StrictHostKeyChecking=no $sshname@$host
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
send -- "mysql -uroot -ppassword unibox -e 'select * from license_key'\r"
expect -re "$prompt"
send -- "exit\r"

}
