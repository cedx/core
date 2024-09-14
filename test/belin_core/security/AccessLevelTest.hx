package belin_core.security;

/** Tests the features of the `AccessLevel` enumeration. **/
final class AccessLevelTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `greaterThan()` method. **/
	@:variant(Read, Read, false)
	@:variant(Read, Write, false)
	@:variant(Read, Admin, false)
	@:variant(Write, Read, true)
	@:variant(Write, Write, false)
	@:variant(Write, Admin, false)
	@:variant(Admin, Read, true)
	@:variant(Admin, Write, true)
	@:variant(Admin, Admin, false)
	public function greaterThan(x: AccessLevel, y: AccessLevel, output: Bool)
		return assert((x > y) == output);

	/** Tests the `greaterThanOrEqual()` method. **/
	@:variant(Read, Read, true)
	@:variant(Read, Write, false)
	@:variant(Read, Admin, false)
	@:variant(Write, Read, true)
	@:variant(Write, Write, true)
	@:variant(Write, Admin, false)
	@:variant(Admin, Read, true)
	@:variant(Admin, Write, true)
	@:variant(Admin, Admin, true)
	public function greaterThanOrEqual(x: AccessLevel, y: AccessLevel, output: Bool)
		return assert((x >= y) == output);

	/** Tests the `lessThan()` method. **/
	@:variant(Read, Read, false)
	@:variant(Read, Write, true)
	@:variant(Read, Admin, true)
	@:variant(Write, Read, false)
	@:variant(Write, Write, false)
	@:variant(Write, Admin, true)
	@:variant(Admin, Read, false)
	@:variant(Admin, Write, false)
	@:variant(Admin, Admin, false)
	public function lessThan(x: AccessLevel, y: AccessLevel, output: Bool)
		return assert((x < y) == output);

	/** Tests the `lessThanOrEqual()` method. **/
	@:variant(Read, Read, true)
	@:variant(Read, Write, true)
	@:variant(Read, Admin, true)
	@:variant(Write, Read, false)
	@:variant(Write, Write, true)
	@:variant(Write, Admin, true)
	@:variant(Admin, Read, false)
	@:variant(Admin, Write, false)
	@:variant(Admin, Admin, true)
	public function lessThanOrEqual(x: AccessLevel, y: AccessLevel, output: Bool)
		return assert((x <= y) == output);
}
