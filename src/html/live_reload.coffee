# Opens the event source at the specified URL, and listens for server-sent events.
# Reloads the browser when a `reload` event is emitted.
export liveReload = (url, options = {}) ->
	source = new EventSource url, options
	source.addEventListener "error", (event) -> console.error event
	source.addEventListener "open", -> console.log "Listening for server-sent events..."
	source.addEventListener "reload", -> source.close(); location.reload()
	source
