local firstVisit = false -- TODO: Change this value through onJoin.

RegisterServerEvent("print")
AddEventHandler("print",
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
		print("Player spawned!")
		TriggerClientEvent("onJoin", source, firstVisit)
	end
)

AddEventHandler("loggedIn", 
	function()
		print("Player logged in!")
	end
)

RegisterServerEvent("passwordSubmit")
AddEventHandler("passwordSubmit", 
	function(password)
		print(password)
		print(source)
		if firstVisit then -- TODO: Register password!
			print("here1")
			TriggerClientEvent("passwordChecked", source, true)
		elseif password == "correct" and not firstVisit then -- TODO: Check password!
			print("here2")
			TriggerClientEvent("passwordChecked", source, true)
		else
			print("here3")
			TriggerClientEvent("passwordChecked", source, false)
		end
	end
)