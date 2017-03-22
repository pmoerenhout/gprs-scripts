#!/bin/bash
#
# Usage sudo ./connect.sh or sudo ./connect.sh apn
#
#
APN=${1:-internet}
ID=`id -u`
OPTIONS=options
if [ $ID -ne 0 ]
then
	echo "This script must be run with sudo!"
	exit 1
fi
echo "Start GPRS connect script for APN $APN"
. ./env.sh
echo "Starting PPP client on device $MODEM_TTY at speed $MODEM_SPEED with options file $OPTIONS"
pppd "$MODEM_SPEED" "$MODEM_TTY" lock file "$OPTIONS" connect "/usr/sbin/chat -v -s -E -T $APN -f ./gprs"
RC=$?
echo "PPP deamon returned code $RC"
