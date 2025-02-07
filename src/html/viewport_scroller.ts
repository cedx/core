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
	#scrollOffset = -1;

	/**
	 * The function returning the element used as viewport.
	 */
	readonly #viewport: () => Element;

	/**
	 * Creates a new viewport scroller.
	 * @param viewport A function that returns the element used as viewport.
	 */
	constructor(viewport: () => Element = () => document.scrollingElement ?? document.documentElement) {
		this.#viewport = viewport;
	}

	/**
	 * The top offset used when scrolling to an element.
	 */
	get scrollOffset(): number {
		if (this.#scrollOffset < 0) {
			const fontSize = parseInt(getComputedStyle(document.body).fontSize);
			this.#scrollOffset = Number.isNaN(fontSize) ? 0 : fontSize * 2;

			const navbarHeight = parseInt(getComputedStyle(document.documentElement).getPropertyValue("--navbar-height"));
			this.#scrollOffset += Number.isNaN(navbarHeight) ? 0 : navbarHeight;
		}

		const actionBar = document.body.querySelector<HTMLElement>("action-bar");
		return this.#scrollOffset + (actionBar?.offsetHeight ?? 0);
	}

	/**
	 * Scrolls to the specified anchor.
	 * @param anchor The identifier or name of an elment.
	 * @param options Value indicating whether scrolling is instant or animates smoothly.
	 */
	scrollToAnchor(anchor: string, options: ScrollOptions = {}): void {
		const element = document.getElementById(anchor) ?? document.body.querySelector(`[name="${anchor}"]`);
		if (element) this.scrollToElement(element, options);
	}

	/**
	 * Scrolls to the specified element.
	 * @param element The element to scroll to.
	 * @param options Value indicating whether scrolling is instant or animates smoothly.
	 */
	scrollToElement(element: Element, options: ScrollOptions = {}): void {
		const {left, top} = element.getBoundingClientRect();
		const {scrollLeft, scrollTop} = this.#viewport();
		this.scrollToPosition(left + scrollLeft, top + scrollTop - this.scrollOffset, options);
	}

	/**
	 * Scrolls to the specified position.
	 * @param x The pixel along the horizontal axis.
	 * @param y The pixel along the vertical axis.
	 * @param options Value indicating whether scrolling is instant or animates smoothly.
	 */
	scrollToPosition(x: number, y: number, options: ScrollOptions = {}): void {
		this.#viewport().scrollTo({left: x, top: y, behavior: options.behavior ?? "auto"});
	}

	/**
	 * Scrolls to the top.
	 * @param options Value indicating whether scrolling is instant or animates smoothly.
	 */
	scrollToTop(options: ScrollOptions = {}): void {
		this.scrollToPosition(0, 0, options);
	}
}
