package belin_core.net;

using StringTools;

/** Represents an IP address. **/
@:jsonParse(json -> new belin_core.net.InternetAddress(json))
@:jsonStringify(internetAddress -> internetAddress.toString())
abstract InternetAddress(String) {

	/** The regular expression used to validate an IPv4 address. **/
	public static final ipv4Pattern = ~/^(?:(?:2(?:[0-4][\d]|5[0-5])|[0-1]?[\d]?[\d])\.){3}(?:(?:2([0-4][\d]|5[0-5])|[0-1]?[\d]?[\d]))$/;

	/** The regular expression used to validate an IPv6 address. **/
	public static final ipv6Pattern = ~/^(([a-f\d]{1,4}:){7,7}[a-f\d]{1,4}|([a-f\d]{1,4}:){1,7}:|([a-f\d]{1,4}:){1,6}:[a-f\d]{1,4}|([a-f\d]{1,4}:){1,5}(:[a-f\d]{1,4}){1,2}|([a-f\d]{1,4}:){1,4}(:[a-f\d]{1,4}){1,3}|([a-f\d]{1,4}:){1,3}(:[a-f\d]{1,4}){1,4}|([a-f\d]{1,4}:){1,2}(:[a-f\d]{1,4}){1,5}|[a-f\d]{1,4}:((:[a-f\d]{1,4}){1,6})|:((:[a-f\d]{1,4}){1,7}|:)|fe80:(:[a-f\d]{0,4}){0,4}%[a-z\d]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[\d]){0,1}[\d])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[\d]){0,1}[\d])|([a-f\d]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[\d]){0,1}[\d])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[\d]){0,1}[\d]))$/i;

	/** The IPv6 numeric address. **/
	public var address(get, never): String;
		function get_address() return type == IPv4 ? '::ffff:$this' : this;

	/** Value indicating whether this IP address is empty. **/
	public var isEmpty(get, never): Bool;
		function get_isEmpty() return this.length == 0;

	/** Value indicating whether this IP address is valid. **/
	public var isValid(get, never): Bool;
		function get_isValid() return type == IPv4 ? ipv4Pattern.match(this) : ipv6Pattern.match(this);

	/** The address family. **/
	public var type(get, never): InternetAddressType;
		function get_type() return this.contains(":") ? IPv6 : IPv4;

	/** Creates a new IP address. **/
	public function new(value: String)
		this = sanitize(value.trim().toLowerCase());

	/** Creates a new IP address from the specified string. **/
	@:from static inline function ofString(value: String): InternetAddress
		return new InternetAddress(value);

	/** Returns a string representation of this object. **/
	@:to public inline function toString(): String
		return this;

	/** Sanitizes the specified IP address. **/
	static function sanitize(value: String): String {
		final parts = value.split(":");
		if (parts.length == 2) return parts[0];
		final pattern = ~/^\[(.+)](:\d+)?$/;
		return pattern.match(value) ? pattern.matched(1) : value;
	}
}

/** Defines the address family of an IP address. **/
enum InternetAddressType {

	/** An IPv4 address. **/
	IPv4;

	/** An IPv6 address. **/
	IPv6;
}
