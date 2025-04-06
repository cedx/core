import {html, type TemplateResult} from "lit";
import {customElement, property, state} from "lit/decorators.js";
import {map} from "lit/directives/map.js";
import {Component} from "./Component.js";

/**
 * A data list providing autocomplete suggestions.
 */
@customElement("type-ahead")
export class Typeahead extends Component {

	/**
	 * The function invoked when the query has been changed.
	 */
	@property({attribute: false}) handler: (value: string) => Promise<Map<string, string>> = () => Promise.resolve(new Map<string, string>);

	/**
	 * The data list identifier.
	 */
	@property() list = "";

	/**
	 * The minimum character length needed before triggering autocomplete suggestions.
	 */
	@property({type: Number}) minLength = 2;

	/**
	 * The query to look up.
	 */
	@property() query = "";

	/**
	 * The delay in milliseconds to wait before triggering autocomplete suggestions.
	 */
	@property({type: Number}) wait = 300;

	/**
	 * The data list items.
	 */
	@state() private items = new Map<string, string>;

	/**
	 * The debounced handler used to look up the query.
	 */
	#debounced: (value: string) => void = () => { /* Noop */ };

	/**
	 * The previous query.
	 */
	#previousQuery = "";

	/**
	 * Method invoked when this component is connected.
	 */
	override connectedCallback(): void {
		super.connectedCallback();
		const handler = (query: string): void => { this.handler(query).then(items => this.items = items, () => this.items = new Map<string, string>) };
		this.#debounced = this.#debounce(handler, this.wait);
	}

	/**
	 * Renders this component.
	 * @returns The view template.
	 */
	protected override render(): TemplateResult {
		return html`
			<datalist id=${this.list}>
				${map(this.items, ([key, value]) => html`<option value=${key}>${value}</option>`)}
			</datalist>
		`;
	}

	/**
	 * Method invoked after each rendering.
	 */
	protected override updated(): void {
		const query = this.query.trim();
		if (query != this.#previousQuery) {
			this.#previousQuery = query;
			if (query.length < this.minLength) this.items = new Map;
			else this.#debounced(query);
		}
	}

	/**
	 * Postpones the invocation of the specified callback until after a given delay has elapsed since the last time it was invoked.
	 * @param callback The function to debounce.
	 * @param delay The delay to wait, in milliseconds.
	 * @returns The debounced function.
	 */
	#debounce(callback: (value: string) => void, delay: number): (value: string) => void {
		let timer = 0;
		return value => {
			if (timer) clearTimeout(timer);
			timer = window.setTimeout(callback, delay, value);
		};
	}
}
