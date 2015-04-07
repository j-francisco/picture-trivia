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
				text: "Who is this Game of Thrones character?"
				answer_id: 3
				img_src: "assets/img/Tyrion.jpg"
			})

			answers = new AnswerCollection()
			answers.add(new Answer({id: 1, text: "Jon Snow", question: q1}))
			answers.add(new Answer({id: 2, text: "Tywin Lannister", question: q1}))
			answers.add(new Answer({id: 3, text: "Tyrion Lannister", question: q1}))
			answers.add(new Answer({id: 4, text: "Bran Stark", question: q1}))

			q1.set("answers", answers)

			q2 = new Question({
				text: "Who is this character from Lost?"
				answer_id: 4
				img_src: "assets/img/john-locke.jpg"
			})

			answers = new AnswerCollection()
			answers.add(new Answer({id: 1, text: "Jack", question: q2}))
			answers.add(new Answer({id: 2, text: "Hurley", question: q2}))
			answers.add(new Answer({id: 3, text: "Sawyer", question: q2}))
			answers.add(new Answer({id: 4, text: "Locke", question: q2}))

			q2.set("answers", answers)

			q3 = new Question({
				text: "Who is this character from The Wire?"
				answer_id: 2
				img_src: "assets/img/avon.jpg"
			})

			answers = new AnswerCollection()
			answers.add(new Answer({id: 1, text: "Jimmy McNulty", question: q3}))
			answers.add(new Answer({id: 2, text: "Avon Barksdale", question: q3}))
			answers.add(new Answer({id: 3, text: "Tommy Carcetti", question: q3}))
			answers.add(new Answer({id: 4, text: "Stringer Bell", question: q3}))

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