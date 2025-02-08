import type {ActionBar} from "./action_bar.js";
import type {FullScreenToggler} from "./fullscreen_toggler.js";
import type {LoadingIndicator} from "./loading_indicator.js";
import type {MessageBox} from "./message_box.js";
import type {OfflineIndicator} from "./offline_indicator.js";
import type {PageTitle} from "./page_title.js";
import type {RedirectTo} from "./redirect_to.js";
import type {ThemeDropdown} from "./theme_dropdown.js";
import type {Toast, Toaster} from "./toaster.js";
import type {Typeahead} from "./typeahead.js";

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
		"page-title": PageTitle;
		"redirect-to": RedirectTo;
		"theme-dropdown": ThemeDropdown;
		"toaster-container": Toaster;
		"toaster-item": Toast;
		"type-ahead": Typeahead;
	}
}
