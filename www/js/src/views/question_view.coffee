define ["backbone", 
	"views/base_view",
	"text!tpl/question.html", 
	"models/answer", 
	"collections/answer_collection", 
	"models/question",
	"views/answer_view"], (Backbone, BaseView, template, Answer, AnswerCollection, Question, AnswerView) ->

	class QuestionView extends BaseView
		template: _.template(template)
		tagName: "div"

		eventBus: [
			"answer:clicked": "answerClicked"
		]

		subViews: []

		initialize: (options) ->
			@subViews = []
			@model = options.question

		render: () ->
			@$el.html(@template(question: @model))

			@model.get("answers").each (answer) =>
				answerView = new AnswerView(model: answer)
				@subViews.push answerView
				@$el.find(".answer-container").append(answerView.render().el)

			return this

		answerClicked: (answerId) ->
			correct = parseInt(answerId) == parseInt(@model.get("answer_id"))
			PictureTrivia.eventBus.trigger("question:answered", correct)



	return QuestionView