Teams = {
	{id = 1, name = "Red Army", members = {}, colour = {255,0,0,1}, points = 0, active = 0  },
	{id = 2, name = "Green Leafs", members = {}, colour = {0,255,0,2}, points = 0, active = 0  },
	{id = 3, name = "Blue Cunts", members = {}, colour = {0,0,255,3}, points = 0, active = 0  }, 
}

RegisterServerEvent("jointeam")
RegisterServerEvent("leaveteam")

Citizen.CreateThread(function()

	AddEventHandler("jointeam", function(teamName,PlayerName)
		local theSource = source
		local teamName = false
		if teamName then -- did the client supply a team name?
			-- we dont actually care, auto-assignment for now
			--[[
			for i,theTeam in ipairs(Teams) do
				for theRow,theMember in ipairs(theTeam.members) do
					if theMember.name == PlayerName then
						TriggerClientEvent("LeftTeam", theMember.id, Teams[i].name)
						table.remove(Teams[i].members, theRow)
						for ti,TM in ipairs(Teams[i].members) do
							TriggerClientEvent("TeamMemberLeft", TM.id, theMember.id, theMember.name) 
						end
						TriggerClientEvent("UpdateBlips", -1 )
					end
				end
			end
			]]
		else -- if not, check which team has free slots and throw him in there
			local lowestIndex = 0;
			local lowestValue = false;
			for k, v in ipairs(Teams) do
			    if not lowestValue or #v.members < lowestValue then
			        lowestIndex = k;
			        lowestValue = #v.members;
			    end
			end
			
			teamName = Teams[lowestIndex].name
		end
				
		
		for i,theTeam in pairs(Teams) do
			if theTeam.name == teamName then
				table.insert(Teams[i].members, {id = theSource,name = PlayerName})
				TriggerClientEvent("JoinedTeam", theSource, {id = Teams[i].id,name = Teams[i].name, members = Teams[i].members, colour = Teams[i].colour})
				for i,theMember in ipairs(Teams[i].members) do 
					TriggerClientEvent("TeamMemberJoined", theMember.id, PlayerName, theSource)
				end
				TriggerClientEvent("UpdateBlips", -1 )
			end
		end
	end)

	AddEventHandler("leaveteam", function(PlayerName)
		local theSource = source
		for i,theTeam in ipairs(Teams) do
			for theRow,theMember in ipairs(theTeam.members) do
				if theMember.name == PlayerName then
					TriggerClientEvent("LeftTeam", theMember.id, Teams[i].name)
					table.remove(Teams[i].members, theRow)
					for ti,TM in ipairs(Teams[i].members) do
						TriggerClientEvent("TeamMemberLeft", TM.id, theMember.id, theMember.name) 
					end
				end
			end
		end
	end)


	AddEventHandler('playerDropped', function(reason)
		local PlayerName = GetPlayerName(source)
		for i,theTeam in ipairs(Teams) do
			for theRow,theMember in ipairs(theTeam.members) do
				if theMember.name == PlayerName then
					table.remove(Teams[i].members, theRow)
					for ti,TM in ipairs(Teams[i].members) do
						TriggerClientEvent("TeamMemberLeft", TM.id, theMember.id, theMember.name) 
					end
				end
			end
		end
	end)

end)
