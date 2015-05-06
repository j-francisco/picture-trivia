define ["backbone", "views/base_view", "text!tpl/login.html"], (Backbone, BaseView, template) ->
	class LoginView extends BaseView
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
				success: (result) ->
					localStorage.pictureTriviaLoginEmail = email
					localStorage.pictureTriviaUserId = result.id
					Backbone.history.loadUrl('home/forward')
				error: (xhr, textStatus, errorThrown) ->
					alert("Invalid Login, Sorry!")

	return LoginView
