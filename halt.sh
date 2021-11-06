#!/bin/bash
echo "Stopping Device Modbus"
MODPID=`pgrep -f "device-modbus"`
if [ "$MODPID" == "" ]; then
	echo " device modbus not running"
else
	kill -9 $MODPID
fi
echo "Stopping Device SNMP"
SNMPPID=`pgrep -f "device-snmp"`
if [ "$SNMPPID" == "" ]; then
	echo " device SNMP not running"
else 
	kill -9 $SNMPPID
fi
echo "Stopping App Service Influx"
APPPID=`pgrep -f "app-service-influx"`
if [ "$APPPID" == "" ]; then
	echo " app service influx not running"
else
	kill -9 $APPPID
fi

echo "Done"

