package belin_core.security;

/** Defines the access level associated to a feature or a permission. **/
enum abstract AccessLevel(String) from String to String {

	/** The read access. **/
	var Read = "read";

	/** The write access. **/
	var Write = "write";

	/** The administrator access. **/
	var Admin = "admin";

	/** Returns a value indicating whether this access level is greater than the specified one. **/
	@:op(a > b) function greaterThan(other: AccessLevel): Bool
		return switch abstract {
			case Read: false;
			case Write: other == Read;
			case Admin: other == Read || other == Write;
		}

	/** Returns a value indicating whether this access level is greater than or equal to the specified one. **/
	@:op(a >= b) function greaterThanOrEqual(other: AccessLevel): Bool
		return switch abstract {
			case Read: other == Read;
			case Write: other == Read || other == Write;
			case Admin: true;
		}

	/** Returns a value indicating whether this access level is less than the specified one. **/
	@:op(a < b) inline function lessThan(other: AccessLevel): Bool
		return !greaterThanOrEqual(other);

	/** Returns a value indicating whether this access level is less than or equal to the specified one. **/
	@:op(a <= b) inline function lessThanOrEqual(other: AccessLevel): Bool
		return !greaterThan(other);
}
