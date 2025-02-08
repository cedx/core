import {css, LitElement, type CSSResultGroup} from "lit";

/**
 * The base class for custom elements.
 */
export abstract class Component extends LitElement {

	/**
	 * The component styles.
	 */
	static override styles: CSSResultGroup = [document.adoptedStyleSheets, css`:host { contain: layout style; }`];

	/**
	 * Value indicating whether this component uses a shadow root.
	 */
	readonly #useShadowRoot: boolean;

	/**
	 * Creates a new custom element.
	 * @param options Value indicating whether this component uses a shadow root.
	 */
	constructor(options: {shadowRoot?: boolean} = {}) {
		super();
		this.#useShadowRoot = options.shadowRoot ?? false;
	}

	/**
	 * Returns the node into which this component should render.
	 */
	protected override createRenderRoot(): DocumentFragment|HTMLElement {
		return this.#useShadowRoot ? super.createRenderRoot() : this;
	}
}
