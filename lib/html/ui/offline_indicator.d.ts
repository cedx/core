import {Component} from "../component.js";

/**
 * A component that shows up when the network is unavailable, and hides when connectivity is restored.
 */
export class OfflineIndicator extends Component {}

/**
 * Declaration merging.
 */
declare global {

	/**
	 * The map of HTML tag names.
	 */
	interface HTMLElementTagNameMap {
		"offline-indicator": OfflineIndicator;
	}
}
