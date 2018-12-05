AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		--SetPlayerWantedLevelNow(PlayerId(), 0)
		--SetPlayerWantedLevel(PlayerId(), 0, false)
		SetMaxWantedLevel(0)
		SetPedDensityMultiplierThisFrame(0.0)
		SetVehicleDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetRandomBoats(false)
		SetRandomTrains(false)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetSomeVehicleDensityMultiplierThisFrame(0.0)
	end

end)
