package belin_core.html;

import js.Browser;
import js.html.Element;
import js.html.ScrollBehavior;

/** Manages the scroll position. **/
class ViewportScroller {

	/** The top offset used when scrolling to an element. **/
	var scrollOffset(get, null): Int;
		function get_scrollOffset() {
			if (scrollOffset == null) {
				final fontSize = Std.parseInt(Browser.window.getComputedStyle(Browser.document.body).fontSize);
				scrollOffset = (scrollOffset ?? 0) * 2;

				final navbarHeight = Std.parseInt(Browser.window.getComputedStyle(Browser.document.documentElement).getPropertyValue("--navbar-height"));
				scrollOffset += navbarHeight ?? 0;
			}

			final actionBar = Browser.document.body.querySelector("aside.container-fluid");
			return scrollOffset + (actionBar?.offsetHeight ?? 0);
		}

	/** The element used as viewport. **/
	final viewport: () -> Element;

	/** Creates a new viewport scroller. **/
	public function new(?viewport: () -> Element)
		this.viewport = viewport ?? () -> Browser.document.scrollingElement ?? Browser.document.documentElement;

	/** Scrolls to the specified `anchor`. **/
	public function scrollToAnchor(anchor: String, ?options: {?behavior: ScrollBehavior}): Void {
		final element = Browser.document.getElementById(anchor) ?? Browser.document.body.querySelector('[name="$anchor"]');
		if (element != null) scrollToElement(element, options);
	}

	/** Scrolls to the specified `element`. **/
	public function scrollToElement(element: Element, ?options: {?behavior: ScrollBehavior}): Void {
		final rectangle = element.getBoundingClientRect();
		final viewport = viewport();
		scrollToPosition(rectangle.left + viewport.scrollLeft, rectangle.top + viewport.scrollTop - scrollOffset, options);
	}

	/** Scrolls to the specified position. **/
	public function scrollToPosition(x: Float, y: Float, ?options: {?behavior: ScrollBehavior}): Void
		viewport().scrollTo({left: x, top: y, behavior: options?.behavior ?? AUTO});

	/** Scrolls to the top. **/
	public inline function scrollToTop(?options: {?behavior: ScrollBehavior}): Void
		scrollToPosition(0, 0, options);
}
