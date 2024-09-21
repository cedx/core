package belin_core.data;

/** Tests the features of the `Errors` class. **/
@:asserts final class ErrorsTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `get()` method. **/
	public function get() {
		final errors = new Errors(["foo" => "bar"]);
		asserts.assert(errors["foo"].equals("bar"));
		asserts.assert(errors["baz"] == None);
		return asserts.done();
	}

	/** Tests the `ofError()` method. **/
	@:variant(new tink.core.Error("message"), ["_" => "message"])
	@:variant(tink.core.Error.withData("message", [["foo", "bar"]]), ["foo" => "bar"])
	@:variant(tink.core.Error.withData("message", '{"details": [["baz", "qux"]]}'), ["baz" => "qux"])
	public function ofError(input: Error, output: Map<String, String>)
		return compare(output, (input: Errors));

	/** Tests the `toError()` method. **/
	@:variant([], [])
	@:variant(["foo" => "bar"], [["foo", "bar"]])
	@:variant(["foo" => "bar", "baz" => "qux"], [["foo", "bar"], ["baz", "qux"]])
	public function toError(input: Map<String, String>, output: Array<Array<String>>) {
		final data: Array<Array<String>> = (new Errors(input): Error).data;
		asserts.assert(data.length == output.length);

		final keys = data.map(entry -> entry[0]);
		final values = data.map(entry -> entry[1]);
		for (entry in output) {
			asserts.assert(keys.contains(entry[0]));
			asserts.assert(values.contains(entry[1]));
		}

		return asserts.done();
	}

	/** Tests the `with()` method. **/
	public function with() {
		final errors = new Errors(["foo" => "bar"]);
		final copy = errors.with("baz", "qux");
		asserts.assert(copy != errors);
		asserts.assert(copy.length == 2);
		return asserts.done();
	}

	/** Tests the `without()` method. **/
	public function without() {
		final errors = new Errors(["foo" => "bar"]);
		final copy = errors.without("foo");
		asserts.assert(copy != errors);
		asserts.assert(copy.length == 0);
		return asserts.done();
	}
}
