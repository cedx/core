import {Error} from "./error.js"

# Performs HTTP requests.
export class Client

	# Creates a new HTTP client.
	constructor: (baseUrl = document.baseURI) ->
		url = if baseUrl instanceof URL then baseUrl.href else baseUrl

		# The base URL of the remote service.
		@baseUrl = new URL if url.endsWith "/" then url else "#{url}/"

	# Performs a DELETE request.
	delete: (url, options) -> @_fetch "DELETE", url, null, options

	# Performs a GET request.
	get: (url, options) -> @_fetch "GET", url, null, options

	# Performs a PATCH request.
	patch: (url, body, options) -> @_fetch "PATCH", url, body, options

	# Performs a POST request.
	post: (url, body, options) -> @_fetch "POST", url, body, options

	# Performs a PUT request.
	put: (url, body, options) -> @_fetch "PUT", url, body, options

	# Performs a custom HTTP request.
	_fetch: (method, url = "", body = null, options = {}) ->
		headers = new Headers options.headers
		headers.set "accept", "application/json" unless headers.has "accept"

		if body and not (body instanceof Blob or body instanceof FormData or body instanceof URLSearchParams)
			body = JSON.stringify body unless typeof body is "string"
			headers.set "content-type", "application/json" unless headers.has "content-type"

		loader = document.body.querySelector "loading-indicator"
		try
			loader?.start()
			request = new Request new URL(url, @baseUrl), {options..., method, headers, body}
			response = await fetch request
			if response.ok then response else throw new Error response
		finally
			loader?.stop()
