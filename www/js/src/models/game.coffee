define(["backbone"], (Backbone) ->
	class Game extends Backbone.Model
		urlRoot: window.apiHost + "games"
		
	return Game
)