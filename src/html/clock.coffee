# A controller managing a clock.
export class Clock

	# Creates a new clock controller.
	constructor: (host, timeout = 1) ->

		# The clock value.
		@value = new Date

		# The host element.
		@_host = host
		@_host.addController @

		# The timer delay, in milliseconds.
		@_timeout = timeout * 1000

		# The timer identifier.
		@_timer = 0

	# Method invoked when the host element is connected.
	hostConnected: ->
		@value = new Date
		@_timer = setInterval (=> @value = new Date; @_host.requestUpdate()), @_timeout

	# Method invoked when the host element is disconnected.
	hostDisconnected: ->
		clearInterval @_timer
		@_timer = 0
