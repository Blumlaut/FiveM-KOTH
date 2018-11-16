function tryIdentifiers(player) -- This currently only returns RS License but steamID can be implemented too... I personally prefer RS license.
	local identifiers = GetPlayerIdentifiers(player)
	if identifiers then
		local saveAbleIdentifier = {} -- This table will get returned because fuck windows and its file name policies ( AKA ":" not allowed )
		for key,value in ipairs(identifiers) do
			local a = stringsplit(value,":") -- It just seperates the identifier from ":" so we can fucking save it.
			if a[1] == "license" then
				saveAbleIdentifier[a[1]] = a[2]
			end
		end
		if next(saveAbleIdentifier) == nil then -- This condition shouldn't really appear.
			print("Something really got fucked while trying identifiers.")
			return false
		end
		playerIdentifierCache[player] = saveAbleIdentifier["license"]
		return saveAbleIdentifier
	end
	print("Player with ID " .. player .. " has no identifiers... WTF?") -- That would be interesting.
end