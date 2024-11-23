import {TemplateResult} from "lit";
import {Context} from "../../data/context.js";
import {Component} from "../component.js";
import {Variant} from "../variant.js";

/**
 * Displays a message window, also known as dialog box, which presents a message to the user.
 */
export class MessageBox extends Component {

	/**
	 * Value indicating whether to vertically center this message box.
	 */
	centered: boolean;

	/**
	 * Opens an alert dialog with the specified message and an "OK" button.
	 * @param caption The title displayed in the header.
	 * @param message The message to show.
	 * @param options The message box options.
	 * @returns Resolves with the value of the clicked button.
	 */
	alert(caption: string, message: TemplateResult, options?: MessageBoxOptions): Promise<string>;

	/**
	 * Closes the message box.
	 * @param result The message box result.
	 */
	close(result?: string): void;

	/**
	 * Opens a confirmation dialog with the specified message and two buttons, "OK" and "Cancel".
	 * @param caption The title displayed in the header.
	 * @param message The message to show.
	 * @param options The message box options.
	 * @returns Resolves with the value of the clicked button.
	 */
	confirm(caption: string, message: TemplateResult, options?: MessageBoxOptions): Promise<string>;

	/**
	 * Opens a modal dialog with the specified message and options.
	 * @param message The message to show.
	 * @param options The message box options.
	 * @returns Resolves with the value of the clicked button.
	 */
	show(message: TemplateResult, options?: MessageBoxOptions): Promise<string>;
}

/**
 * A message box button.
 */
export type MessageBoxButton = Partial<{

	/**
	 * The button icon.
	 */
	icon: string;

	/**
	 * The button label.
	 */
	label: string;

	/**
	 * The button value.
	 */
	value: string;

	/**
	 * A tone variant.
	 */
	variant: Context|Variant;
}>;

/**
 * Defines the options of a {@link MessageBox} instance.
 */
export type MessageBoxOptions = Partial<{

	/**
	 * The buttons displayed in the footer.
	 */
	buttons: MessageBoxButton[];

	/**
	 * The title displayed in the header.
	 */
	caption: string;

	/**
	 * A contextual modifier.
	 */
	context: Context;

	/**
	 * The icon displayed next to the body.
	 */
	icon: string;
}>;

/**
 * Specifies the return value of a message box.
 */
export const MessageBoxResult: Readonly<{

	/**
	 * The message box does not return any value.
	 */
	none: "",

	/**
	 * The return value of the message box is "OK".
	 */
	ok: "ok",

	/**
	 * The return value of the message box is "Cancel".
	 */
	cancel: "cancel"
}>;

/**
 * Specifies the return value of a message box.
 */
export type MessageBoxResult = typeof MessageBoxResult[keyof typeof MessageBoxResult];
