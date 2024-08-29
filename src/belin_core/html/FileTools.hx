package belin_core.html;

import haxe.Timer;
import js.Browser;
import js.html.File;
import js.html.FilePropertyBag;
import js.html.URL;
import tink.domspec.Attributes.Target;
using DateTools;

/** Provides static extensions for files. **/
abstract class FileTools {

	/** Downloads the specified `file`. **/
	public static function download(file: File): Void {
		final url = URL.createObjectURL(file);
		final anchor = Browser.document.createAnchorElement();
		anchor.download = file.name;
		anchor.href = url;

		Browser.document.body.appendChild(anchor);
		anchor.click();
		Browser.document.body.removeChild(anchor);
		URL.revokeObjectURL(url);
	}

	/** Downloads the specified `text` content. **/
	public static function downloadString(text: String, fileName: String, ?options: FilePropertyBag): Void
		download(new File([text], fileName, options));

	/** Opens the specified `file`, eventually in a new tab. **/
	public static function open(file: File, newTab = false): Void {
		final url = URL.createObjectURL(file);
		if (!newTab) return Browser.location.assign(url);

		final handle = Browser.window.open(url, Target.Blank);
		if (handle == null) return Browser.location.assign(url);

		final timer = new Timer(Std.int(5.seconds()));
		timer.run = () -> if (handle.closed) {
			timer.stop();
			URL.revokeObjectURL(url);
		};
	}

	/** Prints the specified `file`. **/
	public static function print(file: File): Void {
		final url = URL.createObjectURL(file);
		final frame = Browser.document.createIFrameElement();
		frame.addEventListener("load", () -> frame.contentWindow.print(), {passive: true});
		frame.hidden = true;
		frame.src = url;

		Browser.window.addEventListener("focus", () -> {
			Browser.document.body.removeChild(frame);
			URL.revokeObjectURL(url);
		}, {once: true, passive: true});

		Browser.document.body.appendChild(frame);
	}
}
