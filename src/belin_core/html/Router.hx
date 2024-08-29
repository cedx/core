package belin_core.html;

import coconut.data.Model;
import js.Browser;
import js.Syntax;
import js.html.Element;
import tink.Url;
import tink.url.Portion;
import tink.domspec.Attributes.Target;
import tink.state.Observable;
import tink.state.State;
using StringTools;

/** A service that provides navigation among views. **/
class Router<Route: EnumValue> implements Model {

	/** The current query. **/
	final query: Observable<Map<String, Portion>> = url.map(url -> [for (param in url.query) param.name => param.value]);

	/** The current URL. **/
	final url: Observable<Url> = {
		final state = new State<String>(Browser.location.href);
		function update(href: String) if (href != state.value) {
			referrer = state.value;
			state.set(href);
		}

		final pushState = Browser.window.history.pushState;
		Syntax.code("{0}.pushState = {1}", Browser.window.history, (data, title, ?url) -> {
			onNavigate.invoke(Noise);
			pushState(data, title, url);
			update(Browser.location.href);
		});

		final replaceState = Browser.window.history.replaceState;
		Syntax.code("{0}.replaceState = {1}", Browser.window.history, (data, title, ?url) -> {
			onNavigate.invoke(Noise);
			replaceState(data, title, url);
			update(Browser.location.href);
		});

		Browser.window.addEventListener("hashchange", event -> update(event.newURL));
		Browser.window.addEventListener("popstate", _ -> update(Browser.location.href));
		state.observe().map(href -> Url.parse(href));
	}

	/** The handler invoked when a navigation occurs. **/
	@:constant var onNavigate: Callback<Noise> = @byDefault function() {};

	/** The previous URL. **/
	@:editable var referrer: Url = @byDefault Browser.document.referrer;

	/** The current route. **/
	@:computed var route: Route = urlToRoute(url.value);

	/** The function that maps a route to a URL. **/
	@:constant var routeToUrl: Route -> Url;

	/** The function that maps a URL to a route. **/
	@:constant var urlToRoute: Url -> Route;

	/** Moves back one route in the session history. **/
	public function back(?fallbackRoute: Route): Void
		fallbackRoute == null || Browser.window.history.length > 1 ? Browser.window.history.back() : push(fallbackRoute);

	/** Intercepts the clicks on anchor links. **/
	public function intercept(element: Element): Void
		element.addEventListener("click", event -> if (!event.ctrlKey && !event.shiftKey) switch (cast event.target: Element).closest("a") {
			case null:
			case anchor if (anchor.hasAttribute("download") || (anchor.hasAttribute("target") && anchor.getAttribute("target") != Target.Self)):
			case anchor: switch anchor.getAttribute("href") {
				case null | "" | "#":
				case href if (href.startsWith("//") || ~/^[a-z]+:/i.match(href)):
				case href: event.preventDefault(); Browser.window.history.pushState(null, "", href);
			}
		});

	/** Adds a route to the session history. **/
	public function push(value: Route): Void
		Browser.window.history.pushState(null, "", routeToUrl(value));

	/** Replaces the current history entry by the specified route. **/
	public function replace(value: Route): Void
		Browser.window.history.replaceState(null, "", routeToUrl(value));
}
