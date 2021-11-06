#!/bin/sh
HOST_ADDR=10.0.0.35
SRV_PORT=59720
echo "Setting up the stream in Kuiper\n"
curl -X POST -H 'Content-Type: application/json' -d '{"sql": "create stream watches() WITH (FORMAT=\"JSON\", TYPE=\"edgex\")"}' http://$HOST_ADDR:$SRV_PORT/streams

echo "Setting up the turn on patlite rule\n"
curl -X POST -H 'Content-Type: applicaiton/json' -d '{ "id": "too-hot", 
  "sql": "SELECT ProbeTemperature FROM watches WHERE ProbeTemperature > 760", 
  "actions": [ 
    { 
      "rest": { 
        "url": "http://10.0.0.35:59882/api/v2/device/name/patlite/SetRedLightState",
	"method": "put", 
        "retryInterval": -1, 
        "dataTemplate": "{\"RedLightControlState\":\"2\",\"RedLightTimer\":\"1\"}", 
        "sendSingle": true 
      } 
    }, 
    { 
      "log":{} 
    } 
  ] 
}' http://$HOST_ADDR:$SRV_PORT/rules

echo "Setting up the turn off patlite rule\n"
curl -X POST -H 'Content-Type: applicaiton/json' -d '{ "id": "temp-right",
  "sql": "SELECT ProbeTemperature FROM watches WHERE ProbeTemperature <= 760",
  "actions": [
    {
      "rest": {
        "url": "http://10.0.0.35:59882/api/v2/device/name/patlite/SetRedLightState",
        "method": "put",
        "retryInterval": -1,
        "dataTemplate": "{\"RedLightControlState\":\"1\",\"RedLightTimer\":\"1\"}",
        "sendSingle": true
      }
    },
    {
      "log":{}
    }
  ]
}' http://$HOST_ADDR:$SRV_PORT/rules

curl -X POST -H 'Content-Type: applicaiton/json' -d '{ "id": "too-hot", 
  "sql": "SELECT ProbeTemperature FROM watches WHERE ProbeTemperature > 760", 
  "actions": [ 
    { 
      "rest": { 
        "url": "http://10.0.0.35:59882/api/v2/device/name/patlite/SetRedLightState",
	"method": "put", 
        "retryInterval": -1, 
        "dataTemplate": "{\"RedLightControlState\":\"2\",\"RedLightTimer\":\"1\"}", 
        "sendSingle": true 
      } 
    }, 
    { 
      "log":{} 
    } 
  ] 
}' http://$HOST_ADDR:$SRV_PORT/rules

echo "Setting up the turn off patlite rule\n"
curl -X POST -H 'Content-Type: applicaiton/json' -d '{ "id": "temp-right",
  "sql": "SELECT ProbeTemperature FROM watches WHERE ProbeTemperature <= 760",
  "actions": [
    {
      "rest": {
        "url": "http://10.0.0.35:59882/api/v2/device/name/patlite/SetRedLightState",
        "method": "put",
        "retryInterval": -1,
        "dataTemplate": "{\"RedLightControlState\":\"1\",\"RedLightTimer\":\"1\"}",
        "sendSingle": true
      }
    },
    {
      "log":{}
    }
  ]
}' http://$HOST_ADDR:$SRV_PORT/rules

echo "Setting up the moisture detected rule\n"
curl -X POST -H 'Content-Type: applicaiton/json' -d '{ "id": "moisture-detected",
  "sql": "SELECT Moisture FROM watches WHERE Moisture = false",
  "actions": [
    {
      "rest": {
        "url": "http://10.0.0.35:59882/api/v2/device/name/patlite/SetAmberLightState",
        "method": "put",
        "retryInterval": -1,
        "dataTemplate": "{\"AmberLightControlState\":\"2\",\"AmberLightTimer\":\"1\"}",
        "sendSingle": true
      }
    },
    {
      "log":{}
    }
  ]
}' http://$HOST_ADDR:$SRV_PORT/rules

echo "setting up the moisture not detected rule\n"
curl -X POST -H 'Content-Type: applicaiton/json' -d '{"id": "moisture-not-detected",
  "sql": "SELECT Moisture FROM watches WHERE Moisture = true",
  "actions": [
    {
      "rest": {
        "url": "http://10.0.0.35:59882/api/v2/device/name/patlite/SetAmberLightState",
        "method": "put",
        "retryInterval": -1,
        "dataTemplate": "{\"AmberLightControlState\":\"1\",\"AmberLightTimer\":\"1\"}",
        "sendSingle": true
      }
    },
    {
      "log":{}
    }
  ]
}' http://$HOST_ADDR:$SRV_PORT/rules

echo "Done setting rules\n\n"

