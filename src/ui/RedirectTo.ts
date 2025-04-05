import {Component} from "./component.js";
import type {Router} from "./router.js";
import {customElement, property} from "lit/decorators.js";

/**
 * Navigates to a new location.
 */
@customElement("redirect-to")
export class RedirectTo extends Component {

	/**
	 * Value indicating whether to push a new entry onto the history instead of replacing the current one.
	 */
	@property({type: Boolean}) push = false;

	/**
	 * The route to redirect to.
	 */
	@property() route = "";

	/**
	 * The routing service.
	 */
	@property({attribute: false}) router: Router|null = null;

	/**
	 * Method invoked when this component is connected.
	 */
	override connectedCallback(): void {
		super.connectedCallback();
		void this.updateComplete.finally(() => {
			if (this.router) void this.router.goto(this.route, {push: this.push});
			else if (this.push) location.assign(this.route);
			else location.replace(this.route);
		});
	}
}
