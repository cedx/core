import {Component} from "../component.js"
import {Theme} from "../theme.js";

/**
 * A dropdown menu for switching the color mode.
 */
export class ThemeDropdown extends Component {

	/**
	 * The alignement of the dropdown menu.
	 */
	align: "end"|"start";

	/**
	 * The label of the dropdown menu.
	 */
	label: string;

	/**
	 * The current theme.
	 */
	theme: Theme;
}

/**
 * Declaration merging.
 */
declare global {

	/**
	 * The map of HTML tag names.
	 */
	interface HTMLElementTagNameMap {
		"theme-dropdown": ThemeDropdown;
	}
}
