package belin_core.html;

import js.Browser;
using belin_core.html.ElementTools;

/** Tests the features of the `ElementTools` class. **/
@:asserts final class ElementToolsTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `removeChildren()` method. **/
	public function removeChildren() {
		final element = Browser.document.createDivElement();
		element.appendChild(Browser.document.createParagraphElement());
		asserts.assert(element.hasChildNodes());

		element.removeChildren();
		asserts.assert(!element.hasChildNodes());
		return asserts.done();
	}
}
