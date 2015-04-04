define ["backbone", 
	"views/base_view",
	"text!tpl/home.html", 
	"models/answer", 
	"collections/answer_collection", 
	"models/question"], (Backbone, BaseView, template, Answer, AnswerCollection, Question) ->

	class HomeView extends BaseView
		template: _.template(template)
		tagName: "div"
		className: "home-start"

		# events:
		# 	"click .alert": "clickBtn"


		render: () ->
			@$el.html(@template())
			return this


	return HomeView