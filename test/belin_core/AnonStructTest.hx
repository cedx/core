package belin_core;

import haxe.DynamicAccess;

/** Tests the features of the `AnonStruct` class. **/
@:asserts final class AnonStructTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `assign()` method. **/
	@:variant({}, {foo: "bar"}, {foo: "bar"})
	@:variant({foo: "bar"}, {baz: "qux"}, {foo: "bar", baz: "qux"})
	@:variant({foo: "bar", bar: {baz: "qux"}}, {foo: "123", bar: "456"}, {foo: "123", bar: "456"})
	@:variant({foo: "123", bar: {baz: "456"}}, {foo: "ABC", bar: {qux: "DEF"}}, {foo: "ABC", bar: {qux: "DEF"}})
	public function assign(target: DynamicAccess<Any>, source: DynamicAccess<Any>, output: DynamicAccess<Any>)
		return compare(output, AnonStruct.assign(target, source));

	/** Tests the `getNames()` method. **/
	public function getNames() {
		asserts.compare(["bool", "float", "integer", "string"], AnonStruct.getNames(SampleAnon, false));
		asserts.compare(["bool", "?float", "integer", "?string"], AnonStruct.getNames(SampleAnon, true));
		return asserts.done();
	}

	/** Tests the `merge()` method. **/
	@:variant({}, {foo: "bar"}, {foo: "bar"})
	@:variant({foo: "bar"}, {baz: "qux"}, {foo: "bar", baz: "qux"})
	@:variant({foo: "bar", bar: {baz: "qux"}}, {foo: "123", bar: "456"}, {foo: "123", bar: "456"})
	@:variant({foo: "123", bar: {baz: "456"}}, {foo: "ABC", bar: {qux: "DEF"}}, {foo: "ABC", bar: {baz: "456", qux: "DEF"}})
	public function merge(target: DynamicAccess<Any>, source: DynamicAccess<Any>, output: DynamicAccess<Any>)
		return compare(output, AnonStruct.merge(target, source));

	/** Tests the `trim()` method. **/
	@:variant({}, {})
	@:variant({prop1: 123, prop2: " foo ", prop3: "\n456\n", prop4: " \t bar \t "}, {prop1: 123, prop2: "foo", prop3: "456", prop4: "bar"})
	public function trim(input: {}, output: {})
		return compare(output, AnonStruct.trim(input));
}

/** A sample anonymous structure. **/
private typedef SampleAnon = {
	var bool: Bool;
	var ?float: Float;
	var integer: Int;
	var ?string: String;
}
