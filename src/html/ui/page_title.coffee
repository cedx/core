import {Component} from "../component.js"

# A component setting the document title.
export class PageTitle extends Component

	# Registers the component.
	customElements.define "page-title", @

	# The reactive properties.
	@properties =
		delimiter: {}
		text: {}
		_applicationName: state: on

	# Creates a new page title.
	constructor: ->
		super shadowRoot: on

		# The string used to separate the page title from the application name.
		@delimiter = "-"

		# The text of the page title.
		@text = ""

		# The application name.
		@_appName = document.head.querySelector('meta[name="application-name"]')?.content or ""

		# Value indicating whether the application is standalone.
		@_isStandalone = ["fullscreen", "minimal-ui", "standalone", "tabbed"].some (mode) -> matchMedia("(display-mode: #{mode})").matches

	# Method invoked when this component is connected.
	connectedCallback: ->
		super.connectedCallback()
		addEventListener "appinstalled", @

	# Method invoked when this component is disconnected.
	disconnectedCallback: ->
		removeEventListener "appinstalled", @
		super.disconnectedCallback()

	# Handles the events.
	handleEvent: -> @_isStandalone = yes

	# Renders this component.
	render: -> html"<slot></slot>"

	# Method invoked after each rendering.
	updated: ->
		text = @text.trim() or @textContent?.trim() or "";
		document.title = if @_isStandalone then text else [text, @_appName].filter((item) -> item.length).join " #{@delimiter} "
