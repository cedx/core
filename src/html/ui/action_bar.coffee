import {html} from "lit"
import {Component} from "../component.js"

# An action bar located under the navigation bar.
export class ActionBar extends Component

	# Registers the component.
	customElements.define "action-bar", @

	# Creates a new action bar.
	constructor: -> super shadowRoot: on

	# Method invoked when this component is disconnected.
	disconnectedCallback: ->
		document.documentElement.style.removeProperty "--main-offset"
		super.disconnectedCallback()

	# Method invoked after the first rendering.
	firstUpdated: ->
		await @updateComplete
		navbarHeight = parseInt getComputedStyle(document.documentElement).getPropertyValue "--navbar-height"
		mainOffset = @offsetHeight + if Number.isNaN(navbarHeight) then 0 else navbarHeight
		document.documentElement.style.setProperty "--main-offset", "#{mainOffset}px"

	# Renders this component.
	render: -> html"""
		<aside class="container-fluid">
			<slot class="d-flex justify-content-between align-items-center"></slot>
		</aside>
	"""
