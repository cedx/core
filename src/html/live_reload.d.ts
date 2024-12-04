/**
 * Opens the event source at the specified URL, and listens for server-sent events.
 * Reloads the browser when a `reload` event is emitted.
 * @param url The URL of the remote resource serving the events.
 * @param options Provides options to configure the new connection.
 * @returns The newly created event source.
 */
export function liveReload(url: string|URL, options?: EventSourceInit): EventSource;
