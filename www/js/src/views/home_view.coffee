define ["backbone", 
	"views/base_view",
	"text!tpl/home.html", 
	"views/game_view"], (Backbone, BaseView, template, GameView) ->

	class HomeView extends BaseView
		template: _.template(template)
		tagName: "div"
		className: "home-start"

		# events:
		# 	"click .alert": "clickBtn"


		render: () ->
			@$el.html(@template())
			return this


	return HomeView