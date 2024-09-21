package belin_core;

using belin_core.StringTools;

/** Tests the features of the `StringTools` class. **/
final class StringToolsTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `capitalize()` method. **/
	@:variant("", "")
	@:variant("foo bAr baZ", "Foo bAr baZ")
	public function capitalize(input: String, output: String)
		return assert(input.capitalize() == output);

	/** Tests the `newLineToBr()` method. **/
	@:variant("", "")
	@:variant("foo\nbar", "foo<br>bar")
	@:variant("foo \r\n bar \r\n baz", "foo <br> bar <br> baz")
	public function newLineToBr(input: String, output: String)
		return assert(input.newLineToBr() == output);

	/** Tests the `reverse()` method. **/
	@:variant("", "")
	@:variant("foo bar", "rab oof")
	@:variant("Cédric", "cirdéC")
	public function reverse(input: String, output: String)
		return assert(input.reverse() == output);

	/** Tests the `split()` method. **/
	@:variant("", 1, [])
	@:variant("a", 1, ["a"])
	@:variant("foo", 1, ["f", "o", "o"])
	@:variant("foo", 2, ["fo", "o"])
	@:variant("foobar", 3, ["foo", "bar"])
	@:variant("foo", 4, ["foo"])
	public function split(input: String, splitLenght: Int, output: Array<String>)
		return compare(output, StringTools.split(input, splitLenght));

	/** Tests the `stripTags()` method. **/
	@:variant("", "")
	@:variant("> foo / bar <", "> foo / bar <")
	@:variant('<p>Test paragraph.</p><!-- Comment --> <a href="#fragment">Other text</a>.', "Test paragraph. Other text.")
	public function stripTags(input: String, output: String)
		return assert(input.stripTags() == output);

	/** Tests the `truncate()` method. **/
	@:variant("", 0, "...", "")
	@:variant("foo bar", 7, "...", "foo bar")
	@:variant("foo bar", 0, "...", "...")
	@:variant("foo bar", 4, "...", "foo ...")
	@:variant("foo bar", 0, "--", "--")
	@:variant("foo bar", 4, "--", "foo --")
	public function truncate(input: String, length: Int, suffix: String, output: String)
		return assert(input.truncate(length, suffix) == output);
}
