--file: mqtt_client.lua

local module = {}

function module.start_mqtt(conf)
    --initialize mqtt client
    m = mqttClient(conf["MQTTClientID"], 120) 
    --est last will
    m:lwt("/lwt", "offline",0,0) 
    --conn/disconn call-back handler
    m:on("connect", function(client) print("connected") end) 
    m:on("offline", function(client) print("disconnected") end) 

    --subscription message handler
    m:on("message" function(client, topic, data)
        print(topic ..  ":") 
        if data ~= nil then
            print(data)
        end 
    end)

    m:connect(conf["MQTTBroker"], conf["MQTTPort"], 0, function(client)
    print("connected") end ) 

    m:subscribe(conf["MQTTTopic"], 0 , function(client) print("subscribed")
    end) 

return module
