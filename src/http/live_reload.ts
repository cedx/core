import {Duration} from "#util/duration";
import Router, {type Middleware} from "@koa/router";
import type {Context} from "koa";
import EventEmitter from "node:events";
import {Transform, type TransformCallback} from "node:stream";
import {setInterval} from "node:timers";

/**
 * Represents a server-sent event.
 */
type SseEvent = Partial<{

	/**
	 * The event data.
	 */
	data: object;

	/**
	 * The event type.
	 */
	event: string;

	/**
	 * The event identifier.
	 */
	id: string;
}>;

/**
 * A stream of server-sent events.
 */
class SseStream extends Transform {

	/**
	 * Creates a new stream.
	 * @param ctx The request context.
	 */
	constructor(ctx: Context) {
		super({objectMode: true});
		ctx.set({
			"cache-control": "no-cache",
			"connection": "keep-alive",
			"content-Type": "text/event-stream",
			"x-accel-buffering": "no"
		});

		ctx.socket.setKeepAlive(true);
		ctx.socket.setNoDelay(true);
		ctx.socket.setTimeout(0);
	}

	/**
	 * Transforms input and produces output.
	 * @param message The chunk to transform.
	 * @param encoding The encoding type if the chunk is a string.
	 * @param done The function to invoke when the supplied chunk has been processed.
	 */
	override _transform(message: string|SseEvent, encoding: BufferEncoding, done: TransformCallback): void {
		if (typeof message == "string") this.push(`:${message}\n\n`);
		else {
			const event = message.event ?? "message";
			const id = message.id ?? Date.now();
			const data = message.data ?? {};
			this.push(`id: ${id}\nevent: ${event}\ndata: ${JSON.stringify(data)}\n\n`);
		}

		done();
	}
}

/**
 * Creates a middleware providing live reload functionality.
 * @param options Value in seconds indicating whether to regularly emit `keepalive` events.
 * @returns The newly created middleware.
 */
export function liveReload(options: LiveReloadOptions = {}): Middleware {
	const emitter = new EventEmitter().setMaxListeners(0);
	const keepAlive = options.keepAlive ?? 30;
	if (keepAlive && keepAlive > 0) setInterval(() => emitter.emit("message", "keepalive"), keepAlive * Duration.second);

	/**
	 * Listens for server-sent events.
	 * @param ctx The request context.
	 */
	function listen(ctx: Context): void {
		const stream = new SseStream(ctx);
		const listener = (message: string|SseEvent): void => {
			if (typeof message == "object" && message.event == "reload") stream.end(message);
			else stream.write(message);
		};

		emitter.on("message", listener);
		stream.on("close", () => emitter.off("message", listener));

		ctx.body = stream;
		stream.write("open");
	}

	/**
	 * Reloads the browser.
	 * @param ctx The request context.
	 */
	function reload(ctx: Context): void {
		ctx.body = null;
		emitter.emit("message", {event: "reload"});
	}

	// The routing table.
	return new Router()
		.get("/", listen)
		.post("/", reload)
		.middleware();
}

/**
 * Defines the options of the {@link liveReload} function.
 */
export type LiveReloadOptions = Partial<{

	/**
	 * Value in seconds indicating whether to regularly emit `keepalive` events.
	 */
	keepAlive: false|number;
}>;
