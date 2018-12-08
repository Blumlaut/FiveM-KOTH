RegisterServerEvent("PlayerEnteredKothZone")
RegisterServerEvent("PlayerLeftKothZone")

PlayersInZone = {}
local teamplayers

AddEventHandler("PlayerEnteredKothZone", function(teamid)
	table.insert(PlayersInZone, {id = source, team = teamid})
	Citizen.Trace("player entered a warzone")
end)

AddEventHandler("PlayerLeftKothZone", function(teamid)
	for i,player in pairs(PlayersInZone) do
		if player.id == source then
			table.remove(PlayersInZone,i)
		end
	end
	Citizen.Trace("player left a warzone")
end)

AddEventHandler("resetRound", function() -- Lets restart the round shall we?
	PlayersInZone = {}
	for i,team in ipairs(Teams) do
		Teams[i].points = 0
	end
	TriggerClientEvent("UpdateZoneStats", -1, {players = teamplayers, points = {Teams[1].points, Teams[2].points, Teams[3].points} })
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		for i,team in ipairs(Teams) do
			Teams[i].active = 0
		end
		
		
		for i,player in pairs(PlayersInZone) do
			if not GetPlayerName(player.id)  then
				table.remove(PlayersInZone,i)
			else
				Teams[player.team].active = Teams[player.team].active+1
			end
		end
		local highestIndex = 0;
		local highestValue = false;
		local contested = false
		for k, v in ipairs(Teams) do
				if not highestValue or v.active > highestValue then
						highestIndex = k;
						highestValue = v.active;
				end
				if v.active == highestValue and highestIndex ~= k and (highestValue>0 and v.active>0) then
					contested = true
				end
		end
		
		if Teams[highestIndex].points == 100 then -- did the game end?
		print("game ended")
			TriggerClientEvent("SetGameFinished", -1, Teams[highestIndex])
			for i,player in pairs(PlayersInZone) do
				if player.team == highestIndex then
					setPlayerData(player.id, {money = getPlayerData(player.id).money+5000 })
					Citizen.Wait(0)
				else
					setPlayerData(player.id, {money = getPlayerData(player.id).money+1000 })
				end
			end
			Citizen.Wait(10000)
			TriggerClientEvent("chat:addMessage", -1, { templateId = "default", args = { "Game","Changing Maps.." } })
			TriggerEvent("mapmanager:roundEnded")
			Wait(1000)
			TriggerEvent("resetRound")
		end
		
		
		if highestValue == 0 and not contested then
			Citizen.Trace("zone owner is noone!")
			TriggerClientEvent("SetZoneOwner", -1, false,false)
		elseif (contested and highestValue>0) then
			Citizen.Trace("zone is contested!")
			TriggerClientEvent("SetZoneOwner", -1, -2,false)
		else
			Citizen.Trace("zone owner is "..Teams[highestIndex].name)
			TriggerClientEvent("SetZoneOwner", -1, highestIndex)
			Teams[highestIndex].points = Teams[highestIndex].points+1
			print(Teams[highestIndex].points)
		end
		teamplayers = {}
		for i,team in pairs(Teams) do
			teamplayers[i] = team.active
		end
		
		for i,player in pairs(PlayersInZone) do
			if player.team == highestIndex and not (contested and highestValue>0) then
					setPlayerData(player.id, {money = getPlayerData(player.id).money+25 })
			    Citizen.Wait(0)
			else
					setPlayerData(player.id, {money = getPlayerData(player.id).money+10 })
			    Citizen.Wait(0)
			end
		end
		
		TriggerClientEvent("UpdateZoneStats", -1, {players = teamplayers, points = {Teams[1].points, Teams[2].points, Teams[3].points} })
		
		--[[
		for i,theMember in ipairs(Teams[highestIndex].members) do
			
			for i,theMember in ipairs(Teams[i].members) do 
				TriggerClientEvent("TeamMemberJoined", theMember.id, PlayerName, theSource)
			end
			
			]]
	end

end)