# Represents a country/region.
export class Region

	# Creates a new region.
	constructor: (code) ->

		# The ISO 3166-1 alpha-2 code.
		@code = code.toUpperCase()

	# The emoji flag corresponding to this region.
	Object.defineProperty @::, "emojiFlag",
		get: -> String.fromCodePoint 127_397 + @code.charCodeAt(0), 127_397 + @code.charCodeAt(1)

	# Returns an appropriately localized display name for the specified locale.
	displayName: (locale) -> new Intl.DisplayNames(locale, type: "region").of(@code) or @code

	# Returns a JSON representation of this object.
	toJSON: -> @toString()

	# Returns a string representation of this object.
	toString: -> @code
