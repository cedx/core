import {Component} from "../component.js";

/**
 * A component that shows up when an HTTP request starts, and hides when all concurrent HTTP requests are completed.
 */
export class LoadingIndicator extends Component {

	/**
	 * Starts the loading indicator.
	 */
	start(): void;

	/**
	 * Stops the loading indicator.
	 * @param options Value indicating whether to force the loading indicator to stop.
	 */
	stop(options?: {force?: boolean}): void;
}

/**
 * Declaration merging.
 */
declare global {

	/**
	 * The map of HTML tag names.
	 */
	interface HTMLElementTagNameMap {
		"loading-indicator": LoadingIndicator;
	}
}
