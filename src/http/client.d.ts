/**
 * Performs HTTP requests.
 */
export class Client {

	/**
	 * The base URL of the remote service.
	 */
	baseUrl: URL;

	/**
	 * Creates a new HTTP client.
	 * @param baseUrl The base URL of the remote service.
	 */
	constructor(baseUrl?: string|URL);

	/**
	 * Performs a DELETE request.
	 * @param url The URL of the resource to fetch.
	 * @param options The request options.
	 * @returns The server response.
	 */
	delete(url?: string|URL, options?: RequestInit): Promise<Response>;

	/**
	 * Performs a GET request.
	 * @param url The URL of the resource to fetch.
	 * @param options The request options.
	 * @returns The server response.
	 */
	get(url?: string|URL, options?: RequestInit): Promise<Response>;

	/**
	 * Performs a PATCH request.
	 * @param url The URL of the resource to fetch.
	 * @param body The request body.
	 * @param options The request options.
	 * @returns The server response.
	 */
	patch(url?: string|URL, body?: unknown, options?: RequestInit): Promise<Response>;

	/**
	 * Performs a POST request.
	 * @param url The URL of the resource to fetch.
	 * @param body The request body.
	 * @param options The request options.
	 * @returns The server response.
	 */
	post(url?: string|URL, body?: unknown, options?: RequestInit): Promise<Response>;

	/**
	 * Performs a PUT request.
	 * @param url The URL of the resource to fetch.
	 * @param body The request body.
	 * @param options The request options.
	 * @returns The server response.
	 */
	put(url?: string|URL, body?: unknown, options?: RequestInit): Promise<Response>;
}
