#!/bin/bash
echo "Stopping Device GPIO"
MODPID=`pgrep -f "device-gpio"`
if [ "$MODPID" == "" ]; then
	echo " device gpio not running"
else
	kill -9 $MODPID
fi

echo "Done"

