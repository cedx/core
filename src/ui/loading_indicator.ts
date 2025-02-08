import {Component} from "#html/component";
import {html, type TemplateResult} from "lit";
import {customElement} from "lit/decorators.js";

/**
 * A component that shows up when an HTTP request starts, and hides when all concurrent HTTP requests are completed.
 */
@customElement("loading-indicator")
export class LoadingIndicator extends Component {

	/**
	 * The number of concurrent HTTP requests.
	 */
	#requestCount = 0;

	/**
	 * Creates a new loading indicator.
	 */
	constructor() {
		super({shadowRoot: true});
		this.hidden = true;
	}

	/**
	 * Starts the loading indicator.
	 */
	start(): void {
		this.#requestCount++;
		this.hidden = false;
		document.body.classList.add("loading");
	}

	/**
	 * Stops the loading indicator.
	 * @param options Value indicating whether to force the loading indicator to stop.
	 */
	stop(options: {force?: boolean} = {}): void {
		this.#requestCount--;
		if (options.force || this.#requestCount <= 0) {
			this.#requestCount = 0;
			this.hidden = true;
			document.body.classList.remove("loading");
		}
	}

	/**
	 * Renders this component.
	 * @returns The view template.
	 */
	protected override render(): TemplateResult {
		return html`
			<slot>
				<div class="spinner-border text-light"></div>
			</slot>
		`;
	}
}
