local currentZoneOwner=false

AddEventHandler("SetZoneOwner", function(teamid)
	if teamid and not teamid == -2 then
		currentZoneOwner = {name = mapData.teams[teamid][1], colour=mapData.teams[teamid][2]}
	elseif teamid == -2 then
		currentZoneOwner = {name = "Contested", colour={255, 191, 0}}
	else
		currentZoneOwner = false
	end
end)



SafeZonePeople = {}


Citizen.CreateThread(function()
	local redPlayers = 0
	local greenPlayers = 0
	local bluePlayers = 0
	local redPoints = 0
	local greenPoints = 0
	local bluePoints = 0
	
	RegisterNetEvent("UpdateZoneStats")
	AddEventHandler("UpdateZoneStats", function(stats)
		redPlayers = stats.players[1]
		greenPlayers = stats.players[2]
		bluePlayers = stats.players[3]
		redPoints = stats.points[1]
		greenPoints = stats.points[2]
		bluePoints = stats.points[3]
	end)
	

	while true do
		Wait(1)
		
		safeZoneOffset = (GetSafeZoneSize() / 2.5) - 0.4
		local r,g,b = 255,255,255
		local str = "noone"
		if currentZoneOwner == false then 
			str = "noone"
			r,g,b = 255,255,255
		else
			str = currentZoneOwner.name
			r,g,b = currentZoneOwner.colour[1],currentZoneOwner.colour[2],currentZoneOwner.colour[3]
		end
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.55)
		SetTextColour(r, g, b, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("Current Zone Owner: "..str)
		DrawText(0.16, 0.95)
		
		if mapData.teams then
			
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.55)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString(mapData.teams[1][1].." Players: "..redPlayers)
			DrawText(0.16, 0.80)
			
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.55)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString(mapData.teams[2][1].." Players: "..greenPlayers)
			DrawText(0.16, 0.84)
			
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.55) 
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString(mapData.teams[3][1].." Players: "..bluePlayers)
			DrawText(0.16, 0.88)
			
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.55)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString(mapData.teams[1][1].." Points: "..redPoints)
			DrawText(0.16, 0.68)
			
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.55)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString(mapData.teams[2][1].." Points: "..greenPoints)
			DrawText(0.16, 0.72)
			
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.55) 
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString(mapData.teams[3][1].." Points: "..bluePoints)
			DrawText(0.16, 0.76)
		end
		
		
		if dataSet then
			SetTextFont(7)
			SetTextProportional(1)
			SetTextScale(0.0, 0.5)
			SetTextColour(0, 255, 0, 200)
			--SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("$"..dataSet.money)
			DrawText(0.7-safeZoneOffset, 0.95+safeZoneOffset)
			HideHudComponentThisFrame(3)
			HideHudComponentThisFrame(4)
			HideHudComponentThisFrame(13)
			RemoveMultiplayerHudCash()
		end
	end
end)