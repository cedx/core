/**
 * Provides common HTTP status codes.
 */
export const Status = Object.freeze({

	/**
	 * The `OK` status.
	 */
	OK: 200,

	/**
	 * The `Created` status.
	 */
	Created: 201,

	/**
	 * The `No Content` status.
	 */
	NoContent: 204,

	/**
	 * The `Moved Permanently` status.
	 */
	MovedPermanently: 301,

	/**
	 * The `Found` status.
	 */
	Found: 302,

	/**
	 * The `Not Modified` status.
	 */
	NotModified: 304,

	/**
	 * The `Bad Request` status.
	 */
	BadRequest: 400,

	/**
	 * The `Unauthorized` status.
	 */
	Unauthorized: 401,

	/**
	 * The `Payment Required` status.
	 */
	PaymentRequired: 402,

	/**
	 * The `Forbidden` status.
	 */
	Forbidden: 403,

	/**
	 * The `Not Found` status.
	 */
	NotFound: 404,

	/**
	 * The `Method Not Allowed` status.
	 */
	MethodNotAllowed: 405,

	/**
	 * The `Not Acceptable` status.
	 */
	NotAcceptable: 406,

	/**
	 * The `Request Timeout` status.
	 */
	RequestTimeout: 408,

	/**
	 * The `Conflict` status.
	 */
	Conflict: 409,

	/**
	 * The `Payload Too Large` status.
	 */
	PayloadTooLarge: 413,

	/**
	 * The `Unsupported Media Type` status.
	 */
	UnsupportedMediaType: 415,

	/**
	 * The `Page Expired` status.
	 */
	PageExpired: 419,

	/**
	 * The `Unprocessable Content` status.
	 */
	UnprocessableContent: 422,

	/**
	 * The `Too Many Requests` status.
	 */
	TooManyRequests: 429,

	/**
	 * The `Internal Server Error` status.
	 */
	InternalServerError: 500,

	/**
	 * The `Not Implemented` status.
	 */
	NotImplemented: 501,

	/**
	 * The `Bad Gateway` status.
	 */
	BadGateway: 502,

	/**
	 * The `Service Unavailable` status.
	 */
	ServiceUnavailable: 503,

	/**
	 * The `Gateway Timeout` status.
	 */
	GatewayTimeout: 504,

	/**
	 * The `Bandwidth Limit Exceeded` status
	 */
	BandwidthLimitExceeded: 509
});

/**
 * Provides common HTTP status codes.
 */
export type Status = typeof Status[keyof typeof Status];
