dataSet = {rank = 1, exp = 0, loadout = {}, money = Settings.DefaultMoney}

RegisterNetEvent('updatePlayerData')
RegisterNetEvent('teleportPlayer')


money = 0
-- EventHandler to send event of playerSpawn directly to the server
AddEventHandler('playerSpawned',function(spawnInfo)
	print("playerspawned")
	TriggerServerEvent('playerSpawned',spawnInfo)
	GiveWeaponToPed(PlayerPedId(), "WEAPON_SPECIALCARBINE", 120, false, true)
	GiveWeaponToPed(PlayerPedId(), "WEAPON_PISTOL", 45, false, false)
end)
--  EventHandler to receive stat change like money add etc ...
AddEventHandler('updatePlayerData',function(data)
	dataSet = data
end)
-- Util event handler for dev reason
AddEventHandler('teleportPlayer',function(x,y,z)
	SetEntityCoords(GetPlayerPed(-1),x,y,z)
end)

-- Shop in dev
Citizen.CreateThread(function()
	TriggerServerEvent("playerExists", "hi i exist, pls give stats thank")
	while true do
		Citizen.Wait(10)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1))
		x,y,z = -1154.0,-2715.0,19.0
		DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
		if(GetDistanceBetweenCoords(plyCoords,x,y,z,true)< 2) then

		end
	end
end)