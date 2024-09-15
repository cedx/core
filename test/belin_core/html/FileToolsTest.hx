package belin_core.html;

import haxe.io.Mime;
import js.html.File;
using belin_core.html.FileTools;

/** Tests the features of the `FileTools` class. **/
@:asserts final class FileToolsTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `toDataUrl()` method. **/
	public function toDataUrl() {
		new File(["Hello World!"], "hello.txt", {type: Mime.TextPlain}).toDataUrl()
			.next(url -> asserts.assert(url == "data:text/plain;base64,SGVsbG8gV29ybGQh"))
			.handle(asserts.handle);

		return asserts;
	}
}
