--file: main.lua

config = require("config")
wireless = require("wireless")
mqtt_client = require("mqtt_client")

wireless.wifi_start(config)
tmr.alarm(1,1000, 1, 
  function()
    if wifi.sta.getip()==nil then 
      print(" Wait to IP address!") 
    else 
      print("New IP address is "..wifi.sta.getip()) 
      tmr.stop(1) mqtt_client.connect(config) 
    end 
  end)


