local currentMap = nil
local spawnPoint = nil

mapData = {}

AddEventHandler('getMapDirectives', function(add)
    -- add a custom data
    add("koth", function(state, arg1, arg2)
        -- do something with the custom data
        mapData.koth = arg1
        state.add("koth", {arg1 = arg1})
    end, function(state, arg)
        -- cleaning up whatever the map did above
        for i,data in ipairs(mapData) do
            if state["koth"].arg1 == data.arg1 then
                mapData.koth = nil
            end
        end
    end)
end)

AddEventHandler('getMapDirectives', function(add)
    -- add a custom data
    add("teams", function(state, arg1, arg2)
        -- do something with the custom data
        mapData.teams = arg1
        state.add("teams", {arg1 = arg1})
    end, function(state, arg)
        -- cleaning up whatever the map did above
        for i,data in ipairs(mapData) do
            if state["teams"].arg1 == data.arg1 then
                mapData.teams = nil
            end
        end
    end)
end)

AddEventHandler('getMapDirectives', function(add)
    -- add a custom data
    add("shops", function(state, arg1, arg2)
        -- do something with the custom data
        mapData.shops = arg1
        state.add("shops", {arg1 = arg1})
    end, function(state, arg)
        -- cleaning up whatever the map did above
        for i,data in ipairs(mapData) do
            if state["shops"].arg1 == data.arg1 then
                mapData.shops = nil
            end
        end
    end)
end)

AddEventHandler('getMapDirectives', function(add)
    -- add a custom data
    add("spawns", function(state, arg1, arg2)
        -- do something with the custom data
        mapData.spawns = arg1
        state.add("spawns", {arg1 = arg1})
    end, function(state, arg)
        -- cleaning up whatever the map did above
        for i,data in ipairs(mapData) do
            if state["spawns"].arg1 == data.arg1 then
                mapData.spawns = nil
            end
        end
    end)
end)

AddEventHandler('getMapDirectives', function(add)
    -- add a custom data
		LoadMapData()
    add("vehicleSpawns", function(state, arg1, arg2)
        -- do something with the custom data
        mapData.vehicleSpawns = arg1
        state.add("vehicleSpawns", {arg1 = arg1})
    end, function(state, arg)
        -- cleaning up whatever the map did above
        for i,data in ipairs(mapData) do
            if state["vehicleSpawns"].arg1 == data.arg1 then
                mapData.vehicleSpawns = nil
            end
        end
    end)
end)

AddEventHandler('getMapDirectives', function(add)
    -- add a custom data
		LoadMapData()
    add("zoneconfig", function(state, arg1, arg2)
        -- do something with the custom data
        mapData.zoneconfig = arg1
				zoneconfig = zoneconfig
        state.add("zoneconfig", {arg1 = arg1})
    end, function(state, arg)
        -- cleaning up whatever the map did above
        for i,data in ipairs(mapData) do
            if state["zoneconfig"].arg1 == data.arg1 then
                mapData.zoneconfig = nil
            end
        end
    end)
end)


function LoadMapData()
	repeat
		Wait(50)
	until (mapData.spawns and Teaminfo.id ~= 0)
	TriggerServerEvent("whatMapAreWeOn")
	setNewSpawnPoints()
	TriggerEvent("changeMap", {x = mapData.koth[1], y = mapData.koth[2], z = mapData.koth[3], r = mapData.koth[4]} )
end

function setNewSpawnPoints(spawnpoints)
	exports.spawnmanager:setAutoSpawn(false)
	local spToSet = mapData.spawns[Teaminfo.id]
	exports.spawnmanager:removeSpawnPoint(spawnPoint)
	spawnPoint = exports.spawnmanager:addSpawnPoint({ -- TODO: Multiple spawn points for each team.
		x = spToSet[1],
		y = spToSet[2],
		z = spToSet[3],
		heading = 0,
		model = "s_m_y_marine_01" -- TODO: When skin shop gets implemented make sure player spawns with his/her skin
	})
	exports.spawnmanager:setAutoSpawn(true)
	exports.spawnmanager:forceRespawn(true)
end