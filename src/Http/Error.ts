import {Status} from "./status.js";

/**
 * An object thrown when an HTTP error occurs.
 */
export class Error extends globalThis.Error {

	/**
	 * The validation errors.
	 */
	#validationErrors: Map<string, string>|null = null;

	/**
	 * Creates a new HTTP error.
	 * @param response The server response.
	 */
	constructor(response: Response) {
		super(`${response.status} ${response.statusText}`, {cause: response});
		this.name = "HttpError";
	}

	/**
	 * The server response.
	 */
	override get cause(): Response {
		return super.cause as Response;
	}

	/**
	 * Value indicating whether the response's status code is between 400 and 499.
	 */
	get isClientError(): boolean {
		const {status} = this;
		return status >= 400 && status < 500;
	}

	/**
	 * Value indicating whether the response's status code is between 500 and 599.
	 */
	get isServerError(): boolean {
		const {status} = this;
		return status >= 500 && status < 600;
	}

	/**
	 * The response's status code.
	 */
	get status(): Status {
		return this.cause.status as Status;
	}

	/**
	 * The validation errors.
	 */
	get validationErrors(): Promise<Map<string, string>> {
		return this.#validationErrors
			? Promise.resolve(this.#validationErrors)
			: this.#parseValidationErrors().then(errors => this.#validationErrors = errors);
	}

	/**
	 * Parses the validation errors returned in the body of the specified response.
	 * @returns The validation errors provided by the response body.
	 */
	async #parseValidationErrors(): Promise<Map<string, string>> {
		try {
			const statuses = new Set<Status>([Status.badRequest, Status.unprocessableContent]);
			const ignoreBody = this.cause.bodyUsed || !statuses.has(this.status);
			return new Map(ignoreBody ? [] : Object.entries(await this.cause.json() as Record<string, string>));
		}
		catch {
			return new Map;
		}
	}
}
