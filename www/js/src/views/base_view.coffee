define ["backbone"], (Backbone) ->
	class BaseView extends Backbone.View
		constructor: ->
			# If the view has event bus definitions, load them
			if @eventBus?
				_.each @eventBus, (item) =>
					key = Object.keys(item)[0]
					method = @[item[key]]
					PictureTrivia.eventBus.on key, method, @
					return

			BaseView.__super__.constructor.apply(this, arguments)

		remove: ->
			if @eventBus?
				_.each @eventBus, (item) =>
					key = Object.keys(item)[0]
					method = @[item[key]]
					PictureTrivia.eventBus.off key, method, @

			if @subViews?
				_.each @subViews, (subView) ->
					subView.remove()

			@undelegateEvents()

			Backbone.View.prototype.remove.call(this)
			return

		events: ->
			return _.extend({}, @baseEvents, @additionalEvents);

		goBack: () ->
			history.go(-1)
			# window.history.back()