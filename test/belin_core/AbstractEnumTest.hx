package belin_core;

/** Tests the features of the `AbstractEnum` class. **/
@:asserts final class AbstractEnumTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `getNames()` method. **/
	public function getNames() {
		asserts.compare(["Zero", "Ten", "Eleven"], AbstractEnum.getNames(IntEnum));
		asserts.compare(["FirstCase", "AnotherCase"], AbstractEnum.getNames(StringEnum));
		return asserts.done();
	}

	/** Tests the `getValues()` method. **/
	public function getValues() {
		asserts.compare([0, 10, 11], AbstractEnum.getValues(IntEnum));
		asserts.compare(["FirstCase", "another_case"], AbstractEnum.getValues(StringEnum));
		return asserts.done();
	}
}

/** A sample enum abstract with integer values. **/
private enum abstract IntEnum(Int) {
	var Zero;
	var Ten = 10;
	var Eleven;
}

/** A sample enum abstract with string values. **/
private enum abstract StringEnum(String) {
	var FirstCase;
	var AnotherCase = "another_case";
}
