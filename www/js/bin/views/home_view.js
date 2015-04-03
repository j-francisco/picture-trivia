// Generated by CoffeeScript 1.9.0
(function() {
  var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  define(["backbone", "text!tpl/home_template.html", "models/answer", "collections/answer_collection", "models/question"], function(Backbone, template, Answer, AnswerCollection, Question) {
    var HomeView;
    HomeView = (function(_super) {
      __extends(HomeView, _super);

      function HomeView() {
        return HomeView.__super__.constructor.apply(this, arguments);
      }

      HomeView.prototype.template = _.template(template);

      HomeView.prototype.tagName = "div";

      HomeView.prototype.render = function() {
        var answers, question;
        answers = new AnswerCollection();
        answers.add(new Answer({
          id: 1,
          text: "Jon Snow"
        }));
        answers.add(new Answer({
          id: 2,
          text: "Tywin Lannister"
        }));
        answers.add(new Answer({
          id: 3,
          text: "Tyrion Lannister"
        }));
        answers.add(new Answer({
          id: 4,
          text: "Bran Stark"
        }));
        question = new Question({
          text: "Who is this Game of Thrones character?",
          answer_id: 3,
          answers: answers
        });
        this.$el.html(this.template({
          question: question
        }));
        return this;
      };

      HomeView.prototype.clickBtn = function(e) {
        return alert("Hey Look");
      };

      return HomeView;

    })(Backbone.View);
    return HomeView;
  });

}).call(this);
