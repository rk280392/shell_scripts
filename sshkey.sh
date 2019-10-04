#!/bin/bash
for server in `cat inventory`;
do 
	sshpass -p "password" ssh-copy-id -i ~/.ssh/id_rsa.pub username@$server &	
done

