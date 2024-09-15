package belin_core.io;

import haxe.io.Mime;

/** Tests the features of the `File` class. **/
@:asserts final class FileTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `toDataUrl()` method. **/
	public function toDataUrl() {
		final base64 = Sys.systemName() == "Windows" ? "Q8OpZHJpYyBCZWxpbiA8Y2VkcmljQGJlbGluLmlvPg0K" : "Q8OpZHJpYyBCZWxpbiA8Y2VkcmljQGJlbGluLmlvPgo=";
		final url = new File("AUTHORS.txt").toDataUrl(Mime.TextPlain);
		return assert(url == 'data:text/plain;base64,$base64');
	}
}
