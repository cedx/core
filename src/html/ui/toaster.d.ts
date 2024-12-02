import {Context} from "@cedx/core/data/context.js";
import {TemplateResult} from "lit";
import {Component} from "../component.js";

/**
 * Represents a notification message.
 */
export type Notification = Partial<{

	/**
	 * Value indicating whether to apply a fade transition.
	 */
	animation: boolean;

	/**
	 * Value indicating whether to automatically hide the notification.
	 */
	autohide: boolean;

	/**
	 * The title displayed in the header.
	 */
	caption: string;

	/**
	 * The message displayed in the body.
	 */
	content: TemplateResult;

	/**
	 * A contextual modifier.
	 */
	context: Context;

	/**
	 * The delay, in milliseconds, to hide the notification.
	 */
	delay: number;

	/**
	 * The icon displayed next to the title.
	 */
	icon: string;
}>;

/**
 * Displays a notification message.
 */
export class Toast extends Component {

	/**
	 * The notification to show.
	 */
	notification: Notification;

	/**
	 * The toaster managing this notification.
	 */
	toaster: Toaster;
}

/**
 * Manages the notification messages.
 */
export class Toaster extends Component {

	/**
	 * The locale used to format the relative times.
	 */
	locale: Intl.Locale|string;

	/**
	 * Closes the toast associated with the specified notification.
	 * @param notification The notification to close.
	 */
	close(notification: Notification): void;

	/**
	 * Shows a notification with the specified message.
	 * @param caption The title displayed in the header.
	 * @param message The message to show.
	 * @param options The notification options.
	 */
	notify(caption: string, message: TemplateResult, options?: Notification): void;

	/**
	 * Shows a toast with the specified notification.
	 * @param notification The notification to show.
	 */
	show(notification: Notification): void;
}

/**
 * Declaration merging.
 */
declare global {

	/**
	 * The map of HTML tag names.
	 */
	interface HTMLElementTagNameMap {
		"toaster-item": Toast;
		"toaster-container": Toaster;
	}
}
