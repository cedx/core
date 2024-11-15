import {html} from "lit"
import {when as _when} from "lit/directives/when.js"
import {Component} from "../component.js"

# A component that shows up when the network is unavailable, and hides when connectivity is restored.
export class OfflineIndicator extends Component

	# The reactive properties.
	@properties = _isOnline: state: on

	# Creates a new offline indicator.
	constructor: ->
		super shadowRoot: on

		# Value indicating whether the browser is online.
		@_isOnline = navigator.onLine

	# Method invoked when this component is connected.
	connectedCallback: ->
		super()
		addEventListener event, @ for event from ["online", "offline"]

	# Method invoked when this component is disconnected.
	disconnectedCallback: ->
		removeEventListener event, @ for event from ["online", "offline"]
		super()

	# Handles the events.
	handleEvent: -> @_isOnline = navigator.onLine

	# Renders this component.
	render: -> _when not @_isOnline, -> html"""
		<slot>
			<div class="alert alert-danger border-end-0 border-start-0 mb-0 rounded-0">
				<i class="icon icon-fill fw-bold me-1">error</i> Le réseau est inaccessible.
				<span class="d-none d-sm-inline">Vérifiez votre connexion.</span>
			</div>
		</slot>
	"""

	# Registers the component.
	customElements.define "offline-indicator", @
