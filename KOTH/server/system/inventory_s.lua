local filePath = 'resources/koth/data/'
-- Load player from json files or create his json file
playerDataCache = {}
playerIdentifierCache = {}
defaultDataSet = {rank = 1, exp = 0, loadout = {}, money = 1500}

function utilizePlayerData(player) -- Pulls all the data table from /data/playerdatatable.txt
	local playerIdentifier = getIdentifier(player)
	local loadedData = LoadResourceFile(GetCurrentResourceName(), "data/"..playerIdentifier..".json") or nil
	print("utilizing data")
	if loadedData ~= nil then
		loadedData = json.decode(loadedData)
		playerDataCache[playerIdentifier] = loadedData
		TriggerClientEvent("updatePlayerData", player, loadedData)
		return loadedData
	end
	playerDataCache[playerIdentifier] = defaultDataSet
	savePlayerData(player)
	
	return defaultDataSet
end

function savePlayerData(player) -- Saves data table to /data/(licensehere).txt
	local playerIdentifier = getIdentifier(player)
	SaveResourceFile(GetCurrentResourceName(), "data/"..playerIdentifier..".json", json.encode(playerDataCache[playerIdentifier]),-1)
end

function getPlayerData(player)
	local identifier = getIdentifier(player)
	if not playerDataCache[identifier] then
		playerDataCache[identifier] = defaultDataSet
		TriggerClientEvent("updatePlayerData", player, defaultDataSet)
		savePlayerData(player)
	end
	return playerDataCache[identifier]
end

function setPlayerData(player,data)
	local identifier = getIdentifier(player)
	for i,d in pairs(playerDataCache[identifier]) do
		for k,v in pairs(data) do
			if i == k then
				playerDataCache[identifier][i] = data[i]
			end
		end
	end
	updatePlayerData(player)
end

function updatePlayerData(player)
	local identifier = getIdentifier(player)
	if playerDataCache[identifier] then
		TriggerClientEvent("updatePlayerData", player, playerDataCache[identifier])
	else
		TriggerClientEvent("updatePlayerData", player, defaultDataSet) -- player hasnt spawned in yet for some reason, give him the default dataset instead
	end
end

function getIdentifier(player) -- TODO: If steamID saving gets added, change here too.
	if playerIdentifierCache[player] then
		return playerIdentifierCache[player]
	else
		return tryIdentifiers(player)["license"] 
	end
end


-- player stat updating thread
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		for i,p in pairs(GetPlayers()) do
			--updatePlayerData(p)
			if tryIdentifiers(p)["license"]  then
				savePlayerData(p)
			end	
			Wait(200)
		end
	end
end)

RegisterServerEvent('playerExists')
RegisterServerEvent('playerFirstSpawn')
RegisterServerEvent('buyItem')

-- Server event playerSpawn redirect firstSpawning to playerFirstSpawn event
AddEventHandler('playerExists',function()
	utilizePlayerData(source)
end)

-- First Time Player Spawn event
AddEventHandler('playerFirstSpawn',function(spawnInfo,source)
	utilizePlayerData(source)
end)

-- WIP shop player buy item handler
AddEventHandler('buyItem',function(item)
	
end)

-- Utils commands for dev 
RegisterCommand("givemoney", function(args, rawCommand)
	local money = getPlayerData(source).money
	setPlayerData(source, {money = money+args[1]})
end, false)

RegisterCommand("gotoshop", function(args, rawCommand)
	TriggerClientEvent('teleportPlayer',source,-1154.0,-2715.0,20.0)
end, false)
