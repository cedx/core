package belin_core.net;

/** Tests the features of the `Url` class. **/
final class UrlTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `isEmpty` property. **/
	@:variant("", true)
	@:variant(" \r\n ", true)
	@:variant("belin.io", false)
	@:variant("https://www.belin.io/path?query=search#fragment", false)
	public function isEmpty(input: String, output: Bool)
		return assert(new Url(input).isEmpty == output);

	/** Tests the `isValid` property. **/
	@:variant("", false)
	@:variant("belin.io", true)
	@:variant("https://www.belin.io/path?query=search#fragment", true)
	public function isValid(input: String, output: Bool)
		return assert(new Url(input).isValid == output);

	/** Tests the `ofString()` method. **/
	@:variant("belin.io", "https://belin.io")
	@:variant("https://www.belin.io/path?query=search#fragment", "https://www.belin.io/path?query=search#fragment")
	public function ofString(input: String, output: String)
		return assert((input: Url) == output);
}
