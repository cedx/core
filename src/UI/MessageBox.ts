import {Context, contextIcon} from "#data/context.js";
import {Variant} from "#html/variant.js";
import {html, type TemplateResult} from "lit";
import {customElement, property, query, state} from "lit/decorators.js";
import {classMap} from "lit/directives/class-map.js";
import {when} from "lit/directives/when.js";
import {Component} from "./component.js";

/**
 * Specifies the return value of a message box.
 */
export const MessageBoxResult = Object.freeze({

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
});

/**
 * Specifies the return value of a message box.
 */
export type MessageBoxResult = typeof MessageBoxResult[keyof typeof MessageBoxResult];

/**
 * Displays a message window, also known as dialog box, which presents a message to the user.
 */
@customElement("message-box")
export class MessageBox extends Component {

	/**
	 * Value indicating whether to vertically center this message box.
	 */
	@property({type: Boolean}) centered = false;

	/**
	 * The buttons displayed in the footer.
	 */
	@state() private buttons: MessageBoxButton[] = [];

	/**
	 * The title displayed in the header.
	 */
	@state() private caption = "";

	/**
	 * The message displayed in the body.
	 */
	@state() private content: TemplateResult = html``;

	/**
	 * A contextual modifier.
	 */
	@state() private context: Context|null = null;

	/**
	 * The icon displayed next to the body.
	 */
	@state() private icon = "";

	/**
	 * The root element.
	 */
	@query("dialog", true) private readonly root!: HTMLDialogElement;

	/**
	 * The function invoked to return the dialog box result.
	 */
	#resolve: (value: string) => void = () => { /* Noop */ };

	/**
	 * Opens an alert dialog with the specified message and an "OK" button.
	 * @param caption The title displayed in the header.
	 * @param message The message to show.
	 * @param options The message box options.
	 * @returns Resolves with the value of the clicked button.
	 */
	alert(caption: string, message: TemplateResult, options: MessageBoxOptions = {}): Promise<string> {
		const context = options.context ?? Context.warning;
		return this.show(message, {
			buttons: options.buttons ?? [{label: "OK", value: MessageBoxResult.ok}],
			caption,
			context,
			icon: options.icon ?? contextIcon(context)
		});
	}

	/**
	 * Closes the message box.
	 * @param result The message box result.
	 */
	close(result: MessageBoxResult = MessageBoxResult.none): void {
		this.root.close(result);
	}

	/**
	 * Opens a confirmation dialog with the specified message and two buttons, "OK" and "Cancel".
	 * @param caption The title displayed in the header.
	 * @param message The message to show.
	 * @param options The message box options.
	 * @returns Resolves with the value of the clicked button.
	 */
	confirm(caption: string, message: TemplateResult, options: MessageBoxOptions = {}): Promise<string> {
		const context = options.context ?? Context.warning;
		return this.show(message, {
			caption,
			context,
			icon: options.icon ?? contextIcon(context),
			buttons: options.buttons ?? [
				{label: "OK", value: MessageBoxResult.ok},
				{label: "Annuler", value: MessageBoxResult.cancel, variant: Variant.secondary}
			]
		});
	}

	/**
	 * Opens a modal dialog with the specified message and options.
	 * @param message The message to show.
	 * @param options The message box options.
	 * @returns Resolves with the value of the clicked button.
	 */
	show(message: TemplateResult, options: MessageBoxOptions = {}): Promise<string> {
		this.buttons = options.buttons ?? [];
		this.caption = options.caption ?? "";
		this.content = message;
		this.context = options.context ?? null;
		this.icon = options.icon ?? "";

		this.root.returnValue = MessageBoxResult.none;
		this.root.showModal();
		this.root.querySelector<HTMLButtonElement>(".btn-close")?.blur();

		const {promise, resolve} = Promise.withResolvers<string>();
		this.#resolve = resolve;
		return promise;
	}

	/**
	 * Renders this component.
	 * @returns The view template.
	 */
	protected override render(): TemplateResult {
		const centered = classMap({"modal-dialog-centered": this.centered});
		return html`
			<dialog class="modal modal-dialog modal-dialog-scrollable ${centered}" @click=${this.#onDialogClick} @close=${this.#onDialogClose}>
				<form class="modal-content" method="dialog">
					<div class="modal-header user-select-none">
						${when(this.caption, () => html`<h1 class="modal-title fs-5">${this.caption}</h1>`)}
						<button class="btn-close"></button>
					</div>
					<div class="modal-body d-flex">
						${when(this.icon, () => html`
							<i class="icon icon-fill fs-1 fw-semibold me-2 ${classMap({[`text-${this.context}`]: this.context ?? ""})}">${this.icon}</i>
						`)}
						<div class="flex-grow-1">${this.content}</div>
					</div>
					${when(this.buttons.length, () => html`
						<div class="modal-footer user-select-none">
							${this.buttons.map(button => html`
								<button class="btn btn-${button.variant ?? Variant.primary}" value=${button.value ?? MessageBoxResult.none}>
									${when(button.icon, () => html`<i class="icon icon-fill ${classMap({"me-1": button.label ?? ""})}">${button.icon}</i>`)}
									${button.label}
								</button>
							`)}
						</div>
					`)}
				</form>
			</dialog>
		`;
	}

	/**
	 * Handles the `click` event.
	 * @param event The dispatched event.
	 */
	#onDialogClick(event: Event): void {
		if (event.target == this.root) this.close();
	}

	/**
	 * Handles the `close` event.
	 */
	#onDialogClose(): void {
		this.#resolve(this.root.returnValue);
	}
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
