# Defines contextual modifiers.
export Context = Object.freeze

	# A danger.
	danger: "danger"

	# An information.
	info: "info"

	# A success.
	success: "success"

	# A warning.
	warning: "warning"

# Gets the icon corresponding to the specified context.
export contextIcon = (context) -> switch context
	when Context.danger then "error"
	when Context.success then "check_circle"
	when Context.warning then "warning"
	else "info"
