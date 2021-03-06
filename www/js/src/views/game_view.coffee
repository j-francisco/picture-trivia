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
				# something went wrong if you get here
				@endGame()


		questionAnswered: (questionId, answerId, isCorrect) ->
			nextIndex = @currentQuestionIndex + 1
			
			if @game.get("questions").length == nextIndex
				@submitAnswer(questionId, answerId, isCorrect, true)
				@endGame()
			else
				@submitAnswer(questionId, answerId, isCorrect, false)
				setTimeout((() => @renderNextQuestion(nextIndex)), 750)

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

		endGame: () ->
			setTimeout((() => 
				url = "final_score/#{@game.id}/forward"
				Backbone.history.loadUrl(url)), 750)


	return GameView