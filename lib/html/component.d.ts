import {LitElement} from "lit";

/**
 * The base class for custom elements.
 */
export abstract class Component extends LitElement {

	/**
	 * Creates a new custom element.
	 * @param options An object providing values to initialize this instance.
	 */
	constructor(options?: {shadowRoot?: boolean});
}
