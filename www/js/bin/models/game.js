// Generated by CoffeeScript 1.9.0
(function() {
  var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  define(["backbone"], function(Backbone) {
    var Game;
    Game = (function(_super) {
      __extends(Game, _super);

      function Game() {
        return Game.__super__.constructor.apply(this, arguments);
      }

      Game.prototype.urlRoot = window.apiHost + "games";

      return Game;

    })(Backbone.Model);
    return Game;
  });

}).call(this);
