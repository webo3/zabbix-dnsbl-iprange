#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "Usage: ./${0##*/} <ip> <blacklist service>"
	exit 1
fi

IPADDRESS=$1

# IP address validity check
if [[ ! ${IPADDRESS##*[[:space:]]} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
	echo "$1 is not a valid IP"
	exit 1
fi

# Converts resolved IP into reverse IP
REVIP=`sed -r 's/([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)/\4.\3.\2.\1/' <<< ${IPADDRESS##*[[:space:]]}`

# Performs the actual lookup against blacklists
if host -W 2 -t a $REVIP.$2 >/dev/null 2>&1; then
	((listed++))
	echo $listed
else
	echo "0"
fi

exit 0