import {reverse, split} from "../util/string.js"

# Represents a phone number.
export class PhoneNumber

	# The regular expression used to validate a phone number.
	@pattern = /^[+0]\d{9,}$/

	# Creates a new phone number.
	constructor: (value) ->

		# The normalized phone number.
		@_value = @_normalize value.trim()

	# Value indicating whether this phone number is empty.
	Object.defineProperty @::, "isEmpty",
		get: -> not @_value.length

	# Value indicating whether this phone number is valid.
	Object.defineProperty @::, "isValid",
		get: -> PhoneNumber.pattern.test @_value

	# Formats this phone number according to the locale.
	format: ->
		return "" unless @_value
		prefix = if @_value.startsWith "+33" then "0" else "#{@_value[...3]} "
		prefix + reverse split(reverse(@_value[3..]), 2).join(" ")

	# Returns a JSON representation of this object.
	toJSON: -> @toString()

	# Returns a string representation of this object.
	toString: -> @_value

	# Normalizes the specified phone number.
	_normalize: (value) ->
		switch
			when value.startsWith "00" then value = "+#{value[2..]}"
			when value.startsWith "0" then value = "+33#{value[1..]}"
		value.replace /[\s/.,;:-]/g, ""
