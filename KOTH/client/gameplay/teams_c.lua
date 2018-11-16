RegisterNetEvent("TeamMemberJoined")
RegisterNetEvent("TeamMemberLeft")
RegisterNetEvent("LeftTeam")
RegisterNetEvent("JoinedTeam")
RegisterNetEvent("UpdateBlips")

Teaminfo = {name = "No Team", members = {}, colour = {255,255,255,4}, id = 0}

curTeamMembers = {}

local playersDB = {}
for i=0, 31 do
	playersDB[i] = {}
end

AddEventHandler("JoinedTeam", function(team)
	Teaminfo = team
	curTeamMembers = {}
	local TeamName = team.name
	local members = team.members
	TriggerEvent("showNotification", "You joined ~g~"..TeamName.."~w~!")
	print("joined team "..TeamName.."\n")
	currentPlayerTeam = TeamName
	for i,theMember in ipairs(members) do
		table.insert(curTeamMembers,theMember.id)
	end
	Teaminfo.name = mapData.teams[team.id][1]
	Teaminfo.colour = mapData.teams[team.id][2]
	UpdateTeamMembers()
end)

function GetPlayerJetTeam()
	return currentPlayerTeam
end


AddEventHandler("LeftTeam", function(TeamName)
	curTeamMembers = {}
	TriggerEvent("showNotification", "You left ~g~"..TeamName.."~w~!")
	print("we are leaving this Team\n")
	UpdateTeamMembers()
end)

AddEventHandler("TeamMemberLeft", function(memberId,memberName)
found = false
	for i,theTeammate in ipairs(curTeamMembers) do
		if theTeammate == memberId then
			found = true
			table.remove(curTeamMembers, i)
			TriggerEvent("showNotification", "~g~"..memberName.."~w~ left your Team!")
		end
	end
	if not found then print("Team member left but we couldn't find him in our member list\n") else print("player left us and was removed\n") end
	UpdateTeamMembers()
end)

AddEventHandler("TeamMemberJoined", function(PlayerName,PlayerId)
	if PlayerName ~= GetPlayerName() then
		TriggerEvent("showNotification", "~g~"..PlayerName.."~w~ joined your Team!")
		print(PlayerName.." joined our Team\n")
		table.insert(curTeamMembers, PlayerId)
		UpdateTeamMembers()
	end
end)

Citizen.CreateThread(function()

TriggerServerEvent("jointeam", false, GetPlayerName(PlayerId()))


end)


Citizen.CreateThread(function()


	function UpdateTeamMembers()
		ptable = GetPlayers()
		for id, Player in ipairs(ptable) do
			isTeamMate = false
			for i,theTeammate in ipairs(curTeamMembers) do 
				if Player == GetPlayerFromServerId(theTeammate) then
					if playersDB[Player].blip then RemoveBlip(playersDB[Player].blip) end
					isTeamMate = true
					local ped = GetPlayerPed(GetPlayerFromServerId(theTeammate))
					local blip = AddBlipForEntity(ped)
					SetBlipSprite(blip, 1)
					SetBlipColour(blip, Teaminfo.colour[4])
					Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
					SetBlipNameToPlayerName(blip, Player)
					SetBlipScale(blip, 0.85)	
					playersDB[Player].blip = blip
				end
			end
		end
		SetTimeout(20000, UpdateTeamMembers)
	end
	SetTimeout(20000, UpdateTeamMembers)
	AddEventHandler("UpdateBlips", UpdateTeamMembers)
	
end)

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end
