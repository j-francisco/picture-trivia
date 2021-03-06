define ["backbone", 
	"views/base_view",
	"text!tpl/home.html", 
	"views/game_view"], (Backbone, BaseView, template, GameView) ->

	class HomeView extends BaseView
		template: _.template(template)
		tagName: "div"
		className: "hw-100"

		render: () ->
			@$el.html(@template())
			return this


	return HomeView