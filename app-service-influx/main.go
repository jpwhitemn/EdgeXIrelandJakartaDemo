// -*- Mode: Go; indent-tabs-mode: t -*-
//
// Copyright (C) 2020 IOTech Systems LTD
//
// SPDX-License-Identifier: Apache-2.0

package main

import (
	"fmt"
	"os"

	influxTransforms "app-service-influx/pkg/transforms"
	"github.com/edgexfoundry/go-mod-core-contracts/v2/clients/logger"
	"github.com/edgexfoundry/app-functions-sdk-go/v2/pkg/transforms"
	"github.com/edgexfoundry/app-functions-sdk-go/v2/pkg"
)

var log logger.LoggingClient
const serviceKey = "app-service-influx"

func main() {

	service, ok := pkg.NewAppService(serviceKey)
	if !ok {
		os.Exit(-1)
	}

	log := service.LoggingClient()
	mqttConfig := transforms.MQTTSecretConfig{}

	appSettings := service.ApplicationSettings()

	if appSettings != nil {
		mqttConfig.BrokerAddress = getAppSetting(appSettings, "BrokerAddress", log)
		mqttConfig.Topic = getAppSetting(appSettings, "Topic", log)
		mqttConfig.ClientId = getAppSetting(appSettings, "Publisher", log)
		//mqttConfig.AuthMode = "usernamepassword"
		//mqttConfig.SecretPath = "mqtt"
	} else {
		log.Error("No application-specific settings found")
		os.Exit(-1)
	}

	mqttSender := transforms.NewMQTTSecretSender(mqttConfig, false)

	if err := service.SetFunctionsPipeline(
		influxTransforms.NewConversion().TransformToInflux,
		mqttSender.MQTTSend,
	); err != nil {
		log.Error(fmt.Sprintf("Service SetPipeline failed: %v\n", err))
		os.Exit(-1)
	}

	err := service.MakeItRun()
	if err != nil {
		log.Error("MakeItRun returned error: ", err.Error())
		os.Exit(-1)
	}

	// Do any required cleanup here
	os.Exit(0)
}

func getAppSetting(settings map[string]string, name string, log logger.LoggingClient) string {

	value, ok := settings[name]
	if ok {
		log.Debug(value)
		return value
	}
	log.Error(fmt.Sprintf("application setting %s not found", name))
	return ""
}
