mqttPubId = 123 -- mqtt publisher id
mqttBrokerClientId = node.chipid()
mqttBrokerHost = "<ip-address>"
mqttBrokerPort = 1883
mqttBrokerUsr = "<user>"
mqttBrokerPwd = "<password>"
mqttBrokerTopic = "/smartbutton/" .. mqttPubId .. "/alert"

function conn()
  mqttBroker:connect(mqttBrokerHost, mqttBrokerPort, 0, function(client)
    print ("Connected")

    print("Subscribing to topic " .. mqttBrokerTopic .. "...")
    -- subscribe topic with qos = 0
    client:subscribe(mqttBrokerTopic, 0, function(client)
      print("Subscription success")
    end)
  end,
  function(client, reason)
    print("Failed to connect: " .. reason)
  end)
end

-- Reconnect to MQTT when we receive an "offline" message.
function reconn()
  print("Disconnected, reconnecting....")
  conn()
end

-- Turn on gpio 2 and off after 5 sec.
function onMsg(_client, _topic, _data)
  print("Turning on gpio 2..")
  gpio.write(4, gpio.HIGH)

  tmr.create():alarm(5000, tmr.ALARM_SINGLE, function()
    print("Turning off gpio 2..")
    gpio.write(4, gpio.LOW)
  end)
end

function makeConn()
  mqttBroker = mqtt.Client(mqttBrokerClientId, 120, mqttBrokerUsr, mqttBrokerPwd)
  -- Set up the event callbacks
  print("Setting up callbacks")
  -- mqttBroker:on("connect", function(client) print ("connected") end)
  mqttBroker:on("offline", reconn)
  -- on publish message receive event
  mqttBroker:on("message", onMsg)
  -- Connect to the Broker
  conn()
end

makeConn()
