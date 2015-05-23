define ["backbone", 
	"views/base_view",
	"text!tpl/final_score.html",
	"text!tpl/final_score_loading.html",
	"models/game"], (Backbone, BaseView, template, loadingTemplate, Game) ->

	class FinalScoreView extends BaseView
		template: _.template(template)
		loadingTemplate: _.template(loadingTemplate)

		initialize: (options) ->
			@gameId = options.gameId

		render: () ->
			@$el.html(@loadingTemplate())

			@game = new Game({id: @gameId})
			@game.fetch().done((data) => 
				console.log data
				@$el.html(@template(game: data))
			).fail(() =>
				Backbone.history.loadUrl("home")
			)
			
			return this

	return FinalScoreView