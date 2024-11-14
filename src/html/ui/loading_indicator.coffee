import {html} from "lit"
import {when as _when} from "lit/directives/when.js"
import {Component} from "../component.js"

# A component that shows up when an HTTP request starts, and hides when all concurrent HTTP requests are completed.
export class LoadingIndicator extends Component

	# Registers the component.
	customElements.define "loading-indicator", @

	# Creates a new loading indicator.
	constructor: ->
		super shadowRoot: on
		@hidden = yes

		# The number of concurrent HTTP requests.
		@_requestCount = 0

	# Starts the loading indicator.
	start: ->
		@_requestCount++
		@hidden = no
		document.body.classList.add "loading"

	# Stops the loading indicator.
	stop: (options = {}) ->
		@_requestCount--
		if options.force or @_requestCount <= 0
			@_requestCount = 0
			@hidden = yes
			document.body.classList.remove "loading"

	# Renders this component.
	render: -> html"""
		<slot>
			<div class="spinner-border text-light"></div>
		</slot>
	"""
