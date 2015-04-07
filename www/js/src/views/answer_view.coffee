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
			# answers = new AnswerCollection()
			# answers.add new Answer({id: 1, text: "Jon Snow"})
			# answers.add new Answer({id: 2, text: "Tywin Lannister"})
			# answers.add new Answer({id: 3, text: "Tyrion Lannister"})
			# answers.add new Answer({id: 4, text: "Bran Stark"})

			# question = new Question({
			# 	text: "Who is this Game of Thrones character?"
			# 	answer_id: 3
			# 	answers: answers
			# })

			@$el.html(@template(answer: @model.toJSON()))
			return this

		answerClicked: (e) ->
			if parseInt(@model.get("question").get("answer_id")) == parseInt(@model.id)
				@$el.addClass("answer-correct")
			else
				@$el.addClass("answer-wrong")

			PictureTrivia.eventBus.trigger("answer:clicked", @model.id)

	return AnswerView