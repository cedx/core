import {html, type TemplateResult} from "lit";
import {Component} from "../component.js";

/**
 * An action bar located under the navigation bar.
 */
export class ActionBar extends Component {

	/**
	 * Creates a new action bar.
	 */
	constructor() {
		super({shadowRoot: true});
	}

	/**
	 * Registers the component.
	 */
	static {
		customElements.define("action-bar", this);
	}

	/**
	 * Method invoked when this component is disconnected.
	 */
	override disconnectedCallback(): void {
		document.documentElement.style.removeProperty("--main-offset");
		super.disconnectedCallback();
	}

	/**
	 * Method invoked after the first rendering.
	 * @returns Resolves when this component has been updated.
	 */
	protected override async firstUpdated(): Promise<void> {
		await this.updateComplete;
		const {documentElement} = document;
		const navbarHeight = parseInt(getComputedStyle(documentElement).getPropertyValue("--navbar-height"));
		const mainOffset = this.offsetHeight + (Number.isNaN(navbarHeight) ? 0 : navbarHeight);
		documentElement.style.setProperty("--main-offset", `${mainOffset}px`);
	}

	/**
	 * Renders this component.
	 * @returns The view template.
	 */
	protected override render(): TemplateResult {
		return html`
			<aside class="container-fluid">
				<slot class="d-flex justify-content-between align-items-center"></slot>
			</aside>
		`;
	}
}

/**
 * Declaration merging.
 */
declare global {

	/**
	 * The map of HTML tag names.
	 */
	interface HTMLElementTagNameMap {
		"action-bar": ActionBar;
	}
}
