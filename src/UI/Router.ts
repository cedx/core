import type {ViewportScroller} from "#Html/ViewportScroller.js";
import {Status} from "#Http/Status.js";
import {Router as LitRouter, type BaseRouteConfig, type RouteConfig} from "@lit-labs/router";
import {Tooltip} from "bootstrap";
import {html, type ReactiveControllerHost} from "lit";

/**
 * An event dispatched when the current route has been changed.
 */
export class RouterEvent extends Event {

	/**
	 * The event type.
	 */
	static readonly type = "router:navigate";

	/**
	 * The new route.
	 */
	readonly route: string;

	/**
	 * Creates a new router event.
	 * @param route The new route.
	 */
	constructor(route: string) {
		super(RouterEvent.type);
		this.route = route;
	}
}

/**
 * Performs location-based routing using a configuration of URL patterns and associated render callbacks.
 */
export class Router extends LitRouter {

	/**
	 * The base path of the application.
	 */
	readonly #basePath: string;

	/**
	 * The scrolling service.
	 */
	readonly #scroller: ViewportScroller|null;

	/**
	 * Creates a new router.
	 * @param host The host element.
	 * @param routes The routing table.
	 * @param options The router options.
	 */
	constructor(host: HTMLElement & ReactiveControllerHost, routes: RouteConfig[], options: RouterOptions = {}) {
		super(host, routes, {fallback: options.fallback ?? {render: () => html`<error-handler status=${Status.notFound}></error-handler>`}});
		const basePath = options.basePath ?? document.head.querySelector("base")?.getAttribute("href") ?? "";
		this.#basePath = basePath.endsWith("/") ? basePath.slice(0, -1) : basePath;
		this.#scroller = options.scroller ?? null;
	}

	/**
	 * Moves back one route in the session history.
	 * @param fallbackRoute A fallback route which will be used if the session history is empty.
	 */
	back(fallbackRoute = ""): void {
		if (history.length > 1) history.back();
		else void this.goto(fallbackRoute);
	}

	/**
	 * Navigates to the specified route.
	 * @param route The route to navigate.
	 * @param options Value indicating whether to add the route to the session history.
	 * @returns Resolves when the router has navigated to the specified route.
	 */
	override async goto(route: string, options: {push?: boolean} = {}): Promise<void> {
		document.body.querySelector("loading-indicator")?.stop({force: true});
		for (const element of document.body.querySelectorAll('[data-bs-toggle="tooltip"]')) Tooltip.getInstance(element)?.dispose();

		await super.goto(route.startsWith("/") || !this.#basePath ? route : `${this.#basePath}/${route}`);
		if (options.push) history.pushState({}, "", route);

		const behavior = "instant";
		if (this.#scroller) this.#scroller.scrollToTop({behavior});
		else scrollTo({left: 0, top: 0, behavior});

		dispatchEvent(new RouterEvent(route));
	}

	/**
	 * Registers a function that will be invoked whenever the `navigate` event is triggered.
	 * @param listener The event handler to register.
	 * @returns This instance.
	 */
	onNavigate(listener: (event: RouterEvent) => void): this {
		addEventListener(RouterEvent.type, listener as EventListener);
		return this;
	}
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
