define ["backbone"], (Backbone) ->
	class BaseHeaderView extends Backbone.View

		events: ->
			return _.extend({}, @baseEvents, @additionalEvents);

		goBack: () ->
			console.log "back"
			window.history.back()