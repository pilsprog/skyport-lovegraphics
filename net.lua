function connect(ip,port)
	conn = lube.tcpClient()
	local table = {
		message = "connect",
		revision = 1,
		password = "supersecretpassword"
	}
	conn.handshake = false
	--conn.handshake = json.encode(table,{indent = false}) .. "\n"
	conn:setPing(false)
	conn:connect(ip, port, true)
	conn:send(json.encode(table,{indent = false}).."\n")
	conn.callbacks.recv = rcvCallback
	if not conn.connected then crogbteobvoer() end
end


function rcvCallback(data)
	if data ~= nil then
	    local datacontainer, pos, err = json.decode(data,1,nil)
	    if err then
	    	return
	    end
		local thingy = datacontainer.message
		if thingy == "gamestate" then
			gamestateset = true
			gamestate = datacontainer
		elseif thingy == "action" then
			currentAction = datacontainer
			action = true
			actiontime = 0
		elseif thingy == "connect" then
			--
		end
	end
end
