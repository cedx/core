import {Component} from "#html/component";
import {html, type TemplateResult} from "lit";
import {customElement, property, state} from "lit/decorators.js";

/**
 * A component setting the document title.
 */
@customElement("page-title")
export class PageTitle extends Component {

	/**
	 * The string used to separate the page title from the application name.
	 */
	@property() delimiter = "-";

	/**
	 * The text of the page title.
	 */
	@property() text = "";

	/**
	 * Value indicating whether the application is standalone.
	 */
	@state() private isStandalone = ["fullscreen", "minimal-ui", "standalone", "tabbed"].some(mode => matchMedia(`(display-mode: ${mode})`).matches);

	/**
	 * The application name.
	 */
	#appName = document.head.querySelector<HTMLMetaElement>('meta[name="application-name"]')?.content ?? "";

	/**
	 * Creates a new page title.
	 */
	constructor() {
		super({shadowRoot: true});
	}

	/**
	 * Method invoked when this component is connected.
	 */
	override connectedCallback(): void {
		super.connectedCallback();
		addEventListener("appinstalled", this);
	}

	/**
	 * Method invoked when this component is disconnected.
	 */
	override disconnectedCallback(): void {
		removeEventListener("appinstalled", this);
		super.disconnectedCallback();
	}

	/**
	 * Handles the events.
	 */
	handleEvent() {
		this.isStandalone = true;
	}

	/**
	 * Renders this component.
	 * @returns The view template.
	 */
	protected override render(): TemplateResult {
		return html`<slot></slot>`;
	}

	/**
	 * Method invoked after each rendering.
	 */
	protected override updated(): void {
		const text = this.text.trim() || this.textContent?.trim() || "";
		document.title = this.isStandalone ? text : [text, this.#appName].filter(item => item.length).join(` ${this.delimiter} `);
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
		"page-title": PageTitle;
	}
}
