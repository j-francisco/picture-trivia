define [
	"backbone", 
	"views/base_header_view",
	"views/login_view",	
	"views/home_view",
	"views/categories_view",
	"views/get_ready_view",
	"views/game_view",
	"views/final_score_view"],	(Backbone, 
		BaseHeaderView,
		LoginView, 
		HomeView,
		CategoriesView,
		GetReadyView,
		GameView,
		FinalScoreView) ->

	class AppRouter extends Backbone.Router
		routes:
			"": "home"
			"login(/:direction)": "login"
			"home(/:direction)": "home"
			"game/:category(/:direction)": "game"
			"categories(/:direction)": "categories"
			"get_ready/:category(/:direction)": "getReady"
			"final_score/:game_id(/:direction)": "finalScore"

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
			return localStorage.pictureTriviaLoginEmail? && localStorage.pictureTriviaUserId

		resetCurrentView: (view) ->
			@currentView.remove() if @currentView?

			@currentView = view

		login: (direction) ->
			view = new LoginView()

			el = view.render().$el

			@transition(el, direction)

			@resetCurrentView(view)

			@navigate("login")

		home: (direction) ->
			view = new HomeView()
			
			el = view.render().$el

			@transition(el, direction)

			@resetCurrentView(view)

			@navigate("home")

		game: (categoryName, direction) ->
			view = new GameView({categoryName: categoryName})

			el = view.render().$el

			@transition(el, direction)

			@resetCurrentView(view)

			@navigate("game")

		categories: (direction) ->
			view = new CategoriesView()

			el = view.render().$el

			@transition(el, direction)

			@resetCurrentView(view)

			@navigate("categories")

		getReady: (categoryName, direction) ->
			view = new GetReadyView({categoryName: categoryName})

			el = view.render().$el

			@transition(el, direction)

			@resetCurrentView(view)

			@navigate("get_ready")

		finalScore: (gameId, direction) ->
			view = new FinalScoreView({gameId: gameId})

			el = view.render().$el 

			@transition(el, direction)

			@resetCurrentView(view)

			@navigate("final_score")
		
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

			@swapContent(data.contents, options.container, options.transition, callback)


		swapContent: (swap, container, transition, callback) ->
			transitionEnd = 'transitionend webkitTransitionEnd oTransitionEnd otransitionend';
			# debugger;
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