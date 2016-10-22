local firstSpawn = true
local loginFocus = false

RegisterNetEvent("showLogin")
AddEventHandler("showLogin", -- Called by the server to show the login form.
	-- Calling this more than once per connected client should work.
	-- The biggest problem would be that the text does not support
	-- that. For example if you called this a second time,
	-- the welcome text would still welcome you to the server.
	function(isRegistered)
		Citizen.CreateThread(
			function()
				loginFocus = true
				local username = GetPlayerName(PlayerId())
				TriggerEvent("protectPlayer", true)
				SetNuiFocus(true)
				SendNUIMessage({ 
					meta = "showLogin", -- Tells JS to show the login pop up.
					isRegistered = isRegistered,
					username = username
				})
				repeat
					Citizen.Wait(0)
				until not loginFocus -- Wait until logged in.
				SetNuiFocus(false)
				TriggerEvent("protectPlayer", false)
			end
		)
	end
)

RegisterNetEvent("passwordChecked")
AddEventHandler("passwordChecked", -- Triggered once the password is checked.
	function(accepted)
		SendNUIMessage({
			meta = "passwordChecked", -- Tells JS to either tell you to try again or to hide the login box.
			accepted = accepted
		})
		if accepted then
			loginFocus = false
		end
	end
)

RegisterNUICallback("print", -- Used to receive print commands from JS, can be removed.
	function(data, callback)
		if data.message then
			TriggerServerEvent("print", data.message)
		end

		callback("ok")
	end
)

RegisterNUICallback("submit", -- Triggered when JS calls back with the entered password.
	function(data, callback)
		if data.password:len() < 1 then -- Don't allow empty strings.
			TriggerEvent("passwordChecked", false)
		else
			TriggerServerEvent("passwordSubmit", data) -- TODO: Figure out a way to hash the password(s) prior to sending it to the server?
		end
		callback("ok")
	end
)

AddEventHandler("playerSpawned", -- Triggered whenever a player spawns (does not differentiate between first spawn and respawn after death)
	function()
		if firstSpawn then
			TriggerServerEvent("onFirstSpawn")
			firstSpawn = false
		end
	end
)