define(
	["backbone",
		"views/itemcollectionview",
		"collections/cart"
	], (Backbone, ItemCollectionView, Cart) ->
		class CartCollectionView extends Backbone.View
			events:
				"submit #add": "addItem",
				"submit #filter": "filterItems",
				"click #clear-filter": "clearFilter"
			
			initialize: (items) ->
				cartCollection = new Cart(items)
				this.itemView = new ItemCollectionView(cartCollection)

			addItem: (e) ->
				e.preventDefault()
				this.itemView.addItem()
			
			filterItems: (e) ->
				e.preventDefault()
				this.itemView.filterByPrice()
			
			clearFilter: (e) ->
				e.preventDefault()
				this.itemView.clearFilter()

		return CartCollectionView
)