package belin_core.html;

import coconut.data.List;
import coconut.data.Model;
import coconut.ui.View;
import haxe.Timer;
import intl.Locale;
import js.Browser;
import js.bootstrap.Toast as BootstrapToast;
import js.bootstrap.Toast.ToastEvents;
import js.html.Element;
import js.lib.intl.RelativeTimeFormat;
using DateTools;

/** Represents a notification message. **/
class Notification implements Model {

	/** Value indicating whether to apply a fade transition. **/
	@:constant var animation: Bool = @byDefault false;

	/** Value indicating whether to automatically hide the notification. **/
	@:constant var autohide: Bool = @byDefault true;

	/** The title displayed in the header. **/
	@:constant var caption: String = @byDefault "";

	/** The message displayed in the body. **/
	@:constant var content: String = @byDefault "";

	/** A contextual modifier. **/
	@:constant var context: Null<Context> = @byDefault null;

	/** The delay, in milliseconds, to hide the notification. **/
	@:constant var delay: Int = @byDefault 5_000;

	/** The icon displayed next to the title. **/
	@:constant var icon: String = @byDefault "";
}

/** Displays a notification. **/
class Toast extends View {

	/** The time units. **/
	static final timeUnits: Array<RelativeTimeUnit> = [Second, Minute, Hour];

	/** The notification to show. **/
	@:attribute var notification: Notification;

	/** The toaster managing this notification. **/
	@:attribute var toaster: Toaster;

	/** The elapsed time. **/
	@:state var elapsedTime = "maintenant";

	/** The root element. **/
	@:ref final root: Element;

	/** Formats the specified elapsed time. **/
	function formatTime(formatter: RelativeTimeFormat, seconds: Float) {
		var index = 0;
		while (seconds > 60 && index < timeUnits.length) {
			seconds /= 60;
			index++;
		}

		return formatter.format(Math.round(-seconds), timeUnits[index]);
	}

	/** Renders this view. **/
	function render() '
		<div class="toast" ref=$root>
			<div class=${["toast-header" => true, 'toast-header-${notification.context}' => notification.context != null]}>
				<if ${notification.icon.length > 0}>
					<i class=${["icon icon-fill me-1" => true, 'text-${notification.context}' => notification.context != null]}>${notification.icon}</i>
				</if>
				<b class="me-auto">${notification.caption}</b>
				<small class="text-secondary">$elapsedTime</small>
				<button class="btn-close" data-bs-dismiss="toast"/>
			</div>
			<raw class="toast-body" content=${notification.content} tag="div"/>
		</div>
	';

	/** Method invoked after this view is mounted. **/
	override function viewDidMount() {
		final formatter = new RelativeTimeFormat(toaster.locale, {style: Long});
		final timer = new Timer(Std.int(1.seconds()));
		final timestamp = Date.now().getTime();
		timer.run = () -> elapsedTime = formatTime(formatter, (Date.now().getTime() - timestamp) / 1.seconds());

		final toast = new BootstrapToast(root, {
			animation: notification.animation,
			autohide: notification.autohide,
			delay: notification.delay
		});

		final handler = () -> toaster.close(notification);
		root.addEventListener(ToastEvents.Hidden, handler);
		toast.show();

		beforeUnmounting(() -> {
			root.removeEventListener(ToastEvents.Hidden, handler);
			toast.dispose();
			timer.stop();
		});
	}
}

/** Manages the notification messages. **/
class Toaster extends View {

	/** The locale used to format the relative times. **/
	@:attribute var locale: Locale = {
		final language = Browser.document.documentElement.lang;
		language.length > 0 ? language : Browser.navigator.language;
	}

	/** The notification list. **/
	@:state var notifications: List<Notification> = new List();

	/** Closes the toast associated with the specified `notification`. **/
	public function close(notification: Notification): Void
		notifications = notifications.filter(item -> item != notification);

	/** Shows a notification with the specified `message`. **/
	public function notify(caption: String, message: String, ?options: ToasterOptions): Void {
		if (options == null) options = {};

		final context = options.context != null ? options.context : Context.Info;
		show(new Notification({
			animation: options.animation != null ? options.animation : false,
			autohide: options.autohide != null ? options.autohide : true,
			caption: caption,
			content: message,
			context: context,
			delay: options.delay != null ? options.delay : 5_000,
			icon: options.icon != null ? options.icon : context.icon
		}));
	}

	/** Shows a toast with the specified `notification`. **/
	public function show(notification: Notification): Void
		notifications = notifications.append(notification);

	/** Renders this view. **/
	function render() '
		<div class="toast-container bottom-0 end-0 p-3">
			<for ${notification in notifications}>
				<Toast notification=$notification toaster=$this/>
			</for>
		</div>
	';
}

/** Defines the options of a `Toaster` notification. **/
typedef ToasterOptions = {

	/** Value indicating whether to apply a fade transition. **/
	var ?animation: Bool;

	/** Value indicating whether to automatically hide the notification. **/
	var ?autohide: Bool;

	/** A contextual modifier. **/
	var ?context: Context;

	/** The delay, in milliseconds, to hide the notification. **/
	var ?delay: Int;

	/** The icon displayed next to the title. **/
	var ?icon: String;
}
