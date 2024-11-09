/**
 * Defines the scrolling options.
 */
export type ScrollOptions = Partial<{

	/**
	 * Value indicating whether scrolling is instant or animates smoothly.
	 */
	behavior: ScrollBehavior
}>;

/**
 * Manages the scroll position.
 */
export class ViewportScroller {

	/**
	 * The top offset used when scrolling to an element.
	 */
	readonly scrollOffset: number;

	/**
	 * Creates a new viewport scroller.
	 * @param viewport A function that returns the element used as viewport.
	 */
	constructor(viewport?: () => Element);

	/**
	 * Scrolls to the specified anchor.
	 * @param anchor The identifier or name of an elment.
	 * @param options Value indicating whether scrolling is instant or animates smoothly.
	 */
	scrollToAnchor(anchor: string, options?: ScrollOptions): void;

	/**
	 * Scrolls to the specified element.
	 * @param element The element to scroll to.
	 * @param options Value indicating whether scrolling is instant or animates smoothly.
	 */
	scrollToElement(element: Element, options?: ScrollOptions): void;

	/**
	 * Scrolls to the specified position.
	 * @param x The pixel along the horizontal axis.
	 * @param y The pixel along the vertical axis.
	 * @param options Value indicating whether scrolling is instant or animates smoothly.
	 */
	scrollToPosition(x: number, y: number, options?: ScrollOptions): void;

	/**
	 * Scrolls to the top.
	 * @param options Value indicating whether scrolling is instant or animates smoothly.
	 */
	scrollToTop(options?: ScrollOptions): void;
}
