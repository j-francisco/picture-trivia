define [
	"backbone", 
	"views/login_view",	
	"views/home_view"], (Backbone, LoginView, HomeView) ->
	class AppRouter extends Backbone.Router
		routes:
			"": "login"
			"login(/:direction)": "login"
			"home(/:direction)": "home"

		directionBack: "back"
		directionForward: "forward"
		directionFade: "fade"

		login: (direction) ->
			@navigate("login")

			loginView = new LoginView()

			el = loginView.render().$el

			@transition(el, direction)

		home: (direction) ->
			@navigate("home")

			homeView = new HomeView()
			
			el = homeView.render().$el
			
			@transition(el, direction)

		bars: {
			bartab : '.bar-tab',
			barnav : '.bar-nav',
			barfooter : '.bar-footer',
			barheadersecondary : '.bar-header-secondary'
		}

		transition: (el, direction, container, callback) ->
			transition = switch
				when direction == @directionBack then "slide-out"
				when direction == @directionForward then "slide-in"
				when direction == @directionFade then "fade"
				else "none"

			container = if container? then container else $("#content").children().first()

			data = 
				contents: el

			options = 
				transition: transition
				container: container
				callback: callback

			@doTransition(data, options, callback)

		doTransition: (data, options, callback) ->
			
			if data.title
				document.title = data.title;

			if options.transition
				for key in @bars
					if @bars.hasOwnProperty(key)
						barElement = $(@bars[key])
						if (data[key]) 
							swapContent(data[key], barElement)
						else if (barElement)
							barElement.remove()

			@swapContent(data.contents, options.container, options.transition, callback)


		swapContent: (swap, container, transition, callback) ->
			transitionEnd = 'transitionend webkitTransitionEnd oTransitionEnd otransitionend';

			if !transition || transition == "none"
				if container && container.length > 0
					container.parent().html(swap)
				else if (swap.hasClass('content'))
					$('body').append(swap)
				else
					$('.content').html(swap)

				callback && callback()

			else if container && container.length > 0
				enter  = /in$/.test(transition);

				if (transition == 'fade')
					container.addClass('in')
					container.addClass('fade')
					swap.addClass('fade')

					container.parent().prepend(swap)

					container[0].offsetWidth; # force reflow
					container.removeClass('in')
					fadeContainerEnd = () ->
						swap.addClass('in')
						swap.one(transitionEnd, fadeSwapEnd)
					
					fadeSwapEnd = () ->
						container.remove()
						swap.removeClass('fade')
						swap.removeClass('in')
						callback && callback()
					
					container.one(transitionEnd, fadeContainerEnd)

				if (/slide/.test(transition))					
					swap.addClass('view-content')
					swap.addClass('sliding-in')
					swapDirection = if enter then 'right' else 'left'
					swap.addClass(swapDirection)
					swap.addClass('sliding')
					container.addClass('view-content')
					container.addClass('sliding')

					container.parent().prepend(swap)

					slideEnd = () ->
						swap.removeClass('sliding')
						swap.removeClass('sliding-in')
						swap.removeClass(swapDirection)
						swap.removeClass('view-content')
						container.remove()
						callback && callback()

					container[0].offsetWidth; # force reflow
					swapDirection      = if enter then 'right' else 'left'
					containerDirection = if enter then 'left' else 'right'
					container.addClass(containerDirection)
					swap.removeClass(swapDirection)
					swap.one(transitionEnd, slideEnd)

			else
				if swap.hasClass('content')
					$('body').append(swap)
				else
					$('.content').html(swap)

				callback && callback()


	return AppRouter