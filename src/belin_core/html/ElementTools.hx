package belin_core.html;

import js.html.Element;
import js.lib.Promise as JsPromise;

/** Provides static extensions for HTML elements. **/
abstract class ElementTools {

	/** Removes all child nodes from the specified `element`. **/
	public static function removeChildren(element: Element): Void
		while (element.hasChildNodes()) element.removeChild(element.lastChild);

	/** Returns a promise that resolves when the specified `element` has finished all its animations. **/
	public static function waitForAnimations(element: Element, ?callback: Callback<Noise>): Promise<Noise>
		return JsPromise
			.allSettled(element.getAnimations().map(animation -> animation.finished))
			.toPromise()
			.noise();
}
