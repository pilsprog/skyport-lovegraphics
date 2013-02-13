animations = class:new();

function animations:setJK( players )
	for i,player in pairs(players) do
		local positions = split(player.position, ",")
		player.realJ = positions[1]
		player.realK = positions[2]
	end
end

function animations:move(dt, players, actionData )
	actiontime = actiontime + dt
	if actiontime >= 1 then
		actiontime = 1 
		action = false
		local table ={
			message = "ready"
		}
		
		conn:send(json.encode(table,{indent = false}).."\n")

		for i,player in pairs(players) do
			if player.name == actionData.from then
				local direction = actionData.direction
				if direction == "up" then
					player.position = player.realJ - 1 .. "," .. player.realK - 1
					player.realK = player.realK - actiontime
					player.realJ = player.realJ - actiontime
				elseif direction == "left-up" then
					player.position = player.realJ .. "," .. player.realK - 1
					player.realK = player.realK - actiontime
				elseif direction == "left-down" then
					player.position = player.realJ + 1 .. "," .. player.realK
					player.realJ = player.realJ + actiontime
				elseif direction == "down" then
					player.position = player.realJ + 1 .. "," .. player.realK + 1
					player.realK = player.realK + actiontime
					player.realJ = player.realJ + actiontime
				elseif direction == "right-down" then
					player.position = player.realJ .. "," .. player.realK + 1
					player.realK = player.realK + actiontime
				elseif direction == "right-up" then
					player.position = player.realJ - 1 .. "," .. player.realK
					player.realJ = player.realJ - actiontime
				end
			end
		end
	else
		for i,player in pairs(players) do
			if player.name == actionData.from then
				local direction = actionData.direction
				if direction == "up" then
					player.realK = player.realK - actiontime
					player.realJ = player.realJ - actiontime
				elseif direction == "left-up" then
					player.realK = player.realK - actiontime
				elseif direction == "left-down" then
					player.realJ = player.realJ + actiontime
				elseif direction == "down" then
					player.realK = player.realK + actiontime
					player.realJ = player.realJ + actiontime
				elseif direction == "right-down" then
					player.realK = player.realK + actiontime
				elseif direction == "right-up" then
					player.realJ = player.realJ - actiontime
				end
			end
		end
	end
	-- return players
end