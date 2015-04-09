define ["backbone", 
	"views/base_view",
	"text!tpl/game.html", 
	"models/answer", 
	"collections/answer_collection", 
	"models/question",
	"views/question_view"], (Backbone, BaseView, template, Answer, AnswerCollection, Question, QuestionView) ->

	class GameView extends BaseView
		template: _.template(template)
		tagName: "div"
		className: "game"

		eventBus: [
			"question:answered": "questionAnswered"
		]

		currentQuestionIndex: 0

		subViews: []

		initialize: () ->
			@subViews = []
			@currentQuestionIndex = 0

			q1 = new Question({
				text: "Which country is this?"
				answer_id: 2
				img_src: "assets/img/countries/usa.png"
			})

			answers = new AnswerCollection()
			answers.add(new Answer({id: 1, text: "Canada", question: q1}))
			answers.add(new Answer({id: 2, text: "USA", question: q1}))
			answers.add(new Answer({id: 3, text: "Mexico", question: q1}))
			answers.add(new Answer({id: 4, text: "England", question: q1}))

			q1.set("answers", answers)

			q2 = new Question({
				text: "Which country is this?"
				answer_id: 1
				img_src: "assets/img/countries/mexico.png"
			})

			answers = new AnswerCollection()
			answers.add(new Answer({id: 1, text: "Mexico", question: q2}))
			answers.add(new Answer({id: 2, text: "El Salvador", question: q2}))
			answers.add(new Answer({id: 3, text: "USA", question: q2}))
			answers.add(new Answer({id: 4, text: "Honduras", question: q2}))

			q2.set("answers", answers)

			q3 = new Question({
				text: "Which country is this?"
				answer_id: 3
				img_src: "assets/img/countries/canada.png"
			})

			answers = new AnswerCollection()
			answers.add(new Answer({id: 1, text: "USA", question: q3}))
			answers.add(new Answer({id: 2, text: "Greenland", question: q3}))
			answers.add(new Answer({id: 3, text: "Canada", question: q3}))
			answers.add(new Answer({id: 4, text: "Iceland", question: q3}))

			q3.set("answers", answers)

			@questions = [q1, q2, q3]

		render: () ->
			@$el.html(@template())

			@renderNextQuestion(0)

			return this

		renderNextQuestion: (questionIndex) ->
			@currentQuestionIndex = questionIndex

			question = @questions[questionIndex]

			if question?

				@questionView.remove() if @questionView?

				@questionView = new QuestionView(question: question)

				@subViews.push @questionView

				@$el.find(".question-container").html(@questionView.render().el)

			else
				alert("All Done!")


		questionAnswered: (correct) ->
			@renderNextQuestion(@currentQuestionIndex + 1)


	return GameView