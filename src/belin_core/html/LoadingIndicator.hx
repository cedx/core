package belin_core.html;

import coconut.ui.Children;
import coconut.ui.View;
import js.Browser;

/** A component that shows up when an HTTP request starts, and hides when all concurrent HTTP requests are completed. **/
class LoadingIndicator extends View {

	/** The view children. **/
	@:children var nodes: Children;

	/** Value indicating whether this indicator is hidden. **/
	@:state var hidden = true;

	/** The number of concurrent HTTP requests. **/
	var requestCount = 0;

	/** Starts the loading indicator. **/
	public function start(): Void {
		requestCount++;
		Browser.document.body.classList.add("loading");
		Callback.defer(() -> hidden = false);
	}

	/** Stops the loading indicator. **/
	public function stop(force = false): Void {
		requestCount--;
		if (force || requestCount <= 0) {
			requestCount = 0;
			Browser.document.body.classList.remove("loading");
			Callback.defer(() -> hidden = true);
		}
	}

	/** Renders this view. **/
	function render() '
		<div hidden=$hidden>${...nodes}</div>
	';
}
