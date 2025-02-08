import {Component} from "./component.js";
import {html, type TemplateResult} from "lit";
import {customElement, state} from "lit/decorators.js";
import {when} from "lit/directives/when.js";

/**
 * A component that shows up when the network is unavailable, and hides when connectivity is restored.
 */
@customElement("offline-indicator")
export class OfflineIndicator extends Component {

	/**
	 * Value indicating whether the browser is online.
	 */
	@state() private isOnline = navigator.onLine;

	/**
	 * Creates a new offline indicator.
	 */
	constructor() {
		super({shadowRoot: true});
	}

	/**
	 * Method invoked when this component is connected.
	 */
	override connectedCallback(): void {
		super.connectedCallback();
		for (const event of ["online", "offline"]) addEventListener(event, this);
	}

	/**
	 * Method invoked when this component is disconnected.
	 */
	override disconnectedCallback(): void {
		for (const event of ["online", "offline"]) removeEventListener(event, this);
		super.disconnectedCallback();
	}

	/**
	 * Handles the events.
	 */
	handleEvent(): void {
		this.isOnline = navigator.onLine;
	}

	/**
	 * Renders this component.
	 * @returns The view template.
	 */
	protected override render(): TemplateResult {
		return when(!this.isOnline, () => html`
			<slot>
				<div class="alert alert-danger border-end-0 border-start-0 mb-0 rounded-0">
					<i class="icon icon-fill fw-bold me-1">error</i> Le réseau est inaccessible.
					<span class="d-none d-sm-inline">Vérifiez votre connexion.</span>
				</div>
			</slot>
		`);
	}
}
