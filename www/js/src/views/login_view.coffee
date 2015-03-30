define ["backbone", "text!tpl/login_template.html"], (Backbone, template) ->
	class LoginView extends Backbone.View
		template: _.template(template)

		events:
			"click .login-btn": "login"

		render: () ->
			@$el.html(@template())
			return this

		login: () ->
			email = @$el.find("#loginEmail").val()
			password = @$el.find("#loginPassword").val()
			console.log email
			console.log password
			$.ajax
				url: "http://localhost:5000/user_login"
				type: "POST"
				data:
					email: email
					password: password
					remember_me: 1
					commit: 'Log in'
				success: (result) ->
					console.log "hey"
					Backbone.history.navigate('home', true)
				error: (xhr, textStatus, errorThrown) ->
					console.log xhr
					console.log textStatus
					console.log errorThrown

	return LoginView
