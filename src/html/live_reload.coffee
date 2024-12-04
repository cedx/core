# Opens the event source at the specified URL, and listens for server-sent events.
# Reloads the browser when a `reload` event is received.
export liveReload = (url, options = {}) ->
	source = new EventSource url, options
	source.addEventListener "open", -> console.info "Listening for server-sent events..."
	source.addEventListener "reload", -> source.close(); location.reload()
	source
