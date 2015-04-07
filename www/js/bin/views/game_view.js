// Generated by CoffeeScript 1.9.0
(function() {
  var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  define(["backbone", "views/base_view", "text!tpl/game.html", "models/answer", "collections/answer_collection", "models/question", "views/question_view"], function(Backbone, BaseView, template, Answer, AnswerCollection, Question, QuestionView) {
    var GameView;
    GameView = (function(_super) {
      __extends(GameView, _super);

      function GameView() {
        return GameView.__super__.constructor.apply(this, arguments);
      }

      GameView.prototype.template = _.template(template);

      GameView.prototype.tagName = "div";

      GameView.prototype.className = "game";

      GameView.prototype.eventBus = [
        {
          "question:answered": "questionAnswered"
        }
      ];

      GameView.prototype.currentQuestionIndex = 0;

      GameView.prototype.subViews = [];

      GameView.prototype.initialize = function() {
        var answers, q1, q2, q3;
        this.subViews = [];
        this.currentQuestionIndex = 0;
        q1 = new Question({
          text: "Who is this Game of Thrones character?",
          answer_id: 3,
          img_src: "assets/img/Tyrion.jpg"
        });
        answers = new AnswerCollection();
        answers.add(new Answer({
          id: 1,
          text: "Jon Snow",
          question: q1
        }));
        answers.add(new Answer({
          id: 2,
          text: "Tywin Lannister",
          question: q1
        }));
        answers.add(new Answer({
          id: 3,
          text: "Tyrion Lannister",
          question: q1
        }));
        answers.add(new Answer({
          id: 4,
          text: "Bran Stark",
          question: q1
        }));
        q1.set("answers", answers);
        q2 = new Question({
          text: "Who is this character from Lost?",
          answer_id: 4,
          img_src: "assets/img/john-locke.jpg"
        });
        answers = new AnswerCollection();
        answers.add(new Answer({
          id: 1,
          text: "Jack",
          question: q2
        }));
        answers.add(new Answer({
          id: 2,
          text: "Hurley",
          question: q2
        }));
        answers.add(new Answer({
          id: 3,
          text: "Sawyer",
          question: q2
        }));
        answers.add(new Answer({
          id: 4,
          text: "Locke",
          question: q2
        }));
        q2.set("answers", answers);
        q3 = new Question({
          text: "Who is this character from The Wire?",
          answer_id: 2,
          img_src: "assets/img/avon.jpg"
        });
        answers = new AnswerCollection();
        answers.add(new Answer({
          id: 1,
          text: "Jimmy McNulty",
          question: q3
        }));
        answers.add(new Answer({
          id: 2,
          text: "Avon Barksdale",
          question: q3
        }));
        answers.add(new Answer({
          id: 3,
          text: "Tommy Carcetti",
          question: q3
        }));
        answers.add(new Answer({
          id: 4,
          text: "Stringer Bell",
          question: q3
        }));
        q3.set("answers", answers);
        return this.questions = [q1, q2, q3];
      };

      GameView.prototype.render = function() {
        this.$el.html(this.template());
        this.renderNextQuestion(0);
        return this;
      };

      GameView.prototype.renderNextQuestion = function(questionIndex) {
        var question;
        this.currentQuestionIndex = questionIndex;
        question = this.questions[questionIndex];
        if (question != null) {
          if (this.questionView != null) {
            this.questionView.remove();
          }
          this.questionView = new QuestionView({
            question: question
          });
          this.subViews.push(this.questionView);
          return this.$el.find(".question-container").html(this.questionView.render().el);
        } else {
          return alert("All Done!");
        }
      };

      GameView.prototype.questionAnswered = function(correct) {
        return this.renderNextQuestion(this.currentQuestionIndex + 1);
      };

      return GameView;

    })(BaseView);
    return GameView;
  });

}).call(this);
