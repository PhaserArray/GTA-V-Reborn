local firstVisit = false -- TODO: Change this value to true if player joined

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

RegisterServerEvent("playerJoined")
AddEventHandler("playerJoined", 
	function()
		print(GetPlayerName(source).." has joined the server!")
		TriggerClientEvent("onJoin", source, firstVisit)
	end
)

AddEventHandler("loggedIn", 
	function()
		-- TODO: Do something once logged in?
	end
)

RegisterServerEvent("passwordSubmit")
AddEventHandler("passwordSubmit", 
	function(password)
		if firstVisit then
			-- TODO: Register password!
			print(GetPlayerName(source).." has registered!")
			TriggerClientEvent("passwordChecked", source, true)
			TriggerEvent("loggedIn")
		elseif password == "correct" and not firstVisit then -- TODO: Check password!
			print(GetPlayerName(source).." has logged in!")
			TriggerClientEvent("passwordChecked", source, true)
			TriggerEvent("loggedIn")
		else
			print(GetPlayerName(source).." failed to login/register.")
			TriggerClientEvent("passwordChecked", source, false)
		end
	end
)