package belin_core.net;

using StringTools;

/** Represents a phone number. **/
@:jsonParse(json -> new belin_core.net.PhoneNumber(json))
@:jsonStringify(phoneNumber -> phoneNumber.toString())
abstract PhoneNumber(String) {

	/** The regular expression used to validate a phone number. **/
	public static final pattern = ~/^[+0]\d{9,}$/;

	/** Value indicating whether this phone number is empty. **/
	public var isEmpty(get, never): Bool;
		function get_isEmpty() return this.length == 0;

	/** Value indicating whether this phone number is valid. **/
	public var isValid(get, never): Bool;
		inline function get_isValid() return pattern.match(this);

	/** Creates a new phone number. **/
	public function new(value: String)
		this = normalize(value.trim());

	/** Creates a new phone number from the specified string. **/
	@:from static inline function ofString(value: String): PhoneNumber
		return new PhoneNumber(value);

	/** Returns a string representation of this object. **/
	@:to public inline function toString(): String
		return this;

	/** Formats this phone number. **/
	public function format(): String {
		if (this.length == 0) return "";
		final prefix = this.startsWith("+33") ? "0" : '${this.substr(0, 3)} ';
		return prefix + StringTools.reverse(StringTools.split(StringTools.reverse(this.substr(3)), 2).join(" "));
	}

	/** Normalizes the specified phone number. **/
	static function normalize(value: String): String {
		if (value.startsWith("00")) value = '+${value.substr(2)}';
		else if (value.startsWith("0")) value = '+33${value.substr(1)}';
		return ~/[\s\/.,;:-]/g.replace(value, "");
	}
}
