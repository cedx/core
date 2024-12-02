import {Context} from "../../data/context.js";
import {Component} from "../component.js";
import {Size} from "../size.js";
import {Variant} from "../variant.js";

/**
 * A button for switching an element to full screen.
 */
export class FullScreenToggler extends Component {

	/**
	 * The button icon.
	 */
	icon: string;

	/**
	 * The button label.
	 */
	label: string;

	/**
	 * The button size.
	 */
	size: Size;

	/**
	 * The CSS selector used to target the element.
	 */
	target: string;

	/**
	 * A tone variant.
	 */
	variant: Context|Variant;

	/**
	 * Value indicating whether to prevent the device screen from dimming or locking when in full screen mode.
	 */
	wakeLock: boolean;

	/**
	 * Toggles the full screen mode of the associated element.
	 * @returns Resolves when the full mode has been toggled.
	 */
	toggleFullScreen(): Promise<void>;
}

/**
 * Declaration merging.
 */
declare global {

	/**
	 * The map of HTML tag names.
	 */
	interface HTMLElementTagNameMap {
		"fullscreen-toggler": FullScreenToggler;
	}
}
