// Generated by CoffeeScript 1.9.0
(function() {
  var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  define(["backbone", "views/base_view", "text!tpl/question.html", "models/answer", "collections/answer_collection", "models/question", "views/answer_view"], function(Backbone, BaseView, template, Answer, AnswerCollection, Question, AnswerView) {
    var QuestionView;
    QuestionView = (function(_super) {
      __extends(QuestionView, _super);

      function QuestionView() {
        return QuestionView.__super__.constructor.apply(this, arguments);
      }

      QuestionView.prototype.template = _.template(template);

      QuestionView.prototype.tagName = "div";

      QuestionView.prototype.eventBus = [
        {
          "answer:clicked": "answerClicked"
        }
      ];

      QuestionView.prototype.subViews = [];

      QuestionView.prototype.initialize = function(options) {
        this.subViews = [];
        return this.model = options.model;
      };

      QuestionView.prototype.render = function() {
        this.$el.html(this.template({
          question: this.model
        }));
        _.each(this.model.get("answers"), (function(_this) {
          return function(answerJson) {
            var answer, answerView;
            answer = new Answer(answerJson);
            answer.set("question", _this.model);
            answerView = new AnswerView({
              model: answer
            });
            _this.subViews.push(answerView);
            return _this.$el.find(".answer-container").append(answerView.render().el);
          };
        })(this));
        return this;
      };

      QuestionView.prototype.answerClicked = function(answerId) {
        var correct;
        correct = parseInt(answerId) === parseInt(this.model.get("answer_id"));
        return PictureTrivia.eventBus.trigger("question:answered", this.model.get("id"), answerId, correct);
      };

      QuestionView.prototype.startCanvas = function() {
        var canvas, ctx, dragStart, dragged, handleScroll, lastX, lastY, scaleFactor, zoom;
        canvas = this.$el.find('canvas')[0];
        this.canvas = canvas;
        canvas.width = 800;
        canvas.height = 600;
        this.gkhead = new Image;
        ctx = canvas.getContext('2d');
        this.trackTransforms(ctx);
        lastX = canvas.width / 2;
        lastY = canvas.height / 2;
        dragStart = void 0;
        dragged = void 0;
        canvas.addEventListener('mousedown', (function(evt) {
          document.body.style.mozUserSelect = document.body.style.webkitUserSelect = document.body.style.userSelect = 'none';
          lastX = evt.offsetX || evt.pageX - canvas.offsetLeft;
          lastY = evt.offsetY || evt.pageY - canvas.offsetTop;
          dragStart = ctx.transformedPoint(lastX, lastY);
          dragged = false;
        }), false);
        canvas.addEventListener('mousemove', ((function(_this) {
          return function(evt) {
            var pt;
            lastX = evt.offsetX || evt.pageX - canvas.offsetLeft;
            lastY = evt.offsetY || evt.pageY - canvas.offsetTop;
            dragged = true;
            if (dragStart) {
              pt = ctx.transformedPoint(lastX, lastY);
              ctx.translate(pt.x - dragStart.x, pt.y - dragStart.y);
              _this.redraw(ctx);
            }
          };
        })(this)), false);
        canvas.addEventListener('mouseup', (function(evt) {
          dragStart = null;
          if (!dragged) {
            zoom(evt.shiftKey ? -1 : 1);
          }
        }), false);
        scaleFactor = 1.1;
        zoom = (function(_this) {
          return function(clicks) {
            var factor, pt;
            pt = ctx.transformedPoint(lastX, lastY);
            ctx.translate(pt.x, pt.y);
            factor = Math.pow(scaleFactor, clicks);
            ctx.scale(factor, factor);
            ctx.translate(-pt.x, -pt.y);
            _this.redraw(ctx);
          };
        })(this);
        handleScroll = function(evt) {
          var delta;
          delta = evt.wheelDelta ? evt.wheelDelta / 40 : evt.detail ? -evt.detail : 0;
          if (delta) {
            zoom(delta);
          }
          return evt.preventDefault() && false;
        };
        canvas.addEventListener('DOMMouseScroll', handleScroll, false);
        canvas.addEventListener('mousewheel', handleScroll, false);
        this.gkhead.src = 'assets/img/countries/usa.png';
        return this.redraw(ctx);
      };

      QuestionView.prototype.trackTransforms = function(ctx) {
        var pt, restore, rotate, save, savedTransforms, scale, setTransform, svg, transform, translate, xform;
        svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
        xform = svg.createSVGMatrix();
        ctx.getTransform = function() {
          return xform;
        };
        savedTransforms = [];
        save = ctx.save;
        ctx.save = function() {
          savedTransforms.push(xform.translate(0, 0));
          return save.call(ctx);
        };
        restore = ctx.restore;
        ctx.restore = function() {
          xform = savedTransforms.pop();
          return restore.call(ctx);
        };
        scale = ctx.scale;
        ctx.scale = function(sx, sy) {
          xform = xform.scaleNonUniform(sx, sy);
          return scale.call(ctx, sx, sy);
        };
        rotate = ctx.rotate;
        ctx.rotate = function(radians) {
          xform = xform.rotate(radians * 180 / Math.PI);
          return rotate.call(ctx, radians);
        };
        translate = ctx.translate;
        ctx.translate = function(dx, dy) {
          xform = xform.translate(dx, dy);
          return translate.call(ctx, dx, dy);
        };
        transform = ctx.transform;
        ctx.transform = function(a, b, c, d, e, f) {
          var m2;
          m2 = svg.createSVGMatrix();
          m2.a = a;
          m2.b = b;
          m2.c = c;
          m2.d = d;
          m2.e = e;
          m2.f = f;
          xform = xform.multiply(m2);
          return transform.call(ctx, a, b, c, d, e, f);
        };
        setTransform = ctx.setTransform;
        ctx.setTransform = function(a, b, c, d, e, f) {
          xform.a = a;
          xform.b = b;
          xform.c = c;
          xform.d = d;
          xform.e = e;
          xform.f = f;
          return setTransform.call(ctx, a, b, c, d, e, f);
        };
        pt = svg.createSVGPoint();
        ctx.transformedPoint = function(x, y) {
          pt.x = x;
          pt.y = y;
          return pt.matrixTransform(xform.inverse());
        };
      };

      QuestionView.prototype.redraw = function(ctx) {
        var p1, p2;
        p1 = ctx.transformedPoint(0, 0);
        p2 = ctx.transformedPoint(this.canvas.width, this.canvas.height);
        ctx.clearRect(p1.x, p1.y, p2.x - p1.x, p2.y - p1.y);
        ctx.drawImage(this.gkhead, 0, 0);
      };

      return QuestionView;

    })(BaseView);
    return QuestionView;
  });

}).call(this);
