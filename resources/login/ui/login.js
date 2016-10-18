$(function()
{
	function print(message)
	{
		var obj = {message:message};
		$.post("http://login/print", JSON.stringify(obj));
	}

	$("#passwordForm").submit(function(event)
	{
		event.preventDefault();
		print("Submitting!")
		var input = $("#passwordInput").val();
		var data = {password:input};
		$.post("http://login/submit", JSON.stringify(data));
	});

	window.addEventListener("message", function(event)
	{
		print("do you even load");
		var data = event.data;

		switch(data.meta) {
			case "showLogin":
				print("showLogin");
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
				$("#passwordInput")[0].focus();
			case "passwordChecked":
				print("passwordChecked");
				if (!data.correct)
				{
					print("not correct");
					if ($("#please-login").hasClass("fail"))
					{
						print("epic");
						$("#please-login").addClass("epic").delay(500).removeClass("epic");
					}
					else
					{
						print("fail");
						$("#please-login .type-text").text("");
						$("#please-login").text("Please try again!");
						$("#please-login").addClass("fail");
					}
				}
				else
				{
					print("correct");
					$("#wrap").removeClass("flex");
				}
		}

		/*if (data.meta == "passwordChecked")
		{
			
		}*/
	}, false);
});