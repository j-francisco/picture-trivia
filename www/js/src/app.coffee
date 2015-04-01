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
		"ratchet"
	],
	($, _, Backbone, AppRouter, fc, ratchet) ->
		$(() ->
			$(document).on("click", "a:not([data-bypass])", (evt) ->
				href = 
					prop: $(this).prop("href"), 
					attr: $(this).attr("href")

				root = location.protocol + "//" + location.host + Backbone.history.options.root

				if (href.prop && href.prop.slice(0, root.length) == root)
					evt.preventDefault()
					Backbone.history.navigate(href.attr, true)
			)

			app = new AppRouter()
			Backbone.history.start()
		)
)




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