local currentZoneOwner=false

AddEventHandler("SetZoneOwner", function(teamid)
	if teamid and teamid ~= -2 then
		currentZoneOwner = {name = mapData.teams[teamid][1], colour=mapData.teams[teamid][2]}
	elseif teamid == -2 then
		currentZoneOwner = {name = "Contested", colour={255, 191, 0}}
	else
		currentZoneOwner = false
	end
end)



SafeZonePeople = {}
local currentSafezoneStats = {
	players = {0,0,0},
	points = {0,0,0}
}



Citizen.CreateThread(function()
	local redPlayers = 0
	local greenPlayers = 0
	local bluePlayers = 0
	local redPoints = 0
	local greenPoints = 0
	local bluePoints = 0
	
	RegisterNetEvent("UpdateZoneStats")
	AddEventHandler("UpdateZoneStats", function(stats)
		currentSafezoneStats = stats
		redPlayers = stats.players[1]
		greenPlayers = stats.players[2]
		bluePlayers = stats.players[3]
		redPoints = stats.points[1]
		greenPoints = stats.points[2]
		bluePoints = stats.points[3]
	end)
	
	if not HasStreamedTextureDictLoaded("king_of_the_hill") then
		RequestStreamedTextureDict("king_of_the_hill", true)
	end

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
		
		if mapData.teams and currentSafezoneStats.players then
			
			
			for i,team in pairs(mapData.teams) do
				DrawSprite("king_of_the_hill", "box", 0.75+i/15, 0.9, 0.04, 0.065, 0.0, team[2][1], team[2][2], team[2][3], 255)
				--for a = 1, 25 do
				for a = 1, currentSafezoneStats.players[i] do
					local newLine = 1
					
					local ta = 0
					for i=1, a do
						ta=ta+1
						if ta > 5 then
							ta = 1
							newLine = newLine+1
						end
					end
					DrawRect((0.730+(ta/160))+(i/15), 0.868+(newLine/100), 0.005, 0.008, 255, 255, 255, 255)
				end
				SetTextFont(4)
				SetTextProportional(1)
				SetTextScale(0.0, 0.6)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(tostring(currentSafezoneStats.points[i]))
				DrawText(0.7455+i/15, 0.93)
			end
				
				
			--[[
				
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
			]]
			
			
			
			
			
			
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

function DrawMissonText(text, duration, drawImmediately)
	BeginTextCommandPrint("STRING")
	AddTextComponentString(text)
	EndTextCommandPrint(duration, drawImmediately)
end