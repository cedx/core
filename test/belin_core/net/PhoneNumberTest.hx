package belin_core.net;

/** Tests the features of the `PhoneNumber` class. **/
final class PhoneNumberTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the constructor. **/
	@:variant("0032 / 467.123.456", "+32467123456")
	@:variant("04-67-12-34-56", "+33467123456")
	public function testNew(input: String, output: String)
		return assert((new PhoneNumber(input): String) == output);

	/** Tests the `isEmpty` property. **/
	@:variant("", true)
	@:variant(" \r\n ", true)
	@:variant("0467123456", false)
	public function isEmpty(input: String, output: Bool)
		return assert(new PhoneNumber(input).isEmpty == output);

	/** Tests the `isValid` property. **/
	@:variant("", false)
	@:variant("+33 467 foo 123 bar 456", false)
	@:variant("+32 / 467.123.456", true)
	@:variant("04-67-12-34-56", true)
	public function isValid(input: String, output: Bool)
		return assert(new PhoneNumber(input).isValid == output);

	/** Tests the `format()` method. **/
	@:variant("0467123456", "04 67 12 34 56")
	@:variant("+32467123456", "+32 4 67 12 34 56")
	@:variant("0032467123456", "+32 4 67 12 34 56")
	@:variant("+33467123456", "04 67 12 34 56")
	public function format(input: String, output: String)
		return assert(new PhoneNumber(input).format() == output);

	/** Tests the `ofString()` method. **/
	@:variant("0032 / 467.123.456", "+32467123456")
	@:variant("04-67-12-34-56", "+33467123456")
	public function ofString(input: String, output: String)
		return assert((input: PhoneNumber) == output);
}
