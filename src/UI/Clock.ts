import {Duration} from "#Util/Duration.js";
import type {ReactiveControllerHost} from "lit";

/**
 * A controller managing a clock.
 */
export class Clock {

	/**
	 * The clock value.
	 */
	value = new Date;

	/**
	 * The host element.
	 */
	readonly #host: ReactiveControllerHost;

	/**
	 * The timer delay, in milliseconds.
	 */
	readonly #timeout: number;

	/**
	 * The timer identifier.
	 */
	#timer = 0;

	/**
	 * Creates a new clock controller.
	 * @param host The host element.
	 * @param timeout The timer delay, in seconds.
	 */
	constructor(host: ReactiveControllerHost, timeout = 1) {
		(this.#host = host).addController(this);
		this.#timeout = timeout * Duration.Second;
	}

	/**
	 * Method invoked when the host element is connected.
	 */
	hostConnected(): void {
		this.value = new Date;
		this.#timer = window.setInterval(() => {
			this.value = new Date;
			this.#host.requestUpdate();
		}, this.#timeout);
	}

	/**
	 * Method invoked when the host element is disconnected.
	 */
	hostDisconnected(): void {
		clearInterval(this.#timer);
		this.#timer = 0;
	}
}
