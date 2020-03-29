#/bin/bash

if [[ "${UID}" -ne 0 ]]
then
	echo "Please run the script as root"
	exit 1
fi


if [[ "${#}" -lt 1 ]]
then
	echo "USAGE ${0} USER_NAME [COMMENT] ..."
	exit 1
fi

USER_NAME=${1}
echo ${USER_NAME}

shift
COMMENT="${@}"

echo ${COMMENT}

PASSWORD=$(date + %s%N | sha256sum | head -c 24)
echo "${PASSWORD}"

useradd -c "${COMMENT}" -m "${USER_NAME}"

if [[ "${?}" -ne 0 ]]
then
	echo "User account creation failed"
	exit 1
fi

echo -e "${PASSWORD}\n${PASSWORD}" | passwd "${USER_NAME}"


if [[ "${?}" -ne 0 ]]
then
	echo "Coundn't set password"
	exit 1
fi

passwd -e "${USER_NAME}"


echo UserName : "${USER_NAME}"
echo Password : "${PASSWORD}"
echo hostname : "${HOSTNAME}"

exit 0
