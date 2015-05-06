define ["backbone", 
	"views/base_view",
	"text!tpl/get_ready.html", 
	"views/game_view"], (Backbone, BaseView, template, GameView) ->

	class GetReadyView extends BaseView
		template: _.template(template)
		tagName: "div"
		# className: "hw-100"

		initialize: (options) ->
			@categoryName = options.categoryName

		render: () ->
			switch @categoryName
				when "world"
					img = "assets/img/countries/world.png"
					lbl = "World"
				when "north_america"
					img = ""
					lbl = "North America"
				when "south_america"
					img = ""
					lbl = "South America"
				when "europe"
					img = ""
					lbl = "Europe"
				when "asia"
					img = ""
					lbl = "Asia"
				when "africa"
					img = ""
					lbl = "Africa"
				else
					img = ""
					lbl = ""
					# redirect to home?

			@$el.html(@template({
				img: img
				lbl: lbl
			}))

			return this


	return GetReadyView