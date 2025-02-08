import {Component} from "#html/component";

/**
 * A component setting the document title.
 */
export class PageTitle extends Component {

	/**
	 * The string used to separate the page title from the application name.
	 */
	delimiter: string;

	/**
	 * The text of the page title.
	 */
	text: string;
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
