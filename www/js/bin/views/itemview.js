// Generated by CoffeeScript 1.9.0
(function() {
  var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  define(["backbone", "text!tpl/item_template.html"], function(Backbone, template) {
    var ItemView;
    ItemView = (function(_super) {
      __extends(ItemView, _super);

      function ItemView() {
        return ItemView.__super__.constructor.apply(this, arguments);
      }

      ItemView.prototype.tagName = "div";

      ItemView.prototype.className = "item-wrap";

      ItemView.prototype.template = _.template(template);

      ItemView.prototype.render = function() {
        this.$el.html(this.template(this.model.toJSON()));
        return this;
      };

      return ItemView;

    })(Backbone.View);
    return ItemView;
  });

}).call(this);
