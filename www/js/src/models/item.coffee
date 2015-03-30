define(["backbone"], (Backbone) ->
	class Item extends Backbone.Model
		defaults:
			price: 35,
			photo: "http://www.placedog.com/100/100"
	
	return Item
)