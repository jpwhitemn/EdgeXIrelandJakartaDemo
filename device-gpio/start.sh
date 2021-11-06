#!/bin/sh
## Go to Device GPIO DS and start it
echo "Turning security services off"
export EDGEX_SECURITY_SECRET_STORE=false

echo "Starting device gpio - to detect moisture"
cd ./cmd
./device-gpio >/dev/null 2>&1 &
cd ../..

echo "Device Service started"

#wait

