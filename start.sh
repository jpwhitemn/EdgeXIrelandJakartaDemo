#!/bin/sh
## Go to Device Modbus DS and start it
echo "Turning security services off"
export EDGEX_SECURITY_SECRET_STORE=false

echo "Starting device modbus - with temperature probe"
cd ./device-modbus-go/cmd
./device-modbus >/dev/null 2>&1 &
cd ../..

## Go to Device SNMP DS and start it
echo "Starting device SNMP - with Patlite"
cd ./device-snmp-go/cmd
./device-snmp >/dev/null 2>&1 &
cd ../..

## Go to App Service Influx and start it
echo "Starting App Service Influx"
cd ./app-service-influx
./app-service-influx >/dev/null 2>&1 &

echo "Device Services and App Service all started"

#wait
#echo "EdgeX demo done"

