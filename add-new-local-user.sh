#!/bin/bash

# check if user is root

if [[ "${UID}" -ne 0 ]]
then
	echo "Please run as root"
	exit 1
fi

# get username
read -p " Enter your username : " USER_NAME 

STRLENGTH=$(echo -n $USER_NAME | wc -m)

if [[ "${STRLENGTH}" -lt 4 ]]
then
	echo "Please enter at least 4 charatcters "
	exit 1
fi

# get fullname

read -p " Enter full name : "  FULL_NAME

# get password
read -p " Enter the password : " PASSWORD

# create user
useradd -c "${FULL_NAME}" -m ${USER_NAME}

# exit if user creation failes
if [[ "${?}" -ne 0 ]]
then
	echo "Account cannot be created."
	exit 1
fi

# set password
echo -e "$PASSWORD\n$PASSWORD" | passwd  ${USER_NAME}

# exit if password set failed
if [[ "${?}" -ne 0 ]]
then
	echo "Password set failed."
	exit 1
fi

#expire password 
passwd -e ${USER_NAME}

# display details
echo 

echo "username: " "${USER_NAME}"
echo
echo "password: " "${PASSWORD}"
echo
echo "host: " "${HOSTNAME}"
