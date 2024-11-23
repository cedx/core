import {ReactiveControllerHost} from "lit";

/**
 * A controller managing a clock.
 */
export class Clock {

	/**
	 * The clock value.
	 */
	readonly value: Date;

	/**
	 * Creates a new clock controller.
	 * @param host The host element.
	 * @param timeout The timer delay, in seconds.
	 */
	constructor(host: ReactiveControllerHost, timeout?: number);
}
