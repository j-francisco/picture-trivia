define ["backbone", 
	"views/base_view",
	"text!tpl/game.html", 
	"text!tpl/game_loading.html",
	"models/answer", 
	"collections/answer_collection", 
	"models/question",
	"models/game",
	"views/question_view"], (Backbone, BaseView, template, loadingTemplate, Answer, AnswerCollection, Question, Game, QuestionView) ->

	class GameView extends BaseView
		template: _.template(template)
		loadingTemplate: _.template(loadingTemplate)
		tagName: "div"
		className: "game"

		eventBus: [
			"question:answered": "questionAnswered"
		]

		currentQuestionIndex: 0

		subViews: []

		initialize: (options) ->
			@categoryName = options.categoryName
			game = new Game()
			gameDetails = 
				category_name: @categoryName
				user_id: localStorage.pictureTriviaUserId

			game.save(gameDetails, {
				success:(newGame) =>
					@startGame(newGame)
				error: (model, response, options) ->
					error = $.parseJSON(response.responseText).errors
					alert(error)
					Backbone.history.loadUrl("home")
			})	


		startGame: (game) ->
			@subViews = []
			@currentQuestionIndex = 0
			@game = game

			# q1 = new Question({
			# 	text: "Which country is this?"
			# 	answer_id: 2
			# 	img_src: "assets/img/countries/usa.png"
			# })

			# answers = new AnswerCollection()
			# answers.add(new Answer({id: 1, text: "Canada", question: q1}))
			# answers.add(new Answer({id: 2, text: "USA", question: q1}))
			# answers.add(new Answer({id: 3, text: "Mexico", question: q1}))
			# answers.add(new Answer({id: 4, text: "England", question: q1}))

			# q1.set("answers", answers)

			# q2 = new Question({
			# 	text: "Which country is this?"
			# 	answer_id: 1
			# 	img_src: "assets/img/countries/mexico.png"
			# })

			# answers = new AnswerCollection()
			# answers.add(new Answer({id: 1, text: "Mexico", question: q2}))
			# answers.add(new Answer({id: 2, text: "El Salvador", question: q2}))
			# answers.add(new Answer({id: 3, text: "USA", question: q2}))
			# answers.add(new Answer({id: 4, text: "Honduras", question: q2}))

			# q2.set("answers", answers)

			# q3 = new Question({
			# 	text: "Which country is this?"
			# 	answer_id: 3
			# 	img_src: "assets/img/countries/canada.png"
			# })

			# answers = new AnswerCollection()
			# answers.add(new Answer({id: 1, text: "USA", question: q3}))
			# answers.add(new Answer({id: 2, text: "Greenland", question: q3}))
			# answers.add(new Answer({id: 3, text: "Canada", question: q3}))
			# answers.add(new Answer({id: 4, text: "Iceland", question: q3}))

			# q3.set("answers", answers)

			# @questions = [q1, q2, q3]

			@render(true)

		render: (ready=false) ->
			if ready
				@$el.html(@template())

				@renderNextQuestion(0)
			else
				@$el.html(@loadingTemplate())

			return this

		renderNextQuestion: (questionIndex) ->
			@currentQuestionIndex = questionIndex

			questionJson = @game.get("questions")[questionIndex]

			if questionJson?

				previousQuestionView = @questionView

				question = new Question(questionJson) 
				@questionView = new QuestionView(model: question)

				@subViews.push @questionView

				questionContainer = @$el.find(".question-container")

				nextQuestionEl = @questionView.render().el

				if @currentQuestionIndex == 0
					questionContainer.html(nextQuestionEl)
					previousQuestionView.remove() if previousQuestionView?
				else
					questionContainer.fadeOut(400, () =>
						questionContainer.html(nextQuestionEl)
						questionContainer.fadeIn(400)
						previousQuestionView.remove() if previousQuestionView?
					)

			else
				alert("All Done!")


		questionAnswered: (questionId, answerId, isCorrect) ->
			nextIndex = @currentQuestionIndex + 1
			
			if @game.get("questions").length == nextIndex
				@submitAnswer(questionId, answerId, isCorrect, true)
				alert("All Done!")
			else
				@submitAnswer(questionId, answerId, isCorrect, false)
				setTimeout((() => @renderNextQuestion(nextIndex)), 1500)

		submitAnswer: (questionId, answerId, isCorrect, isFinished) ->
			$.ajax
				url: window.apiHost + "submit_answer"
				type: "PUT"
				data:
					user_id: localStorage.pictureTriviaUserId
					user_game_id: @game.get("user_game_id")
					selected_answer_id: answerId
					question_id: questionId
					is_finished: isFinished
				success: (result) ->
					console.log "question answered successfully"
				error: (result) ->
					console.log result.responseText
					console.log "question answer failed"


	return GameView