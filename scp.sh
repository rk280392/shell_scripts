#!/bin/bash 

# scp a file to multiple devices

# Only works if ssh-keygen is passed to all servers in inventory file
parallel-scp -v -h inventory -lusername filename.txt /tmp

