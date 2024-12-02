import {html} from "lit"
import {Component} from "../component.js"
import {Size} from "../size.js"
import {Variant} from "../variant.js"

# A button for switching an element to full screen.
export class FullScreenToggler extends Component

	# The reactive properties.
	@properties =
		icon: type: String
		label: type: String
		size: type: String
		target: type: String
		variant: type: String
		wakeLock: type: Boolean

	# Creates a new loading indicator.
	constructor: ->
		super()

		# The button icon.
		@icon = ""

		# The button label.
		@label = ""

		# The button size.
		@size = Size.medium

		# The CSS selector used to target the element.
		@target = "body"

		# A tone variant.
		@variant = Variant.primary

		# Value indicating whether to prevent the device screen from dimming or locking when in full screen mode.
		@wakeLock = off

		# The associated element.
		@_element = document.body

		# The handle to the underlying platform wake lock.
		@_sentinel = null

	# Method invoked when this component is connected.
	connectedCallback: ->
		super()
		document.addEventListener "visibilitychange", @
		@_element = document.querySelector(@target) or document.body
		@_element.addEventListener "fullscreenchange", @

	# Method invoked when this component is disconnected.
	disconnectedCallback: ->
		document.removeEventListener "visibilitychange", @
		@_element.removeEventListener "fullscreenchange", @
		super()

	# Handles the events.
	handleEvent: (event) -> switch event.type
		when "fullscreenchange"
			if document.fullscreenElement then @_acquireWakeLock() else @_releaseWakeLock()
		when "visibilitychange"
			if document.fullscreenElement and document.visibilityState is "visible" then @_acquireWakeLock()

	# Renders this component.
	render: -> html"""
		<button class="btn btn-#{x => x.size} btn-#{x => x.variant}" @click=#{x => x.toggleFullScreen()}>
			#{when(x => x.icon, html<FullScreenToggler>`<i class="icon #{x => x.label ? "me-1" : ""}">#{x => x.icon}</i>`)}
			#{when(x => x.label, html<FullScreenToggler>`#{x => x.label}`)}
		</button>
	"""

	# Toggles the full screen mode of the associated element.
	toggleFullScreen: ->
		if document.fullscreenElement then await document.exitFullscreen() else await @_element.requestFullscreen()

	# Acquires a new wake lock.
	_acquireWakeLock: ->
		@_sentinel = await navigator.wakeLock.request() if not @_sentinel or @_sentinel.released

	# Releases the acquired wake lock.
	_releaseWakeLock: ->
		await @_sentinel.release() if @_sentinel and not @_sentinel.released
		@_sentinel = null

	# Registers the component.
	customElements.define "fullscreen-toggler", @
