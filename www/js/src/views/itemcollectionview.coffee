define(["backbone", "models/item", "views/itemview"], (Backbone, Item, ItemView) ->
	class ItemCollectionView extends Backbone.View
		el: '#yourcart',
		initialize: (collection) ->
			this.collection = collection
			this.render()
			this.collection.on("reset", this.render, this)

		render: () ->
			this.$el.html("")
			this.collection.each((item) ->
				this.renderItem(item)
			, this)

		renderItem: (item) ->
			itemView = new ItemView({model: item})
			this.$el.append(itemView.render().el)

		addItem: () ->
			data = {}
			$("#add").children("input[type='text']").each((i, el) ->
				data[el.id] = $(el).val()
			)
			newItem = new Item(data)
			this.collection.add(newItem)
			this.renderItem(newItem)

		filterByPrice: () ->
			# first reset the collection
			# but do it silently so the event doesn't trigger
			this.collection.reset(items, { silent: true })
			max = parseFloat($("#less-than").val(), 10)
			filtered = _.filter(this.collection.models, (item) ->
				return item.get("price") < max;
			)
			# trigger reset again
			# but this time trigger the event so the collection view is rerendered
			this.collection.reset(filtered)
		
		clearFilter: () ->
			$("#less-than").val("")
			this.collection.reset(items)
		

	return ItemCollectionView;
)