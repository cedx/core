import {Component} from "#html/component";
import {Theme} from "#html/theme";

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
	 * The key of the storage entry providing the saved theme.
	 */
	storageKey: string;

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
