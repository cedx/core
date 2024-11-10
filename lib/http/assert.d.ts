import {RouterContext} from "@koa/router";
import {Status} from "./status.js";

/**
 * Asserts that a request parameter is a numeric identifier, i.e. a positive integer greater than zero.
 * @param ctx The request context.
 * @param options Values customizing the assertion.
 * @returns The parsed identifier.
 */
export function assertIdentifier(ctx: RouterContext, options?: AssertIdentifierOptions): number;

/**
 * Defines the options of the {@link assertIdentifier} function.
 */
export type AssertIdentifierOptions = Partial<{

	/**
	 * The name of the request parameter to check.
	 */
	field: string;

	/**
	 * Value indicating where to search for the request parameter.
	 */
	source: "body"|"params"|"query";

	/**
	 * The status code to use when the assertion fails.
	 */
	status: Status;
}>;
