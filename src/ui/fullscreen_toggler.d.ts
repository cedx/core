import {Context} from "#data/context";
import {Component} from "#html/component";
import {Size} from "#html/size";
import {Variant} from "#html/variant";

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
