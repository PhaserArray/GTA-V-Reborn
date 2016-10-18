$(function()
{
	function print(message) // Print to server console.
	{
		var obj = {message:message};
		$.post("http://login/print", JSON.stringify(obj));
	}

	$("#passwordForm").submit(function(event)
	{
		event.preventDefault();
		var input = $("#passwordInput").val();
		var data = {password:input};
		$.post("http://login/submit", JSON.stringify(data));
	});

	window.addEventListener("message", function(event)
	{
		var data = event.data;

		switch(data.meta) {
			case "showLogin":
				$("#wrap").addClass("flex");
				$("#letter").text(data.username.chatAt(0));

				if (!data.new)
				{
					$(".type-text").text("Login");
					$(".returning-user").text("back ");
				}
				else
				{
					$(".type-text").text("Register");
					$(".returning-user").text("");
				}
				$("#passwordInput").focus();
			case "passwordChecked":
				if (!data.correct)
				{
					if ($("#please-login").hasClass("fail"))
					{
						$("#please-login").addClass("epic");
						window.setTimeout(function()
						{
							$("#please-login").removeClass("epic");
						}, 500);
					}
					else
					{
						$("#please-login .type-text").text("");
						$("#please-login").text("Please try again!");
						$("#please-login").addClass("fail");
					}
				}
				else
				{
					$("#wrap").removeClass("flex");
				}
		}
	}, false);
});