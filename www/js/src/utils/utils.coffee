window.utils =
	# TODO - in production, all templates should be in one file so it doesn't have to
    # make a request for each file. Maybe use grunt.
    # http://stackoverflow.com/questions/8366733/external-template-in-underscore

    # Asynchronously load templates located in separate .html files
    # shoudn't need this anymore now that I'm using require.js
	loadTemplate: (views, callback) ->
		deferreds = []
		$.each views, (index, view) ->
			if window[view]
				deferreds.push $.get('tpl/' + view + '.html', (data) ->
					window[view]::template = _.template(data)
					return
				)
			else
				alert view + ' not found'
			return
		$.when.apply(null, deferreds).done callback
		return

	testThing: () ->
		console.log "YO TEST THING"

	uploadFile: (file, callbackSuccess) ->
		self = this
		data = new FormData
		data.append 'file', file
		$.ajax(
			url: 'api/upload.php'
			type: 'POST'
			data: data
			processData: false
			cache: false
			contentType: false).done(->
			console.log file.name + ' uploaded successfully'
			callbackSuccess()
			return
		).fail ->
			self.showAlert 'Error!', 'An error occurred while uploading ' + file.name, 'alert-error'
			return
		return

	displayValidationErrors: (messages) ->
		for key of messages
			if messages.hasOwnProperty(key)
				@addValidationError key, messages[key]
		@showAlert 'Warning!', 'Fix validation errors and try again', 'alert-warning'
		return

	addValidationError: (field, message) ->
		controlGroup = $('#' + field).parent().parent()
		controlGroup.addClass 'error'
		$('.help-inline', controlGroup).html message
		return

	removeValidationError: (field) ->
		controlGroup = $('#' + field).parent().parent()
		controlGroup.removeClass 'error'
		$('.help-inline', controlGroup).html ''
		return

	showAlert: (title, text, klass) ->
		$('.alert').removeClass 'alert-error alert-warning alert-success alert-info'
		$('.alert').addClass klass
		$('.alert').html '<strong>' + title + '</strong> ' + text
		$('.alert').show()
		return

	hideAlert: ->
		$('.alert').hide()
		return
