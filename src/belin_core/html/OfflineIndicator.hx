package belin_core.html;

import coconut.ui.Children;
import coconut.ui.View;
import js.Browser;

/** A component that shows up when the network is unavailable, and hides when connectivity is restored. **/
class OfflineIndicator extends View {

	/** The view children. **/
	@:children var nodes: Children;

	/** Value indicating whether the browser is online. **/
	@:state var isOnline: Bool = Browser.navigator.onLine;

	/** Renders this view. **/
	function render() '
		<if ${isOnline}>${...nodes}</if>
	';

	/** Method invoked after this view is mounted. **/
	override function viewDidMount(): Void {
		final handler = () -> isOnline = Browser.navigator.onLine;
		for (event in ["online", "offline"]) Browser.window.addEventListener(event, handler, {passive: true});
		beforeUnmounting(() -> for (event in ["online", "offline"]) Browser.window.removeEventListener(event, handler));
	}
}
