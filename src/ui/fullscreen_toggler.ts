import type {Context} from "#data/context";
import {Component} from "#html/component";
import {Size} from "#html/size";
import {Variant} from "#html/variant";
import {html, type TemplateResult} from "lit";
import {customElement, property} from "lit/decorators.js";
import {classMap} from "lit/directives/class-map.js";
import {when} from "lit/directives/when.js";

/**
 * A button for switching an element to full screen.
 */
@customElement("fullscreen-toggler")
export class FullScreenToggler extends Component {

	/**
	 * The button icon.
	 */
	@property() icon = "";

	/**
	 * The button label.
	 */
	@property() label = "";

	/**
	 * The button size.
	 */
	@property() size: Size = Size.medium;

	/**
	 * The CSS selector used to target the element.
	 */
	@property() target = "body";

	/**
	 * A tone variant.
	 */
	@property() variant: Context|Variant = Variant.primary;

	/**
	 * Value indicating whether to prevent the device screen from dimming or locking when in full screen mode.
	 */
	@property({type: Boolean}) wakeLock = false;

	/**
	 * The associated element.
	 */
	#element: Element = document.body;

	/**
	 * The handle to the underlying platform wake lock.
	 */
	#sentinel: WakeLockSentinel|null = null;

	/**
	 * Method invoked when this component is connected.
	 */
	override connectedCallback(): void {
		super.connectedCallback();
		document.addEventListener("visibilitychange", this);
		this.#element = document.querySelector(this.target) ?? document.body;
		this.#element.addEventListener("fullscreenchange", this);
	}

	/**
	 * Method invoked when this component is disconnected.
	 */
	override disconnectedCallback(): void {
		document.removeEventListener("visibilitychange", this);
		this.#element.removeEventListener("fullscreenchange", this);
		super.disconnectedCallback();
	}

	/**
	 * Handles the events.
	 * @param event The dispatched event.
	 */
	handleEvent(event: Event): void {
		switch (event.type) { // eslint-disable-line default-case
			case "fullscreenchange":
				if (document.fullscreenElement) void this.#acquireWakeLock();
				else void this.#releaseWakeLock();
				break;
			case "visibilitychange":
				if (document.fullscreenElement && document.visibilityState == "visible") void this.#acquireWakeLock();
				break;
		}
	}

	/**
	 * Toggles the full screen mode of the associated element.
	 * @returns Resolves when the full mode has been toggled.
	 */
	async toggleFullScreen(): Promise<void> {
		if (document.fullscreenElement) await document.exitFullscreen();
		else await this.#element.requestFullscreen();
	}

	/**
	 * Renders this component.
	 * @returns The view template.
	 */
	protected override render(): TemplateResult {
		return html`
			<button class="btn ${classMap({[`btn-${this.variant}`]: true, [`btn-${this.size}`]: this.size})}" @click=${this.toggleFullScreen}>
				${when(this.icon, () => html`<i class="icon ${classMap({"me-1": this.label})}">${this.icon}</i>`)}
				${when(this.label, () => this.label)}
			</button>
		`;
	}

	/**
	 * Acquires a new wake lock.
	 * @returns Resolves when the wake lock has been acquired.
	 */
	async #acquireWakeLock(): Promise<void> {
		if (!this.wakeLock && (!this.#sentinel || this.#sentinel.released)) this.#sentinel = await navigator.wakeLock.request();
	}

	/**
	 * Releases the acquired wake lock.
	 * @returns Resolves when the wake lock has been released.
	 */
	async #releaseWakeLock(): Promise<void> {
		if (this.wakeLock && this.#sentinel && !this.#sentinel.released) await this.#sentinel.release();
		this.#sentinel = null;
	}
}
