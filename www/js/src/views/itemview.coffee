define(["backbone", "text!tpl/item_template.html"], (Backbone, template) ->
	class ItemView extends Backbone.View
		tagName: "div"
		className: "item-wrap"
		template: _.template(template)

		render: () ->
			this.$el.html(this.template(this.model.toJSON()))
			return this

	return ItemView
)