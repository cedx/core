import {Error} from "./error.js"

/**
 * Performs HTTP requests.
 */
export class Client {

	/**
	 * The base URL of the remote service.
	 */
	readonly baseUrl: URL;

	/**
	 * Creates a new HTTP client.
	 * @param baseUrl The base URL of the remote service.
	 */
	constructor(baseUrl: string|URL = document.baseURI) {
		const url = baseUrl instanceof URL ? baseUrl.href : baseUrl;
		this.baseUrl = new URL(url.endsWith("/") ? url : `${url}/`);
	}

	/**
	 * Performs a DELETE request.
	 * @param url The URL of the resource to fetch.
	 * @param options The request options.
	 * @returns The server response.
	 */
	delete(url?: string|URL, options?: RequestInit): Promise<Response> {
		return this.#fetch("DELETE", url, null, options);
	}

	/**
	 * Performs a GET request.
	 * @param url The URL of the resource to fetch.
	 * @param options The request options.
	 * @returns The server response.
	 */
	get(url?: string|URL, options?: RequestInit): Promise<Response> {
		return this.#fetch("GET", url, null, options);
	}

	/**
	 * Performs a PATCH request.
	 * @param url The URL of the resource to fetch.
	 * @param body The request body.
	 * @param options The request options.
	 * @returns The server response.
	 */
	patch(url?: string|URL, body?: unknown, options?: RequestInit): Promise<Response> {
		return this.#fetch("PATCH", url, body, options);
	}

	/**
	 * Performs a POST request.
	 * @param url The URL of the resource to fetch.
	 * @param body The request body.
	 * @param options The request options.
	 * @returns The server response.
	 */
	post(url?: string|URL, body?: unknown, options?: RequestInit): Promise<Response> {
		return this.#fetch("POST", url, body, options);
	}

	/**
	 * Performs a PUT request.
	 * @param url The URL of the resource to fetch.
	 * @param body The request body.
	 * @param options The request options.
	 * @returns The server response.
	 */
	put(url?: string|URL, body?: unknown, options?: RequestInit): Promise<Response> {
		return this.#fetch("PUT", url, body, options);
	}

	/**
	 * Performs a custom HTTP request.
	 * @param method The HTTP method.
	 * @param url The URL of the resource to fetch.
	 * @param body The request body.
	 * @param options The request options.
	 * @returns The server response.
	 */
	async #fetch(method: string, url: string|URL = "", body: unknown = null, options: RequestInit = {}): Promise<Response> {
		const headers = new Headers(options.headers);
		if (!headers.has("accept")) headers.set("accept", "application/json");

		if (body && !(body instanceof Blob || body instanceof FormData || body instanceof URLSearchParams)) {
			if (typeof body != "string") body = JSON.stringify(body);
			if (!headers.has("content-type")) headers.set("content-type", "application/json");
		}

		const loader = document.body.querySelector<HTMLElement & {start: () => void, stop: () => void}>("loading-indicator");
		try {
			loader?.start();
			const request = new Request(new URL(url, this.baseUrl), {...options, method, headers, body} as RequestInit);
			const response = await fetch(request);
			if (!response.ok) throw new Error(response);
			return response;
		}
		finally {
			loader?.stop();
		}
	}
}
