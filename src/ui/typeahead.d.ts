import {Component} from "#html/component";

/**
 * A data list providing autocomplete suggestions.
 */
export class Typeahead extends Component {

	/**
	 * The function invoked when the query has been changed.
	 */
	handler: (value: string) => Promise<Map<string, string>>;

	/**
	 * The data list identifier.
	 */
	list: string;

	/**
	 * The minimum character length needed before triggering autocomplete suggestions.
	 */
	minLength: number;

	/**
	 * The query to look up.
	 */
	query: string;

	/**
	 * The delay in milliseconds to wait before triggering autocomplete suggestions.
	 */
	wait: number;
}

/**
 * Declaration merging.
 */
declare global {

	/**
	 * The map of HTML tag names.
	 */
	interface HTMLElementTagNameMap {
		"type-ahead": Typeahead;
	}
}
