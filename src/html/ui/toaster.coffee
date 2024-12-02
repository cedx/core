import {Toast as BootstrapToast} from "bootstrap"
import {html} from "lit"
import {classMap} from "lit/directives/class-map.js"
import {repeat} from "lit/directives/repeat.js"
import {when as _when} from "lit/directives/when.js"
import {Component} from "../component.js"
import {Context, contextIcon} from "../data/context.js"
import {Duration} from "../util/duration.js"

# Displays a notification message.
export class Toast extends Component

	# The reactive properties.
	@properties =
		notification: attribute: off
		toaster: attribute: off
		_elapsedTime: state: on

	# The time units.
	@_timeUnits = ["second", "minute", "hour"]

	# Creates a new toast.
	constructor: ->
		super()

		# The notification to show.
		@notification = {}

		# The toaster managing this notification.
		@toaster = null

		# The elapsed time.
		@_elapsedTime = "maintenant"

		# The formatter used to format the relative time.
		@_formatter = null

		# The timer identifier.
		@_timer = 0

		# The underlying Bootstrap toast.
		@_toast = null

	# Method invoked when this component is connected.
	connectedCallback: ->
		super()
		timestamp = Date.now()
		@_formatter = new Intl.RelativeTimeFormat @toaster.locale, style: "long"
		@_timer = setInterval (=> @_elapsedTime = @_formatTime (Date.now() - timestamp) / Duration.second), Duration.second

	# Method invoked when this component is disconnected.
	disconnectedCallback: ->
		clearInterval @_timer
		@_toast.dispose()
		super()

	# Method invoked after the first rendering.
	firstUpdated: ->
		@_toast = new BootstrapToast @renderRoot.firstElementChild, @notification
		@_toast.show()

	# Renders this component.
	render: -> html"""
		<div class="toast" @hidden.bs.toast=#{=> @toaster.close @notification}>
			<div class="toast-header #{classMap ["toast-header-#{@notification.context}"]: @notification.context}">
				#{_when @notification.icon, => html"""
					<i class="icon icon-fill me-2 #{classMap ["text-#{@notification.context}"]: @notification.context}">#{@notification.icon}</i>
				"""}
				<b class="me-auto">#{@notification.caption}</b>
				<small class="text-secondary">#{@_elapsedTime}</small>
				<button class="btn-close" data-bs-dismiss="toast"></button>
			</div>
			<div class="toast-body">#{@notification.content}</div>
		</div>
	"""

	# Formats the specified elapsed time.
	_formatTime: (elapsed) ->
		index = 0
		while elapsed > 60 and index < Toast._timeUnits.length
			elapsed /= 60
			index++
		@_formatter.format Math.round(-elapsed), Toast._timeUnits[index]

	# Registers the component.
	customElements.define "toaster-item", @

# Manages the notification messages.
export class Toaster extends Component

	# The reactive properties.
	@properties =
		locale: type: String
		_notifications: state: on

	# Creates a new toaster.
	constructor: ->
		super()

		# The locale used to format the relative times.
		@locale = navigator.language

		# The notification list.
		@_notifications = []

	# Closes the toast associated with the specified notification.
	close: (notification) -> @_notifications = @_notifications.filter (item) -> item isnt notification

	# Shows a notification with the specified message.
	notify: (caption, message, options = {}) ->
		context = options.context ? Context.info
		@show {animation: no, context, icon: contextIcon(context), options..., caption, content: message}

	# Renders this component.
	render: -> html"""
		<div class="toast-container bottom-0 end-0 p-3">
			#{repeat @_notifications, ((item) -> item), (item, index) => html"""
				<toaster-item class="d-block #{classMap "mt-3": index}" .notification=#{item} .toaster=#{@}></toaster-item>
			"""}
		</div>
	"""

	# Shows a toast with the specified notification.
	show: (notification) -> @_notifications = @_notifications.concat notification

	# Registers the component.
	customElements.define "toaster-container", @
