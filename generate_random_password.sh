#!/bin/bash

usage() {
	echo "Uage: ${0} [-vs] [-l LENGTH]" >&2
	echo "Generating a random password"
	echo ' -l LENGTH specify the langth of password you require'
	echo " -s A special charater will be appended to the end of password"
	echo ' -v set verbosity to true'
	exit 1
}

log() {
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = true ]]
	then
		echo "${MESSAGE}"
	fi
}

length=48

while getopts vl:s OPTION
do 
	case ${OPTION} in
		v)
			VERBOSE='true'
			log 'Verbose mode is on.'
			;;
		l)
			length="${OPTARG}"
			;;
		s)
			USE_SPECIAL_CHARACTER='true'
			;;
		?)
			usage
			;;
	esac
done

log "Generating the password."

PASSWORD=$(date +%s${RANDOM}$RANDOM | sha256sum | head -c${length})

if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
	log "Selecting random character"
	SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+=' | fold -w1 | shuf | head -c1)
	PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done, your password is: '
echo ${PASSWORD}
