import {Status} from "./status.js"

# An object thrown when an HTTP error occurs.
export class Error extends globalThis.Error

	# Creates a new HTTP error.
	constructor: (response) ->
		super "#{response.status} #{response.statusText}", cause: response

		# The error name.
		@name = "HttpError"

		# The validation errors.
		@_validationErrors = null

	# Value indicating whether the response's status code is between 400 and 499.
	Object.defineProperty @::, "isClientError",
		get: -> 400 <= @status < 500

	# Value indicating whether the response's status code is between 500 and 599.
	Object.defineProperty @::, "isServerError",
		get: -> 500 <= @status < 600

	# The response's status code.
	Object.defineProperty @::, "status",
		get: -> @cause.status

	# The validation errors.
	Object.defineProperty @::, "validationErrors",
		get: -> if @_validationErrors? then Promise.resolve @_validationErrors else @_validationErrors = await @_parseValidationErrors()

	# Parses the validation errors returned in the body of the specified response.
	_parseValidationErrors: ->
		try
			ignoreBody = @cause.bodyUsed or @status not in [Status.badRequest, Status.unprocessableContent]
			new Map if ignoreBody then [] else Object.entries await @cause.json()
		catch
			new Map
