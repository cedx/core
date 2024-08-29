package belin_core.html;

import coconut.ui.Children;
import coconut.ui.View;
import js.Browser;
import js.html.Element;

/** An action bar located under the navigation bar. **/
class ActionBar extends View {

	/** The view children. **/
	@:children var nodes: Children;

	/** The root element. **/
	@:ref final root: Element;

	/** Renders this view. **/
	function render() '
		<aside class="action-bar container-fluid" ref=$root>
			<div class="d-flex justify-content-between align-items-center">
				${...nodes}
			</div>
		</aside>
	';

	/** Method invoked after this view is mounted. **/
	override function viewDidMount(): Void {
		var navbarHeight = Std.parseInt(Browser.window.getComputedStyle(Browser.document.documentElement).getPropertyValue("--navbar-height"));
		if (navbarHeight == null) navbarHeight = 0;

		final style = Browser.document.documentElement.style;
		style.setProperty("--main-offset", '${navbarHeight + root.offsetHeight}px');
		beforeUnmounting(() -> style.removeProperty("--main-offset"));
	}
}
