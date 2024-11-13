import {css, LitElement} from "lit"

# The base class for custom elements.
export class Component extends LitElement

	# The component styles.
	@styles = [document.adoptedStyleSheets, css":host { contain: content; }"]

	# Creates a new custom element.
	constructor: (options = {}) ->
		super()

		# Value indicating whether this component uses a shadow root.
		@_useShadowRoot = options.shadowRoot ? no

	# Returns the node into which this component should render.
	createRenderRoot: ->
		if @_useShadowRoot then super.createRenderRoot() else @
