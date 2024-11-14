import {Component} from "../component.js";

/**
 * An action bar located under the navigation bar.
 */
export class ActionBar extends Component {}

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
