import {Middleware} from "koa";

/**
 * Creates a middleware providing live reload functionality.
 * @param options Value in seconds indicating whether to regularly emit `keepalive` events.
 * @returns The newly created middleware.
 */
export function liveReload(options?: LiveReloadOptions): Middleware;

/**
 * Defines the options of the {@link liveReload} function.
 */
export type LiveReloadOptions = Partial<{

	/**
	 * Value in seconds indicating whether to regularly emit `keepalive` events.
	 */
	keepAlive: false|number;
}>;
