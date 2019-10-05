
# script generate random passwords for users passed as arguments


#check at least one argument is passed

if [[ "${#}" -lt 1 ]]
then 
	echo "USAGE : ${0} USER_NAME [USER_NAME] ...."
	exit 1
fi

# create password

for USER_NAME in "${@}"
do 
	PASSWORD=$(date +%s%N | sha256sum | head -c12)
	echo "${USER_NAME}: ${PASSWORD}"
done
