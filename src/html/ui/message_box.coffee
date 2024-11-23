import {html} from "lit"
import {classMap} from "lit/directives/class-map.js"
import {when as _when} from "lit/directives/when.js"
import {Context, contextIcon} from "../../data/context.js"
import {Component} from "../component.js"
import {Variant} from "../variant.js"

# Displays a message window, also known as dialog box, which presents a message to the user.
export class MessageBox extends Component

	# The reactive properties.
	@properties =
		centered: type: Boolean
		_buttons: state: on
		_caption: state: on
		_content: state: on
		_context: state: on
		_icon: state: on

	# Creates a new contact form.
	constructor: ->
		super()

		# Value indicating whether to vertically center this message box.
		@centered = no

		# The buttons displayed in the footer.
		@_buttons = []

		# The title displayed in the header.
		@_caption = ""

		# The message displayed in the body.
		@_content = html""

		# A contextual modifier.
		@_context = null

		# The icon displayed next to the body.
		@_icon = ""

		# The function invoked to return the dialog box result.
		@_resolve = (_) -> return

		# The root element.
		@_root = null

	# Opens an alert dialog with the specified message and an "OK" button.
	alert: (caption, message, options = {}) ->
		context = options.context ? Context.warning
		@show message,
			buttons: options.buttons ? [label: "OK", value: MessageBoxResult.ok]
			caption: caption
			context: context
			icon: options.icon ? contextIcon context

	# Closes the message box.
	close: (result = MessageBoxResult.none) -> @_root.close result

	# Opens a confirmation dialog with the specified message and two buttons, "OK" and "Cancel".
	confirm: (caption, message, options = {}) ->
		context = options.context ? Context.warning
		@show message,
			buttons: options.buttons ? [
				{label: "OK", value: MessageBoxResult.ok}
				{label: "Annuler", value: MessageBoxResult.cancel, variant: Variant.secondary}
			]
			caption: caption # coffeelint: disable-line = object_shorthand
			context: context # coffeelint: disable-line = object_shorthand
			icon: options.icon ? contextIcon context

	# Method invoked after the first rendering.
	firstUpdated: -> @_root = @querySelector "dialog"

	# Renders this component.
	render: -> html"""
		<dialog class="modal modal-dialog modal-dialog-scrollable #{classMap "modal-dialog-centered": @centered}"
			@click=#{@_onDialogClick} @close=#{@_onDialogClose}>
			<form class="modal-content" method="dialog">
				<div class="modal-header user-select-none">
					#{_when @_caption, => html"""
						<h1 class="modal-title fs-5">#{@_caption}</h1>
					"""}
					<button class="btn-close"></button>
				</div>
				<div class="modal-body d-flex">
					#{_when @_icon, => html"""
						<i class="icon icon-fill fs-1 fw-semibold me-2 #{classMap ["text-#{@_context}"]: @_context}">#{@_icon}</i>
					"""}
					<div class="flex-grow-1">#{@_content}</div>
				</div>
				#{_when @_buttons.length, => html"""
					<div class="modal-footer user-select-none">
						#{@_buttons.map (button) -> html"""
							<button class="btn btn-#{button.variant or Variant.primary}" value=#{button.value or MessageBoxResult.none}>
								#{_when button.icon, -> html"""<i class="icon icon-fill #{classMap "me-1": button.label}">#{button.icon}</i>"""}
								#{button.label}
							</button>
						"""}
					</div>
				"""}
			</form>
		</dialog>
	"""

	# Opens a modal dialog with the specified message and options.
	show: (message, options = {}) ->
		@_buttons = options.buttons ? []
		@_caption = options.caption ? ""
		@_content = message
		@_context = options.context ? null
		@_icon = options.icon ? ""

		@_root.returnValue = MessageBoxResult.none
		@_root.showModal()
		@_root.querySelector(".btn-close").blur()

		{promise, resolve} = Promise.withResolvers()
		@_resolve = resolve
		promise

	# Handles the `click` event.
	_onDialogClick: (event) -> @close() if event.target is @_root

	# Handles the `close` event.
	_onDialogClose: -> @_resolve @_root.returnValue

	# Registers the component.
	customElements.define "message-box", @

# Specifies the return value of a message box.
export MessageBoxResult = Object.freeze

	# The message box does not return any value.
	none: ""

	# The return value of the message box is "OK".
	ok: "ok"

	# The return value of the message box is "Cancel".
	cancel: "cancel"
