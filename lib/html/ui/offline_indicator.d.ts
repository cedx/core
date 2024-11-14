import {Component} from "../component.js";

/**
 * A component that shows up when the network is unavailable, and hides when connectivity is restored.
 */
export class OfflineIndicator extends Component {

	/**
	 * Creates a new offline indicator.
	 */
	constructor();
}

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
