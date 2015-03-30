define(["backbone", "models/item"], (Backbone, Item) ->
  class Cart extends Backbone.Collection
    model: Item

    initialize: () ->
      this.on("add", this.updateSet, this)

    updateSet: () ->
      items = this.models

  return Cart
)