wifi_cfg={}
wifi_cfg.ssid="ssid"
wifi_cfg.pwd="pwd"

wifi.setmode(wifi.STATION)
wifi.sta.config(wifi_cfg)
wifi.sta.connect()

local t = tmr.create()

t:alarm(1000,tmr.ALARM_AUTO,function()
  if wifi.sta.getip() == nil then
    print("IP unavailable, Waiting.....")
  else
    t:stop(1)
    print("NodeMCU mode is: " ..wifi.getmode())
    print("The Module MAC address is: " ..wifi.ap.getmac())
    print("Config done, IP is: " ..wifi.sta.getip())

    conn = net.createConnection(net.TCP,0)
    conn:on('receive',function(conn,pl) print(pl) end)
    conn:connect(8080,'192.168.99.153')
    conn:send("GET / HTTP/1.1\r\nHost: www.nodemcu.com\r\n"
  .."Connection: keep-alive\r\nAccept: */*\r\n")

  end

end)
