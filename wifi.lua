--file: wifi.lua

local module = {}

local function wifi_wait()
  if wifi.sta.getip() == nil then
    print("Waiting for IP...")
  else
    tmr.stop(1)
    print("\n=====")
    print("Mode is:" .. wifi.getmode())
    print("MAC addr is: " .. wifi.ap.getmac())
    print("IP is " .. wifi.sta.getip())
    print("=====")
  end
end

function module.wifi_start(conf)
  if conf then
    wifi.setmode(wifi.STATION)
    wifi.sta.config(conf["SSID"],conf["Password"])
    wifi.sta.connect()
    print("Connecting...")
    tmr.alarm(1,2500,1,wifi_wait)

  else
    print("Error getting Config")
  end
end

return module
