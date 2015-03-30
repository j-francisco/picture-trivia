// Generated by CoffeeScript 1.9.0
(function() {
  var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  define(["backbone", "views/itemcollectionview", "collections/cart"], function(Backbone, ItemCollectionView, Cart) {
    var CartCollectionView;
    CartCollectionView = (function(_super) {
      __extends(CartCollectionView, _super);

      function CartCollectionView() {
        return CartCollectionView.__super__.constructor.apply(this, arguments);
      }

      CartCollectionView.prototype.events = {
        "submit #add": "addItem",
        "submit #filter": "filterItems",
        "click #clear-filter": "clearFilter"
      };

      CartCollectionView.prototype.initialize = function(items) {
        var cartCollection;
        cartCollection = new Cart(items);
        return this.itemView = new ItemCollectionView(cartCollection);
      };

      CartCollectionView.prototype.addItem = function(e) {
        e.preventDefault();
        return this.itemView.addItem();
      };

      CartCollectionView.prototype.filterItems = function(e) {
        e.preventDefault();
        return this.itemView.filterByPrice();
      };

      CartCollectionView.prototype.clearFilter = function(e) {
        e.preventDefault();
        return this.itemView.clearFilter();
      };

      return CartCollectionView;

    })(Backbone.View);
    return CartCollectionView;
  });

}).call(this);
