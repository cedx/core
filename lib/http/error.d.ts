import {Status} from "./status.js";

/**
 * An object thrown when an HTTP error occurs.
 */
export class Error extends globalThis.Error {

	/**
	 * The server response.
	 */
	readonly cause: Response;

	/**
	 * Value indicating whether the response's status code is between 400 and 499.
	 */
	readonly isClientError: boolean;

	/**
	 * Value indicating whether the response's status code is between 500 and 599.
	 */
	readonly isServerError: boolean;

	/**
	 * The response's status code.
	 */
	readonly status: Status;

	/**
	 * The validation errors.
	 */
	readonly validationErrors: Promise<Map<string, string>>;

	/**
	 * Creates a new HTTP error.
	 * @param response The server response.
	 */
	constructor(response: Response);
}
