package belin_core;

using belin_core.NumberTools;

/** Tests the features of the `NumberTools` class. **/
final class NumberToolsTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `round()` method. **/
	@:variant(123.456, 0, 123)
	@:variant(123.456, 1, 123.5)
	@:variant(123.456, 2, 123.46)
	public function round(input: Float, precision: Int, output: Float)
		return assert(input.round(precision) == output);
}
