# Provides common HTTP status codes.
export Status = Object.freeze

	# The `OK` status.
	ok: 200

	# The `Created` status.
	created: 201

	# The `No Content` status.
	noContent: 204

	# The `Moved Permanently` status.
	movedPermanently: 301

	# The `Found` status.
	found: 302

	# The `Not Modified` status.
	notModified: 304

	# The `Bad Request` status.
	badRequest: 400

	# The `Unauthorized` status.
	unauthorized: 401

	# The `Payment Required` status.
	paymentRequired: 402

	# The `Forbidden` status.
	forbidden: 403

	# The `Not Found` status.
	notFound: 404

	# The `Method Not Allowed` status.
	methodNotAllowed: 405

	# The `Not Acceptable` status.
	notAcceptable: 406

	# The `Request Timeout` status.
	requestTimeout: 408

	# The `Conflict` status.
	conflict: 409

	# The `Payload Too Large` status.
	payloadTooLarge: 413

	# The `Unsupported Media Type` status.
	unsupportedMediaType: 415

	# The `Page Expired` status.
	pageExpired: 419

	# The `Unprocessable Content` status.
	unprocessableContent: 422

	# The `Too Many Requests` status.
	tooManyRequests: 429

	# The `Internal Server Error` status.
	internalServerError: 500

	# The `Not Implemented` status.
	notImplemented: 501

	# The `Bad Gateway` status.
	badGateway: 502

	# The `Service Unavailable` status.
	serviceUnavailable: 503

	# The `Gateway Timeout` status.
	gatewayTimeout: 504

	# The `Bandwidth Limit Exceeded` status
	bandwidthLimitExceeded: 509
