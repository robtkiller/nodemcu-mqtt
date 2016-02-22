--file: mqtt_client.lua

local module = {}

function module.connect(conf)

    function heartbeat(client,c)
      tmr.alarm(6,30000,1, function()
        client:publish(c["MQTTTopic"],"heartbeat",0,0) end)
    end
 
    if wifi.sta.getip() == nil then
      print("Waiting for networking...")
    else
      --initialize mqtt client
      m = mqtt.Client(conf["MQTTClientID"], 120)
      --est last will
      m:lwt("/lwt", "offline",0,0)
      --conn/disconn call-back handler
      m:on("connect", function(client) print("connected") end)
      m:on("offline", function(client) print("disconnected") end)

      --subscription message handler
      m:on("message", function(client, topic, data)
          print(topic ..  ":")
          if data ~= nil then
              print(data)
          end
      end)

      m:connect(conf["MQTTBroker"], conf["MQTTPort"], 0, 
        function(client)
          print("connected")
          m:subscribe(conf["MQTTTopic"], 0 , 
            function(client) 
              print("subscribed")
              heartbeat(m,conf) 
            end)
        end)
    end
end

return module
