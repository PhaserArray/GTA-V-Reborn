RegisterNetEvent("protectPlayer")
AddEventHandler("protectPlayer",
	function(toggle)
		TriggerEvent("freezePlayer", toggle)
		TriggerEvent("godPlayer", toggle)
		TriggerEvent("visiblePlayer", not toggle)
		TriggerEvent("collidePlayer", not toggle)
	end
)

RegisterNetEvent("freezePlayer")
AddEventHandler("freezePlayer",
	function(toggle)
		local player = GetPlayerPed(-1)
		FreezeEntityPosition(player, toggle)
	end
)

RegisterNetEvent("godPlayer")
AddEventHandler("godPlayer",
	function(toggle)
		local player = GetPlayerPed(-1)
		SetEntityInvincible(player, toggle)
	end
)

RegisterNetEvent("visiblePlayer")
AddEventHandler("visiblePlayer",
	function(toggle)
		local player = GetPlayerPed(-1)
		SetEntityVisible(player, toggle)
	end
)

RegisterNetEvent("collidePlayer")
AddEventHandler("collidePlayer",
	function(toggle)
		local player = GetPlayerPed(-1)
		SetEntityCollision(player, toggle)
	end
)

RegisterNetEvent("posPlayer")
AddEventHandler("posPlayer",
	function(x, y, z)
		local player = GetPlayerPed(-1)
		SetEntityCollision(player, x, y, z)
	end
)