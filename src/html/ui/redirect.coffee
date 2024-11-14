import {Component} from "../component.js"

# Navigates to a new location.
export class Redirect extends Component

	# Registers the component.
	customElements.define "redirect-to", @

	# The reactive properties.
	@properties =
		push: type: Boolean
		route: {}
		router: attribute: off

	# Creates a new loading indicator.
	constructor: ->
		super()

		# Value indicating whether to push a new entry onto the history instead of replacing the current one.
		@push = no

		# The route to redirect to.
		@route = ""

		# The routing service.
		@router = null

	# Method invoked when this component is connected.
	connectedCallback: ->
		super.connectedCallback()

		if @router
			await @updateComplete;
			return @router.goto @route, push: @push

		if @push then location.assign @route
		else location.replace @route
