define ["backbone", 
	"views/base_view",
	"text!tpl/answer.html",
	"models/Answer"], (Backbone, BaseView, template, Answer) ->

	class AnswerView extends BaseView
		template: _.template(template)
		tagName: "button"
		className: "btn btn-primary btn-block btn-outlined answer"

		additionalEvents:
			"click": "answerClicked"

		initialize: (options) ->
			@model = options.model

		render: () ->
			@$el.html(@template(answer: @model.toJSON()))
			return this

		answerClicked: (e) ->
			if parseInt(@model.get("question").get("correct_answer_id")) == parseInt(@model.id)
				@$el.addClass("answer-correct")
			else
				@$el.addClass("answer-wrong")

			PictureTrivia.eventBus.trigger("answer:clicked", @model.id)

	return AnswerView