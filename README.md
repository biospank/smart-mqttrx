# Smart-mqttrx

A receiver mqtt module (subscriber) to switch a GPIO (led, relay...). See [Smart-mqtttx](https://github.com/biospank/smart-mqtttx) publisher

It uses an esp8266-01 Espressif wi-fi module and [lua programming language](https://www.lua.org/).

It supports OTA wi-fi configuration.

## Installation

1. Flash [nodemcu](https://nodemcu-build.com/) firmware

    add `end user setup` and `MQTT` to the basic preselected modules.
    Download and flash using [esptool](https://github.com/espressif/esptool)

2. Fork this project


3. Upload files

    **Note**
    There are many `uploaders` out there, I use [nodemcu-uploader](https://github.com/kmpm/nodemcu-uploader)

    Make changes to `init.lua` to set your mqtt provider configuration and upload `init.lua`, `wifisetup.lua` and `mqttsub.lua` to the esp-01 module.

## License

   [The MIT License (MIT)](https://opensource.org/licenses/MIT).
