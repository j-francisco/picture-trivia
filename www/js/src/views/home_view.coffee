define ["backbone", "text!tpl/home_template.html"], (Backbone, template) ->
	class HomeView extends Backbone.View
		template: _.template(template)

		render: () ->
			@$el.html(@template())
			return this

	return HomeView