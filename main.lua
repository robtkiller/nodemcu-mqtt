--file: main.lua

--get dependent modules
config = require("config")
wireless = require("wireless")
mqtt_client = require("mqtt_client")

--start wifi
wireless.wifi_start(config)

--wait for IP, then connect setup MQTT client
tmr.alarm(1,1000, 1, 
  function()
    if wifi.sta.getip()==nil then 
      print(" Wait to IP address!") 
    else 
      print("New IP address is "..wifi.sta.getip()) 
      tmr.stop(1) mqtt_client.connect(config) 
    end 
  end)


