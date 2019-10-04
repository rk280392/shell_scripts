#!/bin/bash

# find uid of user

echo "Your UID  is ${UID}"

#Find username

USER_NAME=$(id -un)
echo "Your Username is ${USER_NAME}"

#check root or not

if [[ "${UID}" -eq 0 ]]
then
	echo "You are root"
else
	echo "You are not root"
fi
