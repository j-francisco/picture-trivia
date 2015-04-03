define ["backbone", "text!tpl/login_template.html"], (Backbone, template) ->
	class LoginView extends Backbone.View
		template: _.template(template)

		tagName: "div"

		events:
			"click .login-btn": "login"

		render: () ->
			@$el.html(@template())
			return this

		login: () ->
			email = @$el.find("#loginEmail").val()
			# password = @$el.find("#loginPassword").val()
			
			$.ajax
				url: "http://localhost:5000/user_login"
				type: "POST"
				data:
					email: email
					# password: password
				success: (result) ->
					localStorage.loginEmail = email
					Backbone.history.loadUrl('home/forward')
				error: (xhr, textStatus, errorThrown) ->
					alert("Invalid Login, Sorry!")

	return LoginView
