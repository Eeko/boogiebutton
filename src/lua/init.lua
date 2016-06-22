--init.lua
wifiap = "<SSID_OF_ACCESSPOINT>"
wifipw = "<WPA_PASSWORD>"

firebasesecret = "<SECURITY_TOKEN_FROM_FIREBASE>"
firebaseurl = "<REST_URL>.json"  --eg. https://mydatabase.firebaseio.com/"
print("Booting up boogiebutton...")
wifi.setmode(wifi.STATION)
wifi.sta.config(wifiap,wifipw)
print("connecting to " .. wifiap)
p1=4 -- using gpio pin 4 of nodemcu
prevstateofswitch=0
gpio.mode(p1,gpio.INT)

function callFirebase(state)
	payload = cjson.encode({needmusic=state})
	print(payload)
	print(firebaseurl .."?auth="..firebasesecret)
	http.request(firebaseurl .."?auth="..firebasesecret, "PATCH", "Content-Type: application/json\r\n", payload, 
		function(code, data)
			if (code < 0) then
				print("HTTP request failed")
			else
				print(code)
			end
		end)
end
function debounce(func)  --debounce function for the switch
	-- debounce timer
	local last = 0
	local delay = 2000000
	return function(...)
		local now = tmr.now()
		local delta = now - last
		if delta < delay then return end
		last = now
		return func(...)
	end
end

function monitorSwitch()
	tmr.delay(200000)
	if gpio.read(p1) == 1 then
		print("Sending the turn on signal...")
		if prevstateofswitch == 0 then
			callFirebase("yes")
		else
                        -- to handle some errors
			print("...not actually calling firebase. switch was already down.")
		end
		prevstateofswitch = 1
	else
		print("Sending the turn off signal...")
		callFirebase("no") --always allow stopping
		prevstateofswitch = 0
	end
end



gpio.trig(p1, "both", debounce(monitorSwitch))
