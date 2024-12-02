import {html} from "lit"
import {map} from "lit/directives/map.js"
import {Component} from "../component.js"

# A data list providing autocomplete suggestions.
export class Typeahead extends Component

	# The reactive properties.
	@properties =
		handler: attribute: off
		list: type: String
		minLength: type: Number
		query: type: String
		wait: type: Number
		_items: state: on

	# Creates a new loading indicator.
	constructor: ->
		super()

		# The function invoked when the query has been changed.
		@handler = (_) -> Promise.resolve new Map

		# The data list identifier.
		@list = ""

		# The minimum character length needed before triggering autocomplete suggestions.
		@minLength = 2

		# The query to look up.
		@query = ""

		# The delay in milliseconds to wait before triggering autocomplete suggestions.
		@wait = 300

		# The debounced handler used to look up the query.
		@_debounced = (_) -> return

		# The data list items.
		@_items = new Map

		# The previous query.
		@_previousQuery = ""

	# Method invoked when this component is connected.
	connectedCallback: ->
		super()
		handler = (query) => try @_items = await @handler(query) catch then @_items = new Map
		@_debounced = @_debounce handler, @wait

	# Renders this component.
	render: -> html"""
		<datalist id=#{@list}>
			#{map @_items, ([key, value]) -> html"<option value=#{key}>#{value}</option>"}
		</datalist>
	"""

	# Method invoked after each rendering.
	updated: ->
		query = @query.trim()
		if query isnt @_previousQuery
			@_previousQuery = query
			if query.length < @minLength then @_items = new Map else @_debounced query

	# Postpones the invocation of the specified callback until after a given delay has elapsed since the last time it was invoked.
	_debounce: (callback, delay) ->
		timer = 0
		(value) ->
			clearTimeout timer if timer
			timer = setTimeout callback, delay, value

	# Registers the component.
	customElements.define "type-ahead", @
