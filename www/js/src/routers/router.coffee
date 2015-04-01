define [
	"backbone", 
	"views/login_view",	
	"views/home_view"], (Backbone, LoginView, HomeView) ->
	class AppRouter extends Backbone.Router
		routes:
			"": "login"
			"login(/:direction)": "login"
			"home(/:direction)": "home"

		# execute: (callback, args) ->
		# 	# args.push(parseQueryString(args.pop()))
		# 	console.log "exec"
		# 	console.log args
		# 	if (callback) 
		# 		callback.apply(this, args)

		# todo - got correct back and forth sliding working. Now try to
		# update url to remove the direction param if possible.

		directionBack: "back"
		directionForward: "forward"

		login: (direction) ->
			loginView = new LoginView()

			data = 
				contents: loginView.render().$el
			options = 
				transition: if !direction then "none" else if direction == @directionBack then "slide-out"  else "slide-in"
				container: $("#content").children().first()
			
			@transition(data, options)

		home: (direction) ->
			homeView = new HomeView()
			
			data = 
				contents: homeView.render().$el
			options = 
				transition: if !direction then "none" else if direction == @directionBack then "slide-out"  else "slide-in"
				container: $("#content").children().first()

			@transition(data, options)


		transitionMap: {
			slideIn  : 'slide-out',
			slideOut : 'slide-in',
			fade     : 'fade'
		}

		bars: {
			bartab : '.bar-tab',
			barnav : '.bar-nav',
			barfooter : '.bar-footer',
			barheadersecondary : '.bar-header-secondary'
		}

		transition: (data, options) ->

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


			@swapContent(data.contents, options.container, options.transition, () -> )


		swapContent: (swap, container, transition, complete) ->
			transitionEnd = 'transitionend webkitTransitionEnd oTransitionEnd otransitionend';

			# debugger;
			if !transition || transition == "none"
				if container && container.length > 0
					container.parent().html(swap)
				else if (swap.hasClass('content'))
					$('body').append(swap)
				else
					$('.content').html(swap)

				complete && complete()

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
						complete && complete()
					
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

					console.log container
					slideEnd = () ->
						console.log "slide end"
						swap.removeClass('sliding')
						swap.removeClass('sliding-in')
						swap.removeClass(swapDirection)
						swap.removeClass('view-content')
						container.remove()
						complete && complete()

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

				complete && complete()


	return AppRouter