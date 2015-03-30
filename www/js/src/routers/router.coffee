define ["backbone", "views/login_view",	"views/home_view"], (Backbone, LoginView, HomeView) ->
	class AppRouter extends Backbone.Router
		routes:
			"": "login"
			"login": "login"
			"home": "home"

		login: () ->
			console.log "HELLO"
			loginView = new LoginView()
			$("#content").html(loginView.render().el)

		home: () ->
			homeView = new HomeView()
			$("#content").html(homeView.render().el)

	return AppRouter