# Represents a mail address.
export class MailAddress

	# The regular expression used to validate a mail address.
	@pattern = /^[a-z\d!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z\d!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z\d](?:[a-z\d-]*[a-z\d])?\.)+[a-z\d](?:[a-z\d-]*[a-z\d])?$/i

	# The host portion of the address.
	Object.defineProperty @prototype, "host",
		get: -> @_value.split("@").at -1 ? ""

	# Value indicating whether this mail address is empty.
	Object.defineProperty @prototype, "isEmpty",
		get: -> not @_value.length

	# Value indicating whether this mail address is valid.
	Object.defineProperty @prototype, "isValid",
		get: -> MailAddress.pattern.test @_value

	# The user information.
	Object.defineProperty @prototype, "user",
		get: -> @_value.split("@").at 0 ? ""

	# Creates a new mail address.
	constructor: (value) ->

		# The normalized address.
		@_value = value.trim().toLowerCase()

	# Returns a JSON representation of this object.
	toJSON: -> @toString()

	# Returns a string representation of this object.
	toString: -> @_value
