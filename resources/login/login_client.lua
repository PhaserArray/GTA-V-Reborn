local firstSpawn = true
local loginFocus = false
local passwordCorrect = nil

RegisterNetEvent("onJoin")
AddEventHandler("onJoin", 
	function(firstVisit)
		Citizen.CreateThread(
			function()
				loginFocus = true
				local username = GetPlayerName(-1)
				TriggerEvent("freezePlayer", true)
				TriggerEvent("godPlayer", true)
				TriggerEvent("visiblePlayer", false)
				TriggerEvent("collidePlayer", false)
				SetNuiFocus(true)
				SendNUIMessage({
					meta = "showLogin",
					new = true,
					username = username
				})
				repeat
					Citizen.Wait(0)
				until not loginFocus
				TriggerServerEvent("print", "done?")
				SetNuiFocus(false)
				TriggerEvent("freezePlayer", false)
				TriggerEvent("godPlayer", false)
				TriggerEvent("visiblePlayer", true)
				TriggerEvent("collidePlayer", true)
			end
		)
	end
)

RegisterNetEvent("passwordChecked")
AddEventHandler("passwordChecked", 
	function(correct)
		TriggerServerEvent("print", "checked pass")
		SendNUIMessage({
			meta = "passwordChecked",
			correct = correct
		})
		if correct then
			loginFocus = false
		end
	end
)

RegisterNUICallback("submit",
	function(data, callback)
		if data.password:len() < 1 then
			TriggerServerEvent("print", "here<1")
			TriggerEvent("passwordChecked", false)
		else
			TriggerServerEvent("print", "here>1")
			TriggerServerEvent("passwordSubmit", data.password) -- TODO: Figure out a way to hash the password prior to sending it to the server?
		end
		callback("ok")
	end
)

RegisterNUICallback("print", 
	function(data, callback)

		TriggerServerEvent("print", "NUI callback recieved!")

		if data.message then
			TriggerServerEvent("print", data.message)
		end

		callback("ok")
	end
)

AddEventHandler("playerSpawned",
	function()
		if firstSpawn then
			Citizen.CreateThread(
				function()
					Citizen.Wait(300)
					TriggerServerEvent("playerJoined")
				end
			)
			firstSpawn = false
		end
	end
)