#/bin/bash

# script creates users on the local machine

# check if root or not


if [[ "${UID}" -ne 0 ]]
then
	echo "Run as root"
	exit 1
fi

read -p "Please enter your username : " USER_NAME

STRLENGTH=$(echo -n $USER_NAME | wc -m)

if [[ "${STRLENGTH}" -lt 4 ]]
then
	echo "Please enter more then 4 characters"
	exit 1
fi

read -p "Please enter your password : " PASSWORD

read -p "Please enter your fullname : " FULLNAME

useradd -c "${FULLNAME}" -m "${USER_NAME}"

if [[ "${?}" -ne 0 ]]
then
	echo "Account cannot be created please try again"
	exit 1
fi

echo -e "${PASSWORD}\n${PASSWORD}"  | passwd "${USER_NAME}"

if [[ "${?}" -ne 0 ]]
then
	echo "Cannot set password please try again"
	exit 1
fi

passwd -e ${USER_NAME}

echo username : ${USER_NAME}
echo password : ${PASSWORD}
echo hostname : ${HOSTNAME}

exit 0
