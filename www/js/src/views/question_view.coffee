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
				@model = options.model

			render: () ->
				@$el.html(@template(question: @model))

				# @startCanvas()
				_.each @model.get("answers"), (answerJson) =>
					answer = new Answer(answerJson)
					answer.set("question", @model)
					answerView = new AnswerView(model: answer)
					@subViews.push answerView
					@$el.find(".answer-container").append(answerView.render().el)

				return this

			answerClicked: (answerId) ->
				correct = parseInt(answerId) == parseInt(@model.get("answer_id"))
				PictureTrivia.eventBus.trigger("question:answered", @model.get("id"), answerId, correct)


			
			# zoom and drag functionality learned from: http://phrogz.net/tmp/canvas_zoom_to_cursor.html

			startCanvas: () ->
				canvas = @$el.find('canvas')[0]
				@canvas = canvas
				# Adds ctx.getTransform() - returns an SVGMatrix
				# Adds ctx.transformedPoint(x,y) - returns an SVGPoint
				

				canvas.width = 800
				canvas.height = 600
				@gkhead = new Image

				ctx = canvas.getContext('2d')
				
				@trackTransforms(ctx)

				lastX = canvas.width / 2
				lastY = canvas.height / 2
				dragStart = undefined
				dragged = undefined
				canvas.addEventListener 'mousedown', ((evt) ->
					document.body.style.mozUserSelect = document.body.style.webkitUserSelect = document.body.style.userSelect = 'none'
					lastX = evt.offsetX or evt.pageX - canvas.offsetLeft
					lastY = evt.offsetY or evt.pageY - canvas.offsetTop
					dragStart = ctx.transformedPoint(lastX, lastY)
					dragged = false
					return
				), false
				canvas.addEventListener 'mousemove', ((evt) =>
					lastX = evt.offsetX or evt.pageX - canvas.offsetLeft
					lastY = evt.offsetY or evt.pageY - canvas.offsetTop
					dragged = true
					if dragStart
						pt = ctx.transformedPoint(lastX, lastY)
						ctx.translate pt.x - dragStart.x, pt.y - dragStart.y
						@redraw(ctx)
					return
				), false
				canvas.addEventListener 'mouseup', ((evt) ->
					dragStart = null
					if !dragged
						zoom(if evt.shiftKey then -1 else 1)
					return
				), false
				scaleFactor = 1.1

				zoom = (clicks) =>
					pt = ctx.transformedPoint(lastX, lastY)
					ctx.translate pt.x, pt.y
					factor = scaleFactor ** clicks
					ctx.scale factor, factor
					ctx.translate -pt.x, -pt.y
					@redraw(ctx)
					return

				handleScroll = (evt) ->
					delta = if evt.wheelDelta then evt.wheelDelta / 40 else if evt.detail then -evt.detail else 0
					if delta
						zoom delta
					evt.preventDefault() and false

				canvas.addEventListener 'DOMMouseScroll', handleScroll, false
				canvas.addEventListener 'mousewheel', handleScroll, false

				@gkhead.src = 'assets/img/countries/usa.png'

				@redraw(ctx)
				

			trackTransforms: (ctx) ->
				svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg')
				xform = svg.createSVGMatrix()

				ctx.getTransform = ->
					xform

				savedTransforms = []
				save = ctx.save

				ctx.save = ->
					savedTransforms.push xform.translate(0, 0)
					save.call ctx

				restore = ctx.restore

				ctx.restore = ->
					xform = savedTransforms.pop()
					restore.call ctx

				scale = ctx.scale

				ctx.scale = (sx, sy) ->
					xform = xform.scaleNonUniform(sx, sy)
					scale.call ctx, sx, sy

				rotate = ctx.rotate

				ctx.rotate = (radians) ->
					xform = xform.rotate(radians * 180 / Math.PI)
					rotate.call ctx, radians

				translate = ctx.translate

				ctx.translate = (dx, dy) ->
					xform = xform.translate(dx, dy)
					translate.call ctx, dx, dy

				transform = ctx.transform

				ctx.transform = (a, b, c, d, e, f) ->
					m2 = svg.createSVGMatrix()
					m2.a = a
					m2.b = b
					m2.c = c
					m2.d = d
					m2.e = e
					m2.f = f
					xform = xform.multiply(m2)
					transform.call ctx, a, b, c, d, e, f

				setTransform = ctx.setTransform

				ctx.setTransform = (a, b, c, d, e, f) ->
					xform.a = a
					xform.b = b
					xform.c = c
					xform.d = d
					xform.e = e
					xform.f = f
					setTransform.call ctx, a, b, c, d, e, f

				pt = svg.createSVGPoint()

				ctx.transformedPoint = (x, y) ->
					pt.x = x
					pt.y = y
					pt.matrixTransform xform.inverse()

				return

			redraw: (ctx) ->
				# Clear the entire canvas
				p1 = ctx.transformedPoint(0, 0)
				p2 = ctx.transformedPoint(@canvas.width, @canvas.height)
				ctx.clearRect p1.x, p1.y, p2.x - p1.x, p2.y - p1.y
				
				ctx.drawImage @gkhead, 0, 0
				
				return


		return QuestionView