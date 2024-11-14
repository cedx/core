import {Component} from "../component.js"

# Navigates to a new location.
export class RedirectTo extends Component

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
		await @updateComplete
		switch
			when @router? then @router.goto @route, push: @push
			when @push then location.assign @route
			else location.replace @route
