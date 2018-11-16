zone = {}
isPlayerInZone = false

zoneconfig = {
	zoneBlip = 9,
	zoneAlpha = 100,
	zoneColor = 4,
	blip = 305,
	blipcolor = 4,
	blipalpha = 255,
}

RegisterNetEvent("RecieveZoneReward")
RegisterNetEvent("SetZoneOwner")
RegisterNetEvent("SetGameFinished")

local zoneArea = nil
local zoneBlip = nil
local changingMap = false


AddEventHandler("SetGameFinished", function(teamid) -- todo, add ranking ui or some shit
	TriggerEvent("chat:addMessage", { templateId = "default", args = { "Game","Game Finished, Team "..mapData.teams[teamid][1].." Won!" } })

end)

Citizen.CreateThread(function()
	while true do
		Wait(100)
		if zone.r and not changingMap then
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
			local dist = GetDistanceBetweenCoords(x, y, z, zone.x, zone.y, zone.z, false)
			
			if dist < zone.r-math.pi and not isPlayerInZone and not IsPlayerDead(PlayerId()) then
				TriggerServerEvent("PlayerEnteredKothZone",Teaminfo.id)
				Citizen.Trace("entered warzone")
				isPlayerInZone = true
			elseif dist > zone.r-math.pi and isPlayerInZone then
				TriggerServerEvent("PlayerLeftKothZone",Teaminfo.id)
				isPlayerInZone = false
			elseif isPlayerInZone and IsPlayerDead(PlayerId()) then
				TriggerServerEvent("PlayerLeftKothZone",Teaminfo.id)
				isPlayerInZone = false 
			end
		end
	end
end)

function createBlip(zone)
	zoneArea = AddBlipForRadius(zone.x, zone.y, zone.z, zone.r+.0) --Creates the circle on the map
	zoneBlip = AddBlipForCoord(zone.x, zone.y, zone.z) -- Creates the name of the blip on the list in the pause menu
	SetBlipSprite(zoneArea, 9)
	SetBlipAlpha(zoneArea, 100)
	SetBlipColour(zoneArea, 4)
	SetBlipSprite(zoneBlip, 305)
	SetBlipColour(zoneBlip, 4)
	SetBlipAlpha(zoneBlip, 255)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Warzone")
	EndTextCommandSetBlipName(zoneBlip)	
end

AddEventHandler("SetZoneOwner", function(teamid)
	if teamid then
		SetBlipColour(zoneArea, mapData.teams[teamid][2][4])
		SetBlipColour(zoneBlip, mapData.teams[teamid][2][4])
	else
		SetBlipColour(zoneArea, 4)
		SetBlipColour(zoneBlip, 4)
	end
end)

AddEventHandler("changeMap",function(nzone) -- Changing blip and zone here
	print("changing map")
	if zoneArea ~= nil then
		RemoveBlip(zoneArea)
		RemoveBlip(zoneBlip)
	end
	changingMap = true
	zone = nzone
	Citizen.Wait(120)
	createBlip(nzone)
	changingMap = false
end)