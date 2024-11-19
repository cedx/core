import {html} from "lit"
import {classMap} from "lit/directives/class-map.js"
import {when as _when} from "lit/directives/when.js"
import {Component} from "../component.js"
import {Theme, themeIcon, themeLabel} from "../theme.js"

# A dropdown menu for switching the color mode.
export class ThemeDropdown extends Component

	# The reactive properties.
	@properties =
		align: type: String
		label: type: String
		storageKey: type: String
		_theme: state: on

	# Creates a new theme dropdown.
	constructor: ->
		super()

		# The alignement of the dropdown menu.
		@align = "end"

		# The label of the dropdown menu.
		@label = ""

		# The key of the storage entry providing the saved theme.
		@storageKey = "theme"

		# The media query used to check the system theme.
		@_mediaQuery = matchMedia "(prefers-color-scheme: dark)"

		# The current theme.
		@_theme = if Object.values(Theme).includes theme = localStorage.getItem @storageKey then theme else Theme.auto

	# The current theme.
	Object.defineProperty @prototype, "theme",
		get: -> @_theme
		set: (value) -> if value isnt @_theme
			localStorage.setItem @storageKey, @_theme = value
			@_applyTheme()

	# Method invoked when this component is connected.
	connectedCallback: ->
		super()
		@_applyTheme()
		@_mediaQuery.addEventListener "change", @

	# Method invoked when this component is disconnected.
	disconnectedCallback: ->
		@_mediaQuery.removeEventListener "change", @
		super()

	# Handles the events.
	handleEvent: -> @_applyTheme()

	# Renders this component.
	render: -> html"""
		<li class="nav-item dropdown">
			<a class="dropdown-toggle nav-link" data-bs-toggle="dropdown" href="#">
				<i class="icon icon-fill">#{themeIcon @_theme}</i>
				#{_when @label, => html"""<span class="ms-1">#{@label}</span>"""}
			</a>
			<ul class="dropdown-menu #{classMap "dropdown-menu-end": @align is "end"}">
				#{Object.values(Theme).map (value) => html"""
					<li>
						<button class="dropdown-item d-flex align-items-center justify-content-between" @click=#{=> @theme = value}>
							<span><i class="icon icon-fill me-1">#{themeIcon value}</i> #{themeLabel value}</span>
							#{_when value is @_theme, -> html"""<i class="icon ms-2">check</i>"""}
						</button>
					</li>
				"""}
			</ul>
		</li>
	"""

	# Applies the theme to the document.
	_applyTheme: -> document.documentElement.dataset.bsTheme =
		if @_theme is Theme.auto then (if @_mediaQuery.matches then Theme.dark else Theme.light)
		else @_theme

	# Registers the component.
	customElements.define "theme-dropdown", @
