import {LitElement} from "lit";

/**
 * The base class for custom elements.
 */
export abstract class Component extends LitElement {

	/**
	 * Creates a new custom element.
	 * @param options Value indicating whether this component uses a shadow root.
	 */
	constructor(options?: {shadowRoot?: boolean});
}
