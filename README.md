# Ireland Demo

This demo shows the Ireland (or Jakarta - it works for both) release of EdgeX with the following devices:

- Comet Systems T0310 temperature probe (Modbus RTU)
- Patlite Signal Tower (SNMP)
- Moisture sensor (GPIO)

*The device services customizations are included with this demo.  See the original device service repositories (below) for updates to the device service code*

- [Device Service Modbus](https://github.com/edgexfoundry/device-modbus-go)
- [Device Service SNMP](https://github.com/edgexfoundry/device-snmp-go)
- [Device Service GPIO Moisture](https://github.com/edgexfoundry/device-gpio)

It also demonstrates getting data to InfluxDB (via MQTT and Telegraf) for visual display.  This requires a custom application service to export the EdgeX sensor data out into InfluxDB line protocol format and sent to an MQTT topic where it is picked up by Telegraf and inserted into InfluxDB.

![image](./app-service-influx.png)

*The custom application service code is also available in this repository.

## Starting

To run the demo, perform the following operations:

1. Start Mosquitto Broker (mosquitto -c *your config path/file*)
2. Start InfluxDB and Telegraf
3. Start EdgeX (Ireland or Jakarta) using Docker Compose (docker-compose up -d in the ./compose/ folder). This Compose file has been modified for this demo (removal of security protections and non-use device services)
4. Start the device services and app service running on the same host using the start.sh script in this directory
5. Start the moisture device service running on a Raspberry Pi 3 (move the device-gpio to the RP2 and use start.sh script in the device-gpio directory)
6. Configure the rules on a new install/start (use the rules.sh script)


To stop the demo, perform the following operations:
1. Stop the device services and application service (use the halt.sh script)
2. Stope EdgeX using Docker Compose (docker-compose down in the ./compose/ folder)
3. Optionally stop Mosquitto, Telegraf and InfluxDB

