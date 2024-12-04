import Router from "@koa/router"
import EventEmitter from "node:events"
import {Transform} from "node:stream"
import {setInterval} from "node:timers"
import {Duration} from "../util/duration.js"

# A stream of server-sent events.
class SseStream extends Transform

	# Creates a new stream.
	constructor: (ctx) ->
		super objectMode: on
		ctx.set
			"cache-control": "no-cache"
			"connection": "keep-alive"
			"content-Type": "text/event-stream"
			"x-accel-buffering": "no"

		ctx.socket.setKeepAlive on
		ctx.socket.setNoDelay on
		ctx.socket.setTimeout 0

	# Transforms input and produces output.
	_transform: (message, _, done) ->
		if typeof message is "string" then @push ":#{message}\n\n"
		else
			event = message.event or "message"
			id = message.id or Date.now()
			data = message.data ? {}
			@push "id: #{id}\nevent: #{event}\ndata: #{JSON.stringify data}\n\n"
		done()

# Creates a middleware providing live reload functionality.
export liveReload = (options = {}) ->
	emitter = new EventEmitter().setMaxListeners 0
	keepAlive = options.keepAlive ? 30
	setInterval (-> emitter.emit "message", "keepalive"), keepAlive * Duration.second if keepAlive > 0

	# Listens for server-sent events.
	listen = (ctx) ->
		stream = new SseStream ctx
		listener = (message) -> if message.event is "reload" then stream.end message else stream.write message
		emitter.on "message", listener
		stream.on "close", (-> emitter.off "message", listener)

		ctx.body = stream
		stream.write "open"

	# Reloads the browser.
	reload = (ctx) ->
		ctx.body = null
		emitter.emit "message", event: "reload"

	# The routing table.
	new Router()
		.get "/", listen
		.post "/", reload
		.routes()
