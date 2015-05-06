define(["backbone"], (Backbone) ->
	class Game extends Backbone.Model
		urlRoot: window.apiHost + "game"
		
	return Game
)