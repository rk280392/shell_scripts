#!/bin/bash

backup_file() {
	
	local FILE="${1}"
	# check if file exist
	if [[ -f "${FILE}" ]]
	then
		local BACKUP_FILE="/path/to/backup/$(basename ${FILE}).$(date +%F-%N)"
		echo "Backing up ${FILE} to ${BACKUP_FILE}"
		

		#the exit status of function will be exit status of cp command
		cp -p ${FILE} ${BACKUP_FILE}   # p to preserver the time stamp of file
	else
		echo "file doesn't exist"
		# file doesn't exists retun no zero exit status
		return 1
	fi
}

# calling the function

backup_file '/file/to/backup'

# making decision based on exit status

if [[ "${?}" -eq 0 ]]
then
	echo "File backedup successfully"
else
	echo "File backup failed"
	exit 1
fi
