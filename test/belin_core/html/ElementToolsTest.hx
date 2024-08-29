package belin_core.html;

import js.Browser;
using belin_core.html.ElementTools;

/** Tests the features of the `ElementTools` class. **/
@:asserts final class ElementToolsTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `removeChildren()` method. **/
	public function removeChildren() {
		final div = Browser.document.createDivElement();
		div.appendChild(Browser.document.createParagraphElement());
		asserts.assert(div.hasChildNodes());

		div.removeChildren();
		asserts.assert(!div.hasChildNodes());
		return asserts.done();
	}
}
