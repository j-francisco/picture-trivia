define ["backbone",
	"views/base_view",
	"text!tpl/default_header.html"], (Backbone, BaseView, template) ->
	class BaseHeaderView extends BaseView
		template: _.template(template)

		additionalEvents:
			'click .go-back': 'goBack'

		render: () ->
			@$el.html(@template())
			return this

		goBack: () ->
			Backbone.history.history.back()