define ["backbone", "text!tpl/home_template.html"], (Backbone, template) ->
	class HomeView extends Backbone.View
		template: _.template(template)
		tagName: "div"

		events:
			"click .my-button": "clickBtn"

		render: () ->
			@$el.html(@template())
			return this

		clickBtn: (e) ->
			alert("Hey Look")

	return HomeView