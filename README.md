Boogiebutton
============

Code and frontend- examples for creating an "Emergency party button" with NodeMCU and a standard emergency-stop switch. Uses Firebase.io for backend data storage, so one needs to flash the NodeMCU with a custom HTTP & TLS supporting firmware.

The frontend examples are simple html with some javascript, websocket to Firebase and multimedia elements. The purpose of this project is to toy around with website actions triggerable from outside sources.

In the example, the NodeMCU is wired pretty much like this.

       +--Switch---+ 
       |           | 
       |           | 
     IO-PIN.4     GND

Not the most robust of constructs nor the most stable one, but does her job.

NodeMCU connects to Firebase via Wi-Fi, so you should replace the <SSID_OF_ACCESSPOINT> and <WPA_PASSWORD> -placeholders from src/lua/init.lua with your own.

You also need to replace the <REST_URL> -placeholder from src/lua/init.lua and all sample index.html's with the URL of your firebase database. Also remember to configure your Firebase to require a security token for all write-oprations. This should be inserted in <SECURITY_TOKEN_FROM_FIREBASE> -placeholder in src/lua/init.lua.

You also need your own audio samples for the songplay -example. Add them as audio.(ogg|acc) to the same directory where you have the html/songplay/index.html .

There are also sample Python commands at src/py/ for turning the website action on or off.

See the button in action at https://youtu.be/72UsQpWnJ_k
