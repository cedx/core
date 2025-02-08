/**
 * Opens the event source at the specified URL, and listens for server-sent events.
 * Reloads the browser when a `reload` event is received.
 * @param url The URL of the remote resource serving the events.
 * @param options Value indicating whether CORS should be set to `include` credentials.
 * @returns The newly created event source.
 */
export function liveReload(url: string|URL, options: EventSourceInit = {}): EventSource {
	const eventSource = new EventSource(url, options);
	eventSource.addEventListener("error", () => console.error("Failed to connect to the event source."));
	eventSource.addEventListener("open", () => console.info("Listening for server-sent events..."));
	eventSource.addEventListener("reload", () => { eventSource.close(); location.reload(); });
	return eventSource;
}
