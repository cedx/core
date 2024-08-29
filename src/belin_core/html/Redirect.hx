package core.html;

import coconut.ui.View;

/** Navigates to a new location. **/
class Redirect<Route: EnumValue> extends View {

	/** Value indicating whether to push a new entry onto the history instead of replacing the current one. **/
	@:attribute var push = false;

	/** The routing service. **/
	@:attribute var router: Router<Route>;

	/** The route to redirect to. **/
	@:attribute var to: Route;

	/** Renders this view. **/
	inline function render() return null;

	/** Method invoked after this view is mounted. **/
	override function viewDidMount(): Void
		Callback.defer(() -> push ? router.push(to) : router.replace(to));
}
