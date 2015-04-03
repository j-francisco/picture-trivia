define ["backbone", 
	"text!tpl/home_template.html", 
	"models/answer", 
	"collections/answer_collection", 
	"models/question"], (Backbone, template, Answer, AnswerCollection, Question) ->

	class HomeView extends Backbone.View
		template: _.template(template)
		tagName: "div"

		# events:
		# 	"click .alert": "clickBtn"


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

		clickBtn: (e) ->
			alert("Hey Look")

	return HomeView