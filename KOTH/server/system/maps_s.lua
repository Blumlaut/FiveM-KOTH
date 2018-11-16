RegisterServerEvent("whatMapAreWeOn")
mapslist = {"lsia","fortzancudo"}
currentmap = "lsia" -- Server starting map


function changeMap(mapname) -- TODO: A check to see if mapname is valid?
	TriggerClientEvent("ChangeMap",-1,mapname)
	TriggerEvent("restartRound")	
end