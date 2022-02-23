#!/bin/bash

###############################
# Validate a username was given
###############################

if [[ $# -ne 2 ]] ; then
	echo "[!] ERROR: Missing username and/or group parameters"
	echo "[*] Usage: $0 <username> <group>"
	exit 0
fi


#################################
# Run dscl against the given name
#################################

userName=$1
groupName=$2
memberof=$(dseditgroup -o checkmember -m $userName $groupName)


#################################
# Print results
#################################

border="=============================="

echo ""
echo $border
echo "Group Membership Check: $userName"
echo $border
echo ""

echo $memberof
