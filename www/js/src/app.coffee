window.apiHost = "http://localhost:5000/"

require.config({
	paths: {
		'jquery': '../lib/jquery',
		'underscore': '../lib/underscore',
		'backbone': '../lib/backbone-min',
		'text': '../lib/text',
		'fastclick': '../lib/fastclick',
		'pageslider': '../lib/pageslider',
		'ratchet': '../lib/ratchet'
	},
	waitSeconds: 15,
	shim: {
		'fastclick': {
			exports: 'FastClick'
		},
		'pageslider': {
			exports: 'PageSlider'
		},
		'underscore': {
			exports: '_'
		},
		'backbone': {
			deps: ["underscore", "jquery"],
			exports: 'Backbone'
		}
	}
})

require(
	["jquery",
		"underscore",
		"backbone",
		"routers/router",
		"fastclick",
		"ratchet"
	],
	($, _, Backbone, AppRouter, fc, ratchet) ->
		$(() ->
			auth = (callback) ->
				email = localStorage.loginEmail

				if email?
					console.log "ajax"
					$.ajax
						url: window.apiHost + "user_login"
						type: "POST"
						data:
							email: email
						success: () ->
							callback(true)
						error: () ->
							localStorage.removeItem("loginEmail")
							callback(false)
				else
					callback(false)

			startUp = (loggedIn) ->
				app = new AppRouter()
				Backbone.history.start()

				if loggedIn
					Backbone.history.loadUrl("home")
				else
					console.log "fail?"
					Backbone.history.loadUrl("login")
			
			$(document).ready(() ->
				auth(() ->
					startUp()
				)
				
				return
			)

			document.addEventListener 'deviceready', (->				
				StatusBar.overlaysWebView false
				StatusBar.backgroundColorByHexString '#ffffff'
				StatusBar.styleDefault()
				FastClick.attach document.body
				if navigator.notification
					# Override default HTML alert with native dialog
					window.alert = (message, title='Picture Trivia', btnText='OK') ->
						navigator.notification.alert message, null, title, btnText
						return
			), false

			$(document).on("click", "a:not([data-skip])", (evt) ->
				href = 
					prop: $(this).prop("href"), 
					attr: $(this).attr("href")

				root = location.protocol + "//" + location.host + Backbone.history.options.root
				
				if (href.prop && href.prop.slice(0, root.length) == root)
					evt.preventDefault()
					Backbone.history.loadUrl(href.attr)
			)

			
		)
)

