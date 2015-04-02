// Generated by CoffeeScript 1.9.0
(function() {
  var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  define(["backbone", "text!tpl/login_template.html"], function(Backbone, template) {
    var LoginView;
    LoginView = (function(_super) {
      __extends(LoginView, _super);

      function LoginView() {
        return LoginView.__super__.constructor.apply(this, arguments);
      }

      LoginView.prototype.template = _.template(template);

      LoginView.prototype.tagName = "div";

      LoginView.prototype.events = {
        "click .login-btn": "login"
      };

      LoginView.prototype.render = function() {
        this.$el.html(this.template());
        return this;
      };

      LoginView.prototype.login = function() {
        var email, password;
        Backbone.history.loadUrl('home/fade');
        return;
        email = this.$el.find("#loginEmail").val();
        password = this.$el.find("#loginPassword").val();
        console.log(email);
        console.log(password);
        return $.ajax({
          url: "http://localhost:5000/user_login",
          type: "POST",
          data: {
            email: email,
            password: password,
            remember_me: 1,
            commit: 'Log in'
          },
          success: function(result) {
            return Backbone.history.navigate('home/forward', true);
          },
          error: function(xhr, textStatus, errorThrown) {
            console.log(xhr);
            console.log(textStatus);
            return console.log(errorThrown);
          }
        });
      };

      return LoginView;

    })(Backbone.View);
    return LoginView;
  });

}).call(this);
