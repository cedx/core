import {BaseRouteConfig, RouteConfig, Router as LitRouter} from "@lit-labs/router";
import {ReactiveControllerHost} from "lit";
import {ViewportScroller} from "./viewport_scroller.js";

/**
 * Performs location-based routing using a configuration of URL patterns and associated render callbacks.
 */
export class Router extends LitRouter {

	/**
	 * Creates a new router.
	 * @param host The host element.
	 * @param routes The routing table.
	 * @param options The router options.
	 */
	constructor(host: HTMLElement & ReactiveControllerHost, routes: RouteConfig[], options?: RouterOptions);

	/**
	 * Moves back one route in the session history.
	 * @param fallbackRoute A fallback route which will be used if the session history is empty.
	 */
	back(fallbackRoute?: string): void;

	/**
	 * Navigates to the specified route.
	 * @param route The route to navigate.
	 * @param options Value indicating whether to add the route to the session history.
	 * @returns Resolves when the router has navigated to the specified route.
	 */
	goto(route: string, options?: {push?: boolean}): Promise<void>;

	/**
	 * Registers a function that will be invoked whenever the `navigate` event is triggered.
	 * @param listener The event handler to register.
	 * @returns This instance.
	 */
	onNavigate(listener: (event: RouterEvent) => void): this;
}

/**
 * An event dispatched when the current route has been changed.
 */
export class RouterEvent extends Event {

	/**
	 * The event type.
	 */
	static readonly type: string;

	/**
	 * The new route.
	 */
	route: string;

	/**
	 * Creates a new router event.
	 * @param route The new route.
	 */
	constructor(route: string);
}

/**
 * Defines the options of a {@link Router} instance.
 */
export type RouterOptions = Partial<{

	/**
	 * The base path of the application.
	 */
	basePath: string;

	/**
	 * A fallback route which will always be matched if none of the {@link Router.routes} match.
	 */
	fallback: BaseRouteConfig;

	/**
	 * The scrolling service.
	 */
	scroller: ViewportScroller;
}>;
