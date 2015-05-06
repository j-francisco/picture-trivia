// Generated by CoffeeScript 1.9.0
(function() {
  var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  define(["backbone", "views/base_view", "text!tpl/categories.html", "views/game_view"], function(Backbone, BaseView, template, GameView) {
    var CategoriesView;
    CategoriesView = (function(_super) {
      __extends(CategoriesView, _super);

      function CategoriesView() {
        return CategoriesView.__super__.constructor.apply(this, arguments);
      }

      CategoriesView.prototype.template = _.template(template);

      CategoriesView.prototype.tagName = "div";

      CategoriesView.prototype.className = "hw-100";

      CategoriesView.prototype.render = function() {
        this.$el.html(this.template());
        return this;
      };

      return CategoriesView;

    })(BaseView);
    return CategoriesView;
  });

}).call(this);
