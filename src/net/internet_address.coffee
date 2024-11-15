# Represents an IP address.
export class InternetAddress

	# The regular expression used to validate an IPv4 address.
	@ipv4Pattern = /^(?:(?:2(?:[0-4]\d|5[0-5])|[0-1]?\d?\d)\.){3}(?:2([0-4]\d|5[0-5])|[0-1]?\d?\d)$/

	# The regular expression used to validate an IPv4 address.
	@ipv6Pattern = /^(([a-f\d]{1,4}:){7}[a-f\d]{1,4}|([a-f\d]{1,4}:){1,7}:|([a-f\d]{1,4}:){1,6}:[a-f\d]{1,4}|([a-f\d]{1,4}:){1,5}(:[a-f\d]{1,4}){1,2}|([a-f\d]{1,4}:){1,4}(:[a-f\d]{1,4}){1,3}|([a-f\d]{1,4}:){1,3}(:[a-f\d]{1,4}){1,4}|([a-f\d]{1,4}:){1,2}(:[a-f\d]{1,4}){1,5}|[a-f\d]{1,4}:((:[a-f\d]{1,4}){1,6})|:((:[a-f\d]{1,4}){1,7}|:)|fe80:(:[a-f\d]{0,4}){0,4}%[a-z\d]+|::(ffff(:0{1,4})?:)?((25[0-5]|(2[0-4]|1?\d)?\d)\.){3}(25[0-5]|(2[0-4]|1?\d)?\d)|([a-f\d]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1?\d)?\d)\.){3}(25[0-5]|(2[0-4]|1?\d)?\d))$/ # coffeelint: disable-line = max_line_length

	# Creates a new IP address.
	constructor: (value) ->

		# The normalized address.
		@_value = @_sanitize value.trim().toLowerCase()

	# The IPv6 numeric address.
	Object.defineProperty @prototype, "address",
		get: -> if @type is InternetAddressType.IPv4 then "::ffff:#{@_value}" else @_value

	# Value indicating whether this IP address is empty.
	Object.defineProperty @prototype, "isEmpty",
		get: -> not @_value.length

	# Value indicating whether this IP address is valid.
	Object.defineProperty @prototype, "isValid",
		get: -> if @type is InternetAddressType.IPv4 then InternetAddress.ipv4Pattern.test @_value else InternetAddress.ipv6Pattern.test @_value

	# The address family.
	Object.defineProperty @prototype, "type",
		get: -> if @_value.includes ":" then InternetAddressType.IPv6 else InternetAddressType.IPv4

	# Returns a JSON representation of this object.
	toJSON: -> @toString()

	# Returns a string representation of this object.
	toString: -> @_value

	# Sanitizes the specified IP address.
	_sanitize: (value) ->
		parts = value.split ":"
		return parts[0] if parts.length is 2
		matches = /^\[(.+)](:\d+)?$/.exec value
		if matches then matches[1] else value

# Defines the address family of an IP address.
export InternetAddressType = Object.freeze

	# An IPv4 address.
	IPv4: 4

	# An IPv6 address.
	IPv6: 6
