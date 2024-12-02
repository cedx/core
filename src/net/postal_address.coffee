# Represents a postal address.
export class PostalAddress

	# Creates a new address.
	constructor: (options = {}) ->

		# The first address line.
		@address1 = options.address1 ? ""

		# The second address line.
		@address2 = options.address2 ? ""

		# The city.
		@city = options.city ? ""

		# The country.
		@country = options.country ? ""

		# The postal code.
		@postalCode = options.postalCode ? ""

	# Returns a string representation of this object.
	toString: (locale = navigator.language) ->
		lines = [@address1, @address2, "#{@postalCode} #{@city}", @country.toLocaleUpperCase(locale)]
		return lines.map((item) -> item.trim()).filter((item) -> item.length).join "\n"
