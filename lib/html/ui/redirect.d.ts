import {Component} from "../component.js";
import {Router} from "../router.js";

/**
 * Navigates to a new location.
 */
export class Redirect extends Component {

	/**
	 * Value indicating whether to push a new entry onto the history instead of replacing the current one.
	 */
	push: boolean;

	/**
	 * The route to redirect to.
	 */
	route: string;

	/**
	 * The routing service.
	 */
	router: Router|null;
}

/**
 * Declaration merging.
 */
declare global {

	/**
	 * The map of HTML tag names.
	 */
	interface HTMLElementTagNameMap {
		"redirect-to": Redirect;
	}
}
