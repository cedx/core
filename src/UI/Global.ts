import type {ActionBar} from "./ActionBar.js";
import type {FullScreenToggler} from "./FullScreenToggler.js";
import type {LoadingIndicator} from "./LoadingIndicator.js";
import type {MessageBox} from "./MessageBox.js";
import type {OfflineIndicator} from "./OfflineIndicator.js";
import type {PageSelector} from "./PageSelector.js";
import type {PageTitle} from "./PageTitle.js";
import type {RedirectTo} from "./RedirectTo.js";
import type {ThemeDropdown} from "./ThemeDropdown.js";
import type {Toast, Toaster} from "./Toaster.js";
import type {Typeahead} from "./Typeahead.js";

/**
 * Declaration merging.
 */
declare global {

	/**
	 * The map of HTML tag names.
	 */
	interface HTMLElementTagNameMap { // eslint-disable-line @typescript-eslint/consistent-type-definitions
		"action-bar": ActionBar;
		"fullscreen-toggler": FullScreenToggler;
		"loading-indicator": LoadingIndicator;
		"message-box": MessageBox;
		"offline-indicator": OfflineIndicator;
		"page-selector": PageSelector;
		"page-title": PageTitle;
		"redirect-to": RedirectTo;
		"theme-dropdown": ThemeDropdown;
		"toaster-container": Toaster;
		"toaster-item": Toast;
		"type-ahead": Typeahead;
	}
}
