#!/usr/bin/env ruby

require './options'
require './app'

camera_app_options = ESP32CamHomeBusAppOptions.new

camera = ESP32CamHomeBusApp.new camera_app_options.options
camera.run!
