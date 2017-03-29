#!/bin/bash
#
# Usage:
#   sudo ./connect.sh
#   sudo ./connect.sh <apn>
#   sudo ./connect.sh <apn> <user> <password>
#
#
APN=${1:-""}
USER=${2:-" "}
PASSWORD=${3:-" "}
ID=`id -u`
OPTIONS=options
if [ $ID -ne 0 ]
then
	echo "This script must be run with sudo!"
	exit 1
fi
echo "Start GPRS connect script for APN $APN USER $USER PASSWORD $PASSWORD"
. ./env.sh
echo "Starting PPP client on device $MODEM_TTY at speed $MODEM_SPEED with options file $OPTIONS"
pppd "$MODEM_SPEED" "$MODEM_TTY" lock file "$OPTIONS" user "${USER}" password "${PASSWORD}" connect "/usr/sbin/chat -v -s -E -T \"$APN\" -f ./gprs"
RC=$?
echo "PPP deamon returned code $RC"