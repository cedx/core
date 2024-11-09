# Defines the available color modes.
export Theme = Object.freeze

	# The theme is light.
	light: "light"

	# The theme is dark.
	dark: "dark"

	# The color mode is automatic.
	auto: "auto"

# Gets the icon corresponding to the specified theme.
export themeIcon = (theme) ->
	switch theme
		when Theme.dark then "dark_mode"
		when Theme.light then "light_mode"
		else "tonality"

# Gets the label corresponding to the specified theme.
export themeLabel = (theme) ->
	switch theme
		when Theme.dark then "Sombre"
		when Theme.light then "Clair"
		else "Auto"
