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

RegisterNetEvent("invisiblePlayer")
AddEventHandler("invisiblePlayer",
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