function isRegistered(playerId)
	return true -- TODO: Return true or false depending on if the player is registered in the database.
end

function checkPassword(playerId, password)
	-- TODO: Actually check the player's password against the database.
	if password == "correct" then
		return true
	else
		return false
	end
end

RegisterServerEvent("print")
AddEventHandler("print", -- Used to print from client.
	function(msg)
		if msg == nil then
			print(source..": nil")
		else
			print(source .. ": " .. msg )
		end
	end
)

AddEventHandler("loggedIn", -- Triggered when the player has sucessefully logged in.
	function()
		print(GetPlayerName(source).." has logged in!")
		-- TODO: Do something with the player once the player logs in?
	end
)

AddEventHandler("registered", -- Triggered when the player has sucessefully registered.
	function()
		print(GetPlayerName(source).." has registered!")
		-- TODO: Give the player starting cash when he registers or something else?
	end
)

RegisterServerEvent("passwordSubmit")
AddEventHandler("passwordSubmit", -- Triggered by the client when a password is submitted for checking.
	function(password)
		if not isRegistered(source) then
			-- TODO: Register player!
			TriggerClientEvent("passwordChecked", source, true)
			TriggerEvent("registered")
		elseif checkPassword(source, password) then
			TriggerClientEvent("passwordChecked", source, true)
			TriggerEvent("loggedIn")
		else
			TriggerClientEvent("passwordChecked", source, false)
		end
	end
)

RegisterServerEvent("onFirstSpawn")
AddEventHandler("onFirstSpawn", -- Triggered when the client first spawns on the server after connecting.
	function()
		print(GetPlayerName(source).." has joined the server!")
		TriggerClientEvent("showLogin", source, isRegistered(source))
	end
)