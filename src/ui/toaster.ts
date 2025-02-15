import {Context, contextIcon} from "#data/context.js";
import {Duration} from "#util/duration.js";
import {Toast as BootstrapToast} from "bootstrap";
import {html, type TemplateResult} from "lit";
import {customElement, property, state} from "lit/decorators.js";
import {classMap} from "lit/directives/class-map.js";
import {repeat} from "lit/directives/repeat.js";
import {when} from "lit/directives/when.js";
import {Component} from "./component.js";

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
@customElement("toaster-item")
export class Toast extends Component {

	/**
	 * The time units.
	 */
	private static readonly timeUnits: Intl.RelativeTimeFormatUnit[] = ["second", "minute", "hour"];

	/**
	 * The notification to show.
	 */
	@property({attribute: false}) notification: Notification = {};

	/**
	 * The toaster managing this notification.
	 */
	@property({attribute: false}) toaster!: Toaster;

	/**
	 * The elapsed time.
	 */
	@state() private elapsedTime = "maintenant";

	/**
	 * The formatter used to format the relative time.
	 */
	#formatter!: Intl.RelativeTimeFormat;

	/**
	 * The timer identifier.
	 */
	#timer = 0;

	/**
	 * The underlying Bootstrap toast.
	 */
	#toast!: BootstrapToast;

	/**
	 * Method invoked when this component is connected.
	 */
	override connectedCallback(): void {
		super.connectedCallback();
		const timestamp = Date.now();
		this.#formatter = new Intl.RelativeTimeFormat(this.toaster.locale, {style: "long"});
		this.#timer = window.setInterval(() => this.elapsedTime = this.#formatTime((Date.now() - timestamp) / Duration.second), Duration.second);
	}

	/**
	 * Method invoked when this component is disconnected.
	 */
	override disconnectedCallback(): void {
		clearInterval(this.#timer);
		this.#toast.dispose();
		super.disconnectedCallback();
	}

	/**
	 * Method invoked after the first rendering.
	 */
	protected override firstUpdated(): void {
		this.#toast = new BootstrapToast(this.renderRoot.firstElementChild!, this.notification);
		this.#toast.show();
	}

	/**
	 * Renders this component.
	 */
	protected override render(): TemplateResult {
		const {context = Context.info} = this.notification;
		return html`
			<div class="toast" @hidden.bs.toast=${() => this.toaster.close(this.notification)}>
				<div class="toast-header ${classMap({[`toast-header-${context}`]: context})}">
					${when(this.notification.icon, () => html`<i class="icon icon-fill me-2 ${classMap({[`text-${context}`]: context})}">${this.notification.icon}</i>`)}
					<b class="me-auto">${this.notification.caption}</b>
					<small class="text-secondary">${this.elapsedTime}</small>
					<button class="btn-close" data-bs-dismiss="toast"></button>
				</div>
				<div class="toast-body">${this.notification.content}</div>
			</div>
		`;
	}

	/**
	 * Formats the specified elapsed time.
	 * @param elapsed The elapsed time, in seconds.
	 * @returns The formated time.
	 */
	#formatTime(elapsed: number): string {
		let index = 0;
		while (elapsed > 60 && index < Toast.timeUnits.length) {
			elapsed /= 60;
			index++;
		}

		return this.#formatter.format(Math.round(-elapsed), Toast.timeUnits[index]);
	}
}

/**
 * Manages the notification messages.
 */
@customElement("toaster-container")
export class Toaster extends Component {

	/**
	 * The locale used to format the relative times.
	 */
	@property() locale: Intl.Locale|string = navigator.language;

	/**
	 * The notification list.
	 */
	@state() private notifications: Notification[] = [];

	/**
	 * Closes the toast associated with the specified notification.
	 * @param notification The notification to close.
	 */
	close(notification: Notification): void {
		this.notifications = this.notifications.filter(item => item != notification);
	}

	/**
	 * Shows a notification with the specified message.
	 * @param caption The title displayed in the header.
	 * @param message The message to show.
	 * @param options The notification options.
	 */
	notify(caption: string, message: TemplateResult, options: Notification = {}): void {
		const context = options.context ?? Context.info;
		this.show({animation: false, context, icon: contextIcon(context), ...options, caption, content: message});
	}

	/**
	 * Shows a toast with the specified notification.
	 * @param notification The notification to show.
	 */
	show(notification: Notification): void {
		this.notifications = this.notifications.concat(notification);
	}

	/**
	 * Renders this component.
	 * @returns The view template.
	 */
	protected override render(): TemplateResult {
		return html`
			<div class="toast-container bottom-0 end-0 p-3">
				${repeat(this.notifications, item => item, (item, index) => html`
					<toaster-item class="d-block ${classMap({"mt-3": index})}" .notification=${item} .toaster=${this}></toaster-item>
				`)}
			</div>
		`;
	}
}
