package belin_core.net;

#if php
import php.Const;
import php.Global;
#end
using StringTools;

/** Represents a mail address. **/
@:jsonParse(json -> new belin_core.net.MailAddress(json))
@:jsonStringify(mailAddress -> mailAddress.toString())
abstract MailAddress(String) {

	/** The regular expression used to validate a mail address. **/
	public static final pattern = ~/^[a-z\d!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z\d!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z\d](?:[a-z\d-]*[a-z\d])?\.)+[a-z\d](?:[a-z\d-]*[a-z\d])?$/i;

	/** The host portion of the address. **/
	public var host(get, never): String;
		function get_host() return this.split("@").pop() ?? "";

	/** Value indicating whether this mail address is empty. **/
	public var isEmpty(get, never): Bool;
		function get_isEmpty() return this.length == 0;

	/** Value indicating whether this mail address is valid. **/
	public var isValid(get, never): Bool;
		inline function get_isValid() return pattern.match(this);

	/** The user information. **/
	public var user(get, never): String;
		function get_user() return this.split("@").shift() ?? "";

	/** Creates a new mail address. **/
	public function new(value: String)
		this = value.trim().toLowerCase();

	/** Creates a new mail address from the specified string. **/
	@:from static inline function ofString(value: String): MailAddress
		return new MailAddress(value);

	/** Returns a string representation of this object. **/
	@:to public inline function toString(): String
		return this;

	#if php
	/** Returns a value indicating whether DNS records are valid for this address. **/
	public function checkDns(): Bool
		return isValid && (hasDnsRecord(true) || hasDnsRecord(false));

	/** Returns a value indicating whether DNS records exist for the host part of this address. **/
	function hasDnsRecord(isMX = false): bool {
		final normalizedHost = '${Global.idn_to_ascii(host, Const.IDNA_NONTRANSITIONAL_TO_ASCII)}.';
		final getDnsRecords = () -> Global.dns_get_record(normalizedHost, isMX ? Const.DNS_MX : Const.DNS_A);
		return Global.checkdnsrr(normalizedHost, isMX ? "MX" : "A") || switch Error.catchExceptions(getDnsRecords) {
			case Failure(_): false;
			case Success(records): records && Global.count(records) > 0;
		}
	}
	#end
}
