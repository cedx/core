import {Middleware} from "koa";

/**
 * Adds the properties of the specified object to the request state.
 * @param data The state data.
 * @returns The newly created middleware.
 */
export function setState(data: object): Middleware;
