$(function()
{
	function print(message) // Print to server console.
	{
		var obj = {message:message};
		$.post("http://login/print", JSON.stringify(obj)); // This call the print callback.
	}

	$("#passwordForm").submit(function(event) // Submit password for checking when the form is submitted.
	{
		event.preventDefault();
		var input = $("#passwordInput").val();
		var data = {password:input};
		$.post("http://login/submit", JSON.stringify(data)); // This calls the submit callback.
	});

	window.addEventListener("message", function(event) // Triggered by SendNUIMessage() from the Lua client.
	{
		var data = event.data; // I didn't want to type event every time..

		switch (data.meta) {
			case "showLogin": // Show login.
				$("#wrap").addClass("flex");
				$("#passwordInput").focus();

				$("#letter").text(data.username.charAt(0));
				$("#login-info .first-half").text("Please "); // This is here so the login form could be shown more than once
				$("#login-info .second-half").text(" to continue!"); // per session. Otherwise, you could just write this into the HTML.	

				if (data.isRegistered)
				{
					$(".type-text").text("Login");
					$(".returning-user").text("back ");
					$("#wrap").addClass("isregistered");
				}
				else
				{
					$(".type-text").text("Register");
					$(".returning-user").text("");
				}
				break;
			case "passwordChecked": // Submitted password was checked.
				if (!data.accepted) // Password was not accepted.
				{
					if (!$("#login-info").hasClass("incorrect"))
					{
						// Switch from the please login/register to continue text to the try again text.
						$("#login-info .type-text").text("");
						$("#login-info .first-half").text("Please ");
						$("#login-info .second-half").text("try again!");
						$("#login-info").addClass("incorrect");
					}
					// Flash from a dimmer red to a brighter red.
					$("#login-info").addClass("iflash");
					window.setTimeout(function()
					{
						$("#login-info").removeClass("iflash");
					}, 250);
				}
				else // Password was accepted.
				{
					// Switch to a success text and flash it bright green once.
					$("#login-info .first-half").text("You have ");
					$("#login-info .second-half").text(" successfully!");
					if ($("#wrap").hasClass("isregistered"))
					{
						$("#login-info .type-text").text("logged in");
					}
					else
					{
						$("#login-info .type-text").text("registered");
					}

					$("#login-info").removeClass();
					$("#login-info").addClass("correct");
					$("#login-info").addClass("cflash");
					window.setTimeout(function()
					{
						$("#login-info").removeClass("cflash"); // Return to a dimmer green.
					}, 250);

					window.setTimeout(function()
					{
						$("#login-info").removeClass(); // Once again, this does not have to be here but I wanted to make the login form reusable.
						$("#wrap").removeClass(); // Hide UI by removing the flex class from the wrapper.
						$("#passwordInput").val("");
					}, 750);
				}
				break;
			default:
				print("Did you forget to pass along data.meta or something?")
		}
	});
});