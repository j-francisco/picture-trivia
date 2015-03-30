require.config({
	paths: {
		'jquery': '../lib/jquery',
		'underscore': '../lib/underscore',
		'backbone': '../lib/backbone-min',
		'text': '../lib/text',
		'fastclick': '../lib/fastclick'
	},
	waitSeconds: 15,
	shim: {
		'fastclick': {
			exports: 'FastClick'
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

items = [
	{ title: "Macbook Air", price: 799 },
	{ title: "Macbook Pro", price: 999 },
	{ title: "The new iPad", price: 399 },
	{ title: "Magic Mouse", price: 50 },
	{ title: "Cinema Display", price: 799 }
]

require(
	["jquery",
		"underscore",
		"backbone",
		"routers/router",
		"fastclick",
		"utils"
	],
	($, _, Backbone, AppRouter, fc) ->
		$(() ->
			app = new AppRouter()
			Backbone.history.start()
		)
)





# utils.loadTemplate([], () ->
# 	app = new AppRouter()
# 	console.log "HELLO?"
# 	Backbone.history.start()
# )

document.addEventListener 'deviceready', (->
	StatusBar.overlaysWebView false
	StatusBar.backgroundColorByHexString '#ffffff'
	StatusBar.styleDefault()
	FastClick.attach document.body
	if navigator.notification
		# Override default HTML alert with native dialog
		window.alert = (message) ->
			navigator.notification.alert message, null, 'Workshop', 'OK'
			return

	return
), false