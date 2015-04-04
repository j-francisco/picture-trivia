define ["backbone", 
	"views/base_view",
	"text!tpl/question.html", 
	"models/answer", 
	"collections/answer_collection", 
	"models/question"], (Backbone, BaseView, template, Answer, AnswerCollection, Question) ->

	class QuestionView extends BaseView
		template: _.template(template)
		tagName: "div"

		render: () ->
			answers = new AnswerCollection()
			answers.add new Answer({id: 1, text: "Jon Snow"})
			answers.add new Answer({id: 2, text: "Tywin Lannister"})
			answers.add new Answer({id: 3, text: "Tyrion Lannister"})
			answers.add new Answer({id: 4, text: "Bran Stark"})

			question = new Question({
				text: "Who is this Game of Thrones character?"
				answer_id: 3
				answers: answers
			})

			@$el.html(@template(question: question))
			return this


	return QuestionView