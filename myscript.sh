for ip in $(chilli_query /var/run/chilli/3/chilli.sock list | grep 70-6D | awk '{print $2}')
	do
	sshpass -p 'password' ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$ip  'cat /etc/config/system  | grep my_server | grep -v unibox'

done
