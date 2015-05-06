define ["backbone", 
	"views/base_view",
	"text!tpl/categories.html", 
	"views/game_view"], (Backbone, BaseView, template, GameView) ->

	class CategoriesView extends BaseView
		template: _.template(template)
		tagName: "div"
		className: "hw-100"

		render: () ->
			@$el.html(@template())
			return this


	return CategoriesView