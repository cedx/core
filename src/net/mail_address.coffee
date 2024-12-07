# Represents a mail address.
export class MailAddress

	# The regular expression used to validate a mail address.
	@pattern = /^[a-z\d!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z\d!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z\d](?:[a-z\d-]*[a-z\d])?\.)+[a-z\d](?:[a-z\d-]*[a-z\d])?$/i

	# Creates a new mail address.
	constructor: (value) ->

		# The normalized address.
		@_value = value.trim().toLowerCase()

	# The host portion of the address.
	Object.defineProperty @::, "host",
		get: -> @_value.split("@").at(-1) or ""

	# Value indicating whether this mail address is empty.
	Object.defineProperty @::, "isEmpty",
		get: -> not @_value.length

	# Value indicating whether this mail address is valid.
	Object.defineProperty @::, "isValid",
		get: -> MailAddress.pattern.test @_value

	# The user information.
	Object.defineProperty @::, "user",
		get: -> @_value.split("@").at(0) or ""

	# Returns a JSON representation of this object.
	toJSON: -> @toString()

	# Returns a string representation of this object.
	toString: -> @_value
