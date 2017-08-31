#!/bin/bash
#
# Usage:
#   sudo ./connect.sh <chatfile>
#   sudo ./connect.sh <chatfile> <apn>
#   sudo ./connect.sh <chatfile> <apn> <user> <password>
#
#
CHATFILE=${1:-"./gprs"}
APN=${2:-""}
USER=${3:-" "}
PASSWORD=${4:-" "}
ID=`id -u`
OPTIONS=options
if [ $ID -ne 0 ]
then
	echo "This script must be run with sudo!"
	exit 1
fi
echo "Start GPRS connect script for APN $APN USER $USER PASSWORD $PASSWORD"
. ./env.sh
echo "Starting PPP client on device $MODEM_TTY at speed $MODEM_SPEED with options file $OPTIONS and chat file $CHATFILE"
pppd "$MODEM_SPEED" "$MODEM_TTY" lock file "$OPTIONS" user "${USER}" password "${PASSWORD}" connect "/usr/sbin/chat -v -s -E -T \"$APN\" -f $CHATFILE"
RC=$?
echo "PPP deamon returned code $RC"