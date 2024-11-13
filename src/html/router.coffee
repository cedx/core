import {Router as LitRouter} from "@lit-labs/router"
import {Tooltip} from "bootstrap"
import {html} from "lit"

# Performs location-based routing using a configuration of URL patterns and associated render callbacks.
export class Router extends LitRouter

	# Creates a new router.
	constructor: (host, routes, options = {}) ->
		super host, routes, fallback: options.fallback or {render: -> html'<error-handler code="404"></error-handler>'}
		basePath = options.basePath or document.head.querySelector("base")?.getAttribute("href") or ""

		# The base path of the application.
		@_basePath = if basePath.endsWith("/") then basePath[...-1] else basePath

		# The scrolling service.
		@_scroller = options.scroller ? null

	# Moves back one route in the session history.
	back: (fallbackRoute = "") -> if history.length > 1 then history.back() else @goto fallbackRoute

	# Navigates to the specified route.
	goto: (route, options = {}) ->
		document.body.querySelector("loading-indicator")?.stop force: yes
		Tooltip.getInstance(element)?.dispose() for element from document.body.querySelectorAll '[data-bs-toggle="tooltip"]'

		await super.goto if route.startsWith("/") or not @_basePath then route else "#{@_basePath}/#{route}"
		history.pushState {}, "", route if options.push

		behavior = "instant"
		@_scroller?.scrollToTop({behavior}) or scrollTo {left: 0, top: 0, behavior}
		dispatchEvent new RouterEvent route

	# Registers a function that will be invoked whenever the `navigate` event is triggered.
	onNavigate: (listener) ->
		addEventListener RouterEvent.type, listener, passive: yes
		this # coffeelint: disable-line = no_this

# An event dispatched when the current route has been changed.
export class RouterEvent extends Event

	# The event type.
	@type = "router:navigate"

	# Creates a new router event.
	constructor: (route) ->
		super Router.type

		# The new route.
		@route = route
