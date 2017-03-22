#!/bin/bash
OS=`uname`
if [ "$OS" = "Darwin" ]
then
	if [ -e "/dev/cu.usbserial-00002114B" ]
	then
		export MODEM_TTY=/dev/cu.usbserial-00002114B
		export MODEM_SPEED=115200
	fi;
fi
export LANG=en_GB
export LC_CTYPE=C
echo "MODEM TTY:$MODEM_TTY SPEED:$MODEM_SPEED"
if [ "$OS" = "Darwin" ]
then
        stty -f $MODEM_TTY ispeed $MODEM_SPEED ospeed $MODEM_SPEED cread crtscts
elif [ "$OS" = "Linux" ]
then
        stty -F $MODEM_TTY ispeed $MODEM_SPEED ospeed $MODEM_SPEED
else
        echo "Unknown OS"
        exit 1
fi
