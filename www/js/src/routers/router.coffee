define [
	"backbone", 
	"views/base_header_view",
	"views/login_view",	
	"views/home_view",
	"views/game_view"],	(Backbone, 
		BaseHeaderView,
		LoginView, 
		HomeView,
		GameView) ->

	class AppRouter extends Backbone.Router
		routes:
			"": "home"
			"login(/:direction)": "login"
			"home(/:direction)": "home"
			"game(/:direction)": "game"

		directionBack: "back"
		directionForward: "forward"
		directionFade: "fade"

		initialize: () ->
			@currentHeader = new BaseHeaderView()
			$("header").html(@currentHeader.render().el)

		execute: (callback, args) ->
			if @beforeRoute(callback)
				# if beforeRoute returns true, we can continue.
				# beforeRoute returns false if some validation failed and it redirected

				callback.apply(this, args) if callback	

				@afterRoute()

		routeRequiresAuth: (callback) ->
			# list of routes that don't require authentication
			nonAuthRoutes = [@login]
			
			return !_.contains(nonAuthRoutes, callback)

		routeNotAccessibleAfterAuth: (callback) ->
			# list of routes that you shouldn't get to if your logged in.
			noAccessAfterAuthRoutes = [@login]

			return _.contains(noAccessAfterAuthRoutes, callback)

		beforeRoute: (callback) ->
			@currentView.remove() if @currentView?

			# if callback is null, not much we can do
			return false if !callback

			# if the callback route requires auth, then we need to check auth
			if @routeRequiresAuth(callback) && !@auth()
				# auth failed, redirect to login
				@navigate("login", true) 
				return false	

			else if @routeNotAccessibleAfterAuth(callback) && @auth()
				# you shouldn't get to this route if your logged in, so redirect to root
				@navigate("", true)
				return false

			return true

		afterRoute: () ->


		auth: () ->
			return localStorage.loginEmail?

		login: (direction) ->
			@currentView = new LoginView()

			el = @currentView.render().$el

			@transition(el, direction)

			@navigate("login")

		home: (direction) ->
			@currentView = new HomeView()
			
			el = @currentView.render().$el

			@transition(el, direction)

			@navigate("home")

		game: (direction) ->
			@currentView = new GameView()

			el = @currentView.render().$el

			@transition(el, direction)

			@navigate("game")

		bars: {
			bartab : '.bar-tab',
			barnav : '.bar-nav',
			barfooter : '.bar-footer',
			barheadersecondary : '.bar-header-secondary'
		}

		#TODO - updating header and footer buttons/menus etc.
		# idea - each view could have its own header and footer that also gets updated here.
		# have a base view to handle the common defaults.
		# the bars above will be key to this i think
		
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