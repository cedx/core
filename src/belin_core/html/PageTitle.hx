package belin_core.html;

import coconut.ui.Children;
import coconut.ui.View;
import js.Browser;
import js.html.Element;
import js.html.MetaElement;
using Lambda;
using StringTools;

/** A heading setting the document title. **/
class PageTitle extends View {

	/** The view children. **/
	@:children var nodes: Children = [];

	/** The string used to separate the page title from the application name. **/
	@:tracked @:attribute var delimiter = "-";

	/** The text of the page title. **/
	@:tracked @:attribute var text = "";

	/** Value indicating whether the application is standalone. **/
	@:tracked @:state var isStandalone = ["fullscreen", "minimal-ui", "standalone", "tabbed"]
		.exists(mode -> Browser.window.matchMedia('(display-mode: $mode)').matches);

	/** The application name. **/
	final applicationName: String = {
		final meta = Browser.document.head.querySelector('meta[name="application-name"]');
		meta != null ? (cast meta: MetaElement).content : "";
	}

	/** The root element. **/
	@:ref final root: Element;

	/** Renders this view. **/
	function render() '
		<hgroup ref=$root>${...nodes}</hgroup>
	';

	/** Method invoked after this view is mounted. **/
	override function viewDidMount(): Void {
		final handler = () -> isStandalone = true;
		Browser.window.addEventListener("appinstalled", handler, {passive: true});
		beforeUnmounting(() -> Browser.window.removeEventListener("appinstalled", handler));
	}

	/** Method invoked after each rendering. **/
	override function viewDidRender(firstTime: Bool): Void {
		final title = (if (text.length > 0) text else root.textContent.length > 0 ? root.textContent : "").trim();
		Browser.document.title = isStandalone ? title : [title, applicationName].filter(item -> item.length > 0).join(' $delimiter ');
	}
}
