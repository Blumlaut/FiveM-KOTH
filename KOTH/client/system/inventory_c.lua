dataSet = {rank = 1, exp = 0, loadout = {}, money = Settings.DefaultMoney}

RegisterNetEvent('updatePlayerData')
RegisterNetEvent('teleportPlayer')

ShopCoords = {}

money = 0
-- EventHandler to send event of playerSpawn directly to the server
AddEventHandler('playerSpawned',function(spawnInfo)
	print("playerspawned")
	TriggerServerEvent('playerSpawned',spawnInfo)
	GiveWeaponToPed(PlayerPedId(), "WEAPON_SPECIALCARBINE", 120, false, true)
	GiveWeaponToPed(PlayerPedId(), "WEAPON_PISTOL", 45, false, false)
	UpdateTeamMembers()
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
	
	function RefreshShopCoords() -- execute this function to re-create the shop models
		for i,Shop in pairs(ShopCoords) do
			if Shop.active == true then
				DeleteEntity(Shop.object) -- delete the old shop model before re-creating it
				Shop.active = false
			end
			Shop.object = CreateObject("prop_protest_table_01", Shop[1], Shop[2], Shop[3], false, false, false)
			Shop.active = true
		end
	end
	
	
	
	while true do
		Citizen.Wait(0)
		local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId(), true))
		if ShopCoords then -- make sure the shop coords aren't being changed as we speak
			for i,Shop in ipairs(ShopCoords) do
				if Shop.active then -- make sure it even exists
					DrawMarker(1, Shop[1], Shop[2], Shop[3]-1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
					if(GetDistanceBetweenCoords(px,py,pz,Shop[1], Shop[2], Shop[3],true)< 2.0) then
						DrawMissonText("Press ~y~E~w~ to do a thingy", 100,true)
						if IsControlJustPressed(1, 51) then
							-- Thingy has been done, TODO: Add menu thingies and make shops work lololol
						end
					end
				end
			end
		end
	end
end)

AddEventHandler("changeMap",function(nzone) -- Changing blip and zone here
	Citizen.Wait(120)
	RefreshShopCoords()
end)